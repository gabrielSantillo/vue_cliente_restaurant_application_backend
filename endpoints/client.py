from uuid import uuid4
from flask import request, make_response
from apihelpers import check_endpoint_info, check_data_sent
import secrets
import json
from dbhelpers import run_statement

# post request for the endpoint client
def post():
    # verify if the data expected to be sent was sent indeed
    is_valid = check_endpoint_info(request.json, [
                                   'email', 'first_name', 'last_name', 'image_url', 'username', 'password'])
    if (is_valid != None):
        return make_response(json.dumps(is_valid, default=str), 400)

    # generating a ramdom token
    token = secrets.token_hex(nbytes=None)
    # generating a random salt
    salt = uuid4().hex
    # calling the procedure that add a clients in the db
    results = run_statement('CALL add_client(?,?,?,?,?,?,?,?)', [request.json.get('email'), request.json.get('first_name'), request.json.get(
        'last_name'), request.json.get('image_url'), request.json.get('username'), request.json.get('password'), token, salt])

    # if the results is a list and the length of the result is different than zero, return a success response
    if (type(results) == list and len(results) != 0):
        return make_response(json.dumps(results[0], default=str), 200)
    # otherwise, return a db failure response
    else:
        return make_response(json.dumps("Sorry, an error has occurred."), 500)

# get request for the endpoint client
def get():
    # verify if the data expected to be sent was sent indeed
    is_valid = check_endpoint_info(request.args, ['client_id'])
    if (is_valid != None):
        return make_response(json.dumps(is_valid, default=str), 400)

    # calling the procedure that will get the clients info
    results = run_statement('CALL get_client(?)', [
                            request.args.get('client_id')])

    # if the results is a list and the length of the result is different than zero, return a success response
    if (type(results) == list and len(results) != 0):
        return make_response(json.dumps(results[0], default=str), 200)
    # if results is a list and the length is zero, return a failure response
    elif (type(results) == list and len(results) == 0):
        return make_response(json.dumps("Sorry, this client doesn't exist.", default=str), 400)
    # otherwise, return a db failure response
    else:
        return make_response(json.dumps("Sorry, an error has occurred.", default=str), 500)

# patch request for the endpoint client
def patch():
    # verify if the data expected to be sent was sent indeed
    is_valid = check_endpoint_info(request.headers, ['token'])
    if(is_valid != None):
        return make_response(json.dumps(is_valid,default=str), 400)

    # calling the procedure that will get the clients info
    client_info = run_statement('CALL get_client_by_token(?)', [request.headers.get('token')])
    if(type(client_info) != list or len(client_info) != 1):
        return make_response(json.dumps(client_info, default=str), 400)
 
    # calling a function that will fill all information that was not sent by the client in the
    # to return all client info filled out
    update_info_client = check_data_sent(request.json, client_info[0],
      ['email', 'first_name', 'last_name', 'image_url', 'username', 'password'])

    # calling a procedure that edit the clients info
    results = run_statement('CALL edit_client(?,?,?,?,?,?,?)',
                            [update_info_client['email'], update_info_client['first_name'],
                             update_info_client['last_name'], update_info_client['image_url'], update_info_client['username'], update_info_client['password'], request.headers.get('token')])

    # if the results is a list and the length of the result at 'row_updated' is equal to one, return a success response
    if (type(results) == list and results[0]['row_updated'] == 1):
        return make_response(json.dumps(results[0], default=str), 200)
    # if the results is a list and the length of the result at 'row_updated' is equal to zero, return a success response
    elif (type(results) == list and results[0]['row_updated'] == 0):
        return make_response(json.dumps(results[0], default=str), 400)
    # otherwise, return a db failure response
    else:
        return make_response(json.dumps("Sorry, an error has occurred.", default=str), 500)

# patch request for the endpoint client
def delete():
    # verify if the data expected to be sent was sent indeed
    is_valid = check_endpoint_info(request.json, ['password'])
    if(is_valid != None):
        return make_response(json.dumps(is_valid, default=str), 400)

    # verify if the data expected to be sent was sent indeed
    is_valid_header = check_endpoint_info(request.headers, ['token'])
    if(is_valid_header != None):
        return make_response(json.dumps(is_valid_header, default=str), 400)

    # calling a procedure that edit the clients info
    results = run_statement('CALL delete_client(?,?)', [request.json.get('password'), request.headers.get('token')])

    # if the results is a list and the length of the result at 'row_updated' is equal to one, return a success response
    if(type(results) == list and results[0]['row_updated'] == 1):
        return make_response(json.dumps(results[0], default=str), 200)
    # if the results is a list and the length of the result at 'row_updated' is equal to zero, return a success response
    elif(type(results) == list and results[0]['row_updated'] == 0):
        return make_response(json.dumps("Bad request."), 400)
    # otherwise, return a db failure response
    else:
        return make_response(json.dumps("Sorry, an error has occurred.", default=str), 500)
