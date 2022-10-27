from flask import request, make_response
from apihelpers import check_endpoint_info, organize_rated_orders
import json
from dbhelpers import run_statement

def post():
    is_valid_header = check_endpoint_info(request.headers, ['token'])
    if(is_valid_header != None):
        return make_response(json.dumps(is_valid_header, default=str), 400)

    is_valid = check_endpoint_info(request.json, ['order_id', 'rate'])
    if(is_valid != None):
        return make_response(json.dumps(is_valid, default=str), 400)

    rate = int(request.json.get('rate'))
    if(rate >= 1 and rate <= 5):
        results = run_statement('CALL rate_order(?,?,?)', [request.json.get('order_id'), request.json.get('rate'), request.headers.get('token')])
    else:
        return make_response(json.dumps("Wrong range value. Only 1 to 5 are accepted to rate an order."), 400)

    if(type(results) == list and results[0][0] == 1):
        return make_response(json.dumps(results[0][0], default=str), 200)
    elif(type(results) == list and results[0][0] == 0):
        return make_response(json.dumps("BAD REQUEST."), 400)
    else:
        return make_response(json.dumps("Sorry, an error has occurred"), 500)

def get():
    is_valid_header = check_endpoint_info(request.headers, ['token'])
    if(is_valid_header != None):
        return make_response(json.dumps(is_valid_header, default=str), 400)

    results = run_statement('CALL get_all_rated_orders(?)', [request.headers.get('token')])

    better_response = organize_rated_orders(results)

    if(type(results) == list and len(results) > 0):
        return make_response(json.dumps(better_response, default=str), 200)
    elif(type(results) == list and len(results) == 0):
        return make_response(json.dumps("Wrong token"), 400)
    else:
        return make_response(json.dumps("Sorry, an error has occurred."), 500)