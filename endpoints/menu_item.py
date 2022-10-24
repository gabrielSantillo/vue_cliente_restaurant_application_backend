from uuid import uuid4
from flask import request, make_response
from apihelpers import check_endpoint_info, check_data_sent
import secrets
import json
from dbhelpers import run_statement

def post():
    is_valid = check_endpoint_info(request.json, ['description', 'image_url',
    'name', 'price'])
    if(is_valid != None):
        return make_response(json.dumps(is_valid, default=str), 400)

    is_valid_header = check_endpoint_info(request.headers, ['token'])
    if(is_valid_header != None):
        return make_response(json.dumps(is_valid_header, default=str), 400)

    results = run_statement('CALL add_menu_item(?,?,?,?,?)', [request.json.get('description'), request.json.get('image_url'), request.json.get('name'), request.json.get('price'), request.headers.get('token')])

    if(type(results) == list and results[0][0] == 1):
        return make_response(json.dumps(results[0][0], default=str), 200)
    if(type(results) == list and results[0][0] == 0):
        return make_response(json.dumps("Bad request"), 400)
    else:
        return make_response(json.dumps("Sorry, an error has occurred."), 500)