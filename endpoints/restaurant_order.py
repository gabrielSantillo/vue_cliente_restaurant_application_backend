from flask import request, make_response
from apihelpers import check_endpoint_info
import json
from dbhelpers import run_statement

def get():
    is_valid_header = check_endpoint_info(request.headers, ['token'])
    if(is_valid_header != None):
        return make_response(json.dumps(is_valid_header, default=str), 400)

    results = run_statement('CALL get_all_restaurant_order(?)', [request.headers.get('token')])

    if(type(results) == list):
        return make_response(json.dumps(results, default=str), 200)
    else:
        return make_response(json.dumps("Sorry an error has occurred"), 500)

def patch():
    is_valid_header = check_endpoint_info(request.headers, ['token'])
    if(is_valid_header != None):
        return make_response(json.dumps(is_valid_header, default=str), 400)

    is_valid = check_endpoint_info(request.json, ['order_id'])
    if(is_valid != None):
        return make_response(json.dumps(is_valid, default=str), 400)

    confirm_order = request.json.get('is_confirmed')
    complete_order = request.json.get('is_complete')
    if(confirm_order != None and complete_order == None):
        results =  run_statement('CALL confirm_order(?,?,?)', [request.headers.get('token'), request.json.get('order_id'), request.json.get('is_confirmed')])
    elif(confirm_order == None and complete_order != None):
        results = run_statement('CALL complete_order(?,?,?)', [request.headers.get('token'), request.json.get('order_id') ,request.json.get('is_complete')])
    elif(confirm_order == None and complete_order == None):
        return make_response(json.dumps("No data sent, either to confirm or to complete an order."), 400)
    elif(confirm_order != None and complete_order != None):
        return make_response(json.dumps("You should first confirm an order, then complete it."), 400)

    if(type(results) == list):
        return make_response(json.dumps(results[0][0], default=str), 200)
    elif(results.startswith("Incorrect integer value:")):
        return make_response(json.dumps("Send true or false to confirm or complete your order."), 400)
    else:
        return make_response(json.dumps("Sorry, an error has occurred"), 500)