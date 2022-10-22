from flask import request, make_response
from apihelpers import check_endpoint_info, check_data_sent
import secrets
import json
from dbhelpers import run_statement


def post():
    is_valid = check_endpoint_info(request.json, [
                                   'email', 'name', 'address', 'phone_number', 'bio', 'city', 'profile_url', 'banner_url', 'password'])

    if (is_valid != None):
        return make_response(json.dumps(is_valid, default=str), 400)

    token = secrets.token_hex(nbytes=None)

    results = run_statement('CALL add_restaurant(?,?,?,?,?,?,?,?,?,?)', [request.json.get('email'), request.json.get('name'),  request.json.get('address'),  request.json.get('phone_number'), request.json.get('bio'),
    request.json.get('city'),  request.json.get('profile_url'),  request.json.get('banner_url'),
    request.json.get('password'), token])

    if (type(results) == list):
        return make_response(json.dumps(results, default=str), 200)
    else:
        return make_response(json.dumps("Sorry, an error has occurred."), 500)
