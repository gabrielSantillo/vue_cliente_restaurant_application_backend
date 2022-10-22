from flask import request, make_response
from apihelpers import check_endpoint_info
import secrets
import json
from dbhelpers import run_statement

def post():
    is_valid = check_endpoint_info(request.json, ['email', 'password'])
    if(is_valid != None):
        return make_response(json.dumps(is_valid, default=str), 400)

    token = secrets.token_hex(nbytes=None)
    results = run_statement('CALL log_in_restaurant(?,?,?)', [request.json.get('email'), request.json.get('password'), token])

    if(type(results) == list and len(results) > 0):
        return make_response(json.dumps(results[0], default=str), 200)
    elif(type(results) == list and len(results) == 0):
        return make_response(json.dumps("Bad request"), 400)
    else:
        return make_response(json.dumps("Sorry, an error has occurred"), 500)