from flask import request, make_response
from apihelpers import check_endpoint_info, organize_response
import json
from dbhelpers import run_statement

def post():
    is_valid_header = check_endpoint_info(request.headers, ['token'])
    if(is_valid_header != None):
        return make_response(json.dumps(is_valid_header, default=str), 400)

    is_valid = check_endpoint_info(request.json, ['restaurant_id', 'order_id', 'rate'])
    if(is_valid != None):
        return make_response(json.dumps(is_valid, default=str), 400)

    results = run_statement('CALL rate_order(?,?,?,?)', [request.json.get('restaurant_id'), request.json.get('order_id'), request.json.get('rate'), request.headers.get('token')])

    if(type(results) == list and results[0][0] == 1):
        return make_response(json.dumps(results[0][0], default=str), 200)
    elif(type(results) == list and results[0][0] == 0):
        return make_response(json.dumps("BAD REQUEST."), 400)
    else:
        return make_response(json.dumps("Sorry, an error has occurred"), 500)