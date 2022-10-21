import secrets
from tabnanny import check
from tkinter import N
from flask import Flask, request, make_response
from dbhelpers import run_statement
from apihelpers import check_endpoint_info
from dbcreds import production_mode
import json

# calling the Flask function which will return a value that I will be used for my API
app = Flask(__name__)


@app.post('/api/client')
def post_client():
    is_valid = check_endpoint_info(request.json, [
                                   'email', 'first_name', 'last_name', 'image_url', 'username', 'password'])

    if (is_valid != None):
        return make_response(json.dumps(is_valid, default=str), 400)

    token = secrets.token_hex(nbytes=None)
    results = run_statement('CALL add_client(?,?,?,?,?,?,?)', [request.json.get('email'), request.json.get('first_name'), request.json.get(
        'last_name'), request.json.get('image_url'), request.json.get('username'), request.json.get('password'), token])

    if (type(results) == list):
        return make_response(json.dumps(results[0], default=str), 200)
    else:
        return make_response(json.dumps("Sorry, an error has occurred."), 500)


@app.get('/api/client')
def get_client():
    is_valid = check_endpoint_info(request.args, ['client_id'])

    if (is_valid != None):
        return make_response(json.dumps(is_valid, default=str), 400)

    results = run_statement('CALL get_client(?)', [
                            request.args.get('client_id')])

    if (type(results) == list):
        return make_response(json.dumps(results[0], default=str), 200)
    else:
        return make_response(json.dumps("Sorry, an error has occurred.", default=str), 500)


@app.patch('/api/client')
def patch_client():
    is_valid = check_endpoint_info(request.json, [
                                   'email', 'first_name', 'last_name', 'image_url', 'username', 'password'])
    if (is_valid != None):
        return make_response(json.dumps(is_valid, default=str), 400)

    is_valid_header = check_endpoint_info(request.headers, ['token'])
    if(is_valid_header != None):
        return make_response(json.dumps(is_valid_header, default=str), 400)

    results = run_statement('CALL edit_client(?,?,?,?,?,?,?)',
    [request.json.get('email'), request.json.get('first_name'),
    request.json.get('last_name'), request.json.get('image_url'), request.json.get('username'), 
    request.json.get('password'), request.headers.get('token')])

    if(type(results) == list):
        return make_response(json.dumps(results, default=str), 200)
    else:
        return make_response(json.dumps("Sorry, an error has occurred.", default=str), 500)


@app.delete('/api/client')
def delete_client():
    is_valid = check_endpoint_info(request.json, ['password'])
    if(is_valid != None):
        return make_response(json.dumps(is_valid, default=str), 400)

    is_valid_header = check_endpoint_info(request.headers, ['token'])
    if(is_valid_header != None):
        return make_response(json.dumps(is_valid_header, default=str), 400)

    results = run_statement('CALL delete_client(?,?)', [request.json.get('password'), request.headers.get('token')])

    if(type(results) == list):
        return make_response(json.dumps(results, default=str), 200)
    else:
        return make_response(json.dumps("Sorry, an error has occurred.", default=str), 500)


@app.post('/api/client-login')
def log_in_client():
    is_valid = check_endpoint_info(request.json, ['email', 'password'])
    if(is_valid != None):
        return make_response(json.dumps(is_valid, default=str), 400)

    token = secrets.token_hex(nbytes=None)
    results = run_statement('CALL log_in_client(?,?,?)', [request.json.get('email'), request.json.get('password'), token])

    if(type(results) == list and len(results) != 0):
        return make_response(json.dumps(results[0], default=str), 200)
    elif(type(results) == list and len(results) == 0):
        return make_response(json.dumps("Bad login attempt. Your password or/and email are wrong."), 400)
    else:
        return make_response(json.dumps('Sorry, an error has occurred.'), 500)


@app.delete('/api/client-login')
def delete_client_token():
    is_valid = check_endpoint_info(request.json, ['token'])

    if(is_valid != None):
        return make_response(json.dumps(is_valid, default=str), 400)

    results = run_statement('CALL delete_client_token(?)', [request.json.get('token')])

    if(type(results) == list):
        return make_response(json.dumps(results[0][0], default=str), 200)
    else:
        return make_response(json.dumps("Sorry, an error has occured", default=str), 500)

# if statement to check if the production_mode variable is true, if yes, run in production mode, if not, run in testing mode
if (production_mode):
    print("Running in Production Mode")
    import bjoern  # type: ignore
    bjoern.run(app, "0.0.0.0", 5000)
else:
    from flask_cors import CORS
    CORS(app)
    print("Running in Testing Mode")
    app.run(debug=True)
