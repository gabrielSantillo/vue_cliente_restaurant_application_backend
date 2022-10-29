from uuid import uuid4
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
    salt = uuid4().hex

    results = run_statement('CALL add_restaurant(?,?,?,?,?,?,?,?,?,?,?)', [request.json.get('email'), request.json.get('name'),  request.json.get('address'),  request.json.get('phone_number'), request.json.get('bio'),
    request.json.get('city'),  request.json.get('profile_url'),  request.json.get('banner_url'),
    request.json.get('password'), token, salt])

    if (type(results) == list and len(results) > 0):
        return make_response(json.dumps(results[0], default=str), 200)
    elif(results.startswith('Duplicate entry')):
        return make_response(json.dumps(results, default=str), 400)
    else:
        return make_response(json.dumps("Sorry, an error has occurred."), 500)

def get():
    is_valid = check_endpoint_info(request.args, ['restaurant_id'])

    if(is_valid != None):
        return make_response(json.dumps(is_valid, default=str), 400)

    results = run_statement('CALL get_restaurant(?)', [request.args.get('restaurant_id')])

    if(type(results) == list and len(results) > 0):
        return make_response(json.dumps(results[0], default=str), 200)
    elif(type(results) == list and len(results) == 0):
        return make_response(json.dumps("Sorry, this restaurant doesn't exist"), 400)
    else:
        return make_response(json.dumps("Sorry, an error has occurred."), 500)

def patch():
    restaurant_info = run_statement('CALL get_restaurant_by_token(?)', [request.headers.get('token')])

    update_restaurant_info = check_data_sent(request.json, restaurant_info[0], ['email', 'name', 'address', 'phone_number', 'bio', 'city', 'profile_url', 'banner_url', 'password'])

    results = run_statement('CALL edit_restaurant(?,?,?,?,?,?,?,?,?,?)', [update_restaurant_info['email'], update_restaurant_info['name'], update_restaurant_info['address'], update_restaurant_info['phone_number'], update_restaurant_info['bio'], update_restaurant_info['city'], update_restaurant_info['profile_url'], update_restaurant_info['banner_url'], update_restaurant_info['password'], request.headers.get('token')])

    if(type(results) == list and results[0]['row_updated'] == 1):
        return make_response(json.dumps(results[0], default=str), 200)
    elif(type(results) == list and results[0]['row_updated'] == 0):
        return make_response(json.dumps("Bad request"), 400)
    else:
        return make_response(json.dumps("Sorry, an error has occurred"), 500)

def delete():
    is_valid = check_endpoint_info(request.json, ['password'])
    if(is_valid != None):
        return make_response(json.dumps(is_valid, default=str), 400)

    is_valid_header = check_endpoint_info(request.headers, ['token'])
    if(is_valid_header != None):
        return make_response(json.dumps(is_valid_header, default=str), 400)

    results = run_statement('CALL delete_restaurant(?,?)', [request.json.get('password'), request.headers.get('token')])

    if(type(results) == list and results[0]['row_updated'] == 1):
        return make_response(json.dumps(results[0], default=str), 200)
    elif(type(results) == list and results[0]['row_updated'] == 0):
        return make_response(json.dumps(results[0], default=str), 400)
    else:
        return make_response(json.dumps("Sorry, an error has occurred."), 500)


