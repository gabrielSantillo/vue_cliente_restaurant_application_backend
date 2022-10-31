from flask import request, make_response
from apihelpers import check_endpoint_info
import secrets
import json
from dbhelpers import run_statement

# post request for the endpoint client-login
def post():
    # verify if the data expected to be sent was sent indeed
    is_valid = check_endpoint_info(request.json, ['email', 'password'])
    if(is_valid != None):
        return make_response(json.dumps(is_valid, default=str), 400)

    # function that creates a token
    token = secrets.token_hex(nbytes=None)
    # calling the procedure that will log in a client
    results = run_statement('CALL log_in_client(?,?,?)', [request.json.get('email'), request.json.get('password'), token])

    # if results is a list and the length of it is different than zero, return a success response
    if(type(results) == list and len(results) != 0):
        return make_response(json.dumps(results[0], default=str), 200)
    # if results is a list and the length is zero, return a failure response
    elif(type(results) == list and len(results) == 0):
        return make_response(json.dumps("Bad login attempt. Your password or/and email are wrong."), 400)
    # otherwise, return a db failure response
    else:
        return make_response(json.dumps('Sorry, an error has occurred.'), 500)
        
# delete request for the endpoint client-login
def delete():
    # verify if the data expected to be sent was sent indeed
    is_valid = check_endpoint_info(request.headers, ['token'])
    if(is_valid != None):
        return make_response(json.dumps(is_valid, default=str), 400)

    # calling the procedure that will delete a client token
    results = run_statement('CALL delete_client_token(?)', [request.headers.get('token')])

    # if results is a list and at 'row_updated' the value is 1, return a success response
    if(type(results) == list and results[0]['row_updated'] == 1):
        return make_response(json.dumps(results[0], default=str), 200)
    # if results is a list and at 'row_updated' the value is 0, return a failure response
    elif(type(results) == list and results[0]['row_updated'] == 0):
        return make_response(json.dumps(results[0], default=str), 400)
    # otherwise, return a db failure response
    else:
        return make_response(json.dumps("Sorry, an error has occured", default=str), 500)