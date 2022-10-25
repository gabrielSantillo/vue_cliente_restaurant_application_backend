from flask import request, make_response
from apihelpers import check_endpoint_info
import json
from dbhelpers import run_statement

def post():
    is_valid_header = check_endpoint_info(request.headers, ['token'])
    if(is_valid_header != None):
        return make_response(json.dumps(is_valid_header, default=str), 400)

    is_valid = check_endpoint_info(request.json,['menu_items', 'restaurant_id'])
    if(is_valid != None):
        return make_response(json.dumps(is_valid, default=str), 400)

    order_id = run_statement('CALL client_order(?,?)',[request.headers.get('token'), request.json.get('restaurant_id')])


    items = request.json.get('menu_items')

    for item in items:
        items_added = run_statement('CALL add_item_to_order(?,?)', [order_id[0][0], item])
 

    if(type(order_id) == list and len(order_id) == 1 and len(items_added) != 0):
        return make_response(json.dumps(order_id[0][0], default=str), 200)
    elif(type(order_id) == list and len(order_id) == 1 and len(items_added) == 0):
        return make_response(json.dumps("Bad request"), 400)
    else:
        return make_response(json.dumps("Sorry, an error has occurred."), 500)


def get():
    is_valid_header = check_endpoint_info(request.headers, ['token'])
    if(is_valid_header != None):
        return make_response(json.dumps(is_valid_header, default=str), 400)


    is_confirmed = request.args.get('is_confirmed')
    is_completed = request.args.get('is_complete')
    if(is_confirmed == None and is_completed == None):
        results = run_statement('CALL get_all_client_order(?)', [request.headers.get('token')])
    elif(is_confirmed != None and is_completed == None):
        results = run_statement('CALL get_all_confirmed_orders(?)', [request.headers.get('token')])
    else:
        results = run_statement('CALL get_all_completed_orders(?)', [request.headers.get('token')])


    if(type(results) == list):
        return make_response(json.dumps(results, default=str), 200)
    else:
        return make_response(json.dumps("Sorry, an error has occurred."), 500)
    