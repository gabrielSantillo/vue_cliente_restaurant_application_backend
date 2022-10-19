from email.policy import default
from flask import Flask, request, make_response
from dbhelpers import run_statement
from apihelpers import check_endpoint_info
from dbcreds import production_mode
import json

# calling the Flask function which will return a value that I will be used for my API
app = Flask(__name__)


@app.post('/api/client')
def add_client():
    is_valid = check_endpoint_info(request.json, [
                                   'email', 'first_name', 'last_name', 'image_url', 'username', 'password'])

    if (is_valid != None):
        return make_response(json.dumps(is_valid, default=str), 400)

    results = run_statement('CALL add_client(?,?,?,?,?,?)', [request.json.get('email'), request.json.get('first_name'), request.json.get(
        'last_name'), request.json.get('image_url'), request.json.get('username'), request.json.get('password')])

    if (type(results) == list):
        return make_response(json.dumps(results[0], default=str), 200)
    else:
        return make_response(json.dumps("Sorry, an error has occurred."), 500)


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
