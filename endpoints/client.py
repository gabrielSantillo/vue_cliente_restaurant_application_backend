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


def get():
    is_valid = check_endpoint_info(request.args, ['client_id'])

    if (is_valid != None):
        return make_response(json.dumps(is_valid, default=str), 400)

    results = run_statement('CALL get_client(?)', [
                            request.args.get('client_id')])

    if (type(results) == list and len(results) > 0):
        return make_response(json.dumps(results[0], default=str), 200)
    elif (type(results) == list and len(results) == 0):
        return make_response(json.dumps("Sorry, this client doesn't exist.", default=str), 400)
    else:
        return make_response(json.dumps("Sorry, an error has occurred.", default=str), 500)


def patch():
    client_info = run_statement('CALL get_client_by_token(?)', [
                                request.headers.get('token')])

    update_info_client = check_data_sent(request.json, [
        'email', 'first_name', 'last_name', 'image_url', 'username', 'password'], client_info[0])

    results = run_statement('CALL edit_client(?,?,?,?,?,?,?)',
                            [update_info_client['email'], update_info_client['first_name'],
                             update_info_client['last_name'], update_info_client['image_url'], update_info_client['username'],
                                update_info_client['password'], request.headers.get('token')])

    if (type(results) == list and results[0][0] == 1):
        return make_response(json.dumps(results[0][0], default=str), 200)
    elif (type(results) == list and results[0][0] == 0):
        return make_response(json.dumps("Bad request."), 400)
    else:
        return make_response(json.dumps("Sorry, an error has occurred.", default=str), 500)

def delete():
    is_valid = check_endpoint_info(request.json, ['password'])
    if(is_valid != None):
        return make_response(json.dumps(is_valid, default=str), 400)

    is_valid_header = check_endpoint_info(request.headers, ['token'])
    if(is_valid_header != None):
        return make_response(json.dumps(is_valid_header, default=str), 400)

    results = run_statement('CALL delete_client(?,?)', [request.json.get('password'), request.headers.get('token')])

    if(type(results) == list and results[0][0] == 1):
        return make_response(json.dumps(results[0][0], default=str), 200)
    elif(type(results) == list and results[0][0] == 0):
        return make_response(json.dumps("Bad request."), 400)
    else:
        return make_response(json.dumps("Sorry, an error has occurred.", default=str), 500)
