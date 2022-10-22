from flask import request, make_response
from apihelpers import check_endpoint_info, check_data_sent
import secrets
import json
from dbhelpers import run_statement

def post():
    is_valid = check_endpoint_info(request.json, [
                                   'email', 'first_name', 'last_name', 'image_url', 'username', 'password'])

    if (is_valid != None):
        return make_response(json.dumps(is_valid, default=str), 400)

    token = secrets.token_hex(nbytes=None)
    results = run_statement('CALL add_client(?,?,?,?,?,?,?)', [request.json.get('email'), request.json.get('first_name'), request.json.get(
        'last_name'), request.json.get('image_url'), request.json.get('username'), request.json.get('password'), token])

    if (type(results) == list):
        return make_response(json.dumps(results, default=str), 200)
    else:
        return make_response(json.dumps("Sorry, an error has occurred."), 500)
