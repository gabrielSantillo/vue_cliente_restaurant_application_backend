from flask import request, make_response
from apihelpers import check_endpoint_info, organize_rated_orders
import json
from dbhelpers import run_statement

# post request for the endpoint order-rate
def post():
    # verify if the data expected to be sent was sent indeed
    is_valid_header = check_endpoint_info(request.headers, ['token'])
    if(is_valid_header != None):
        return make_response(json.dumps(is_valid_header, default=str), 400)
    
    # verify if the data expected to be sent was sent indeed
    is_valid = check_endpoint_info(request.json, ['order_id', 'rate'])
    if(is_valid != None):
        return make_response(json.dumps(is_valid, default=str), 400)

    # calling a procedure that will rate an order
    results = run_statement('CALL rate_order(?,?,?)', [request.json.get('order_id'), request.json.get('rate'), request.headers.get('token')])

    # if results is a list and at 'row_updated' the value is 1, return a success response
    if(type(results) == list and results[0]['row_updated'] == 1):
        return make_response(json.dumps(results[0], default=str), 200)
    # if results is a list and at 'row_updated' the value is 0, return a failure response
    elif(type(results) == list and results[0]['row_updated'] == 0):
        return make_response(json.dumps(results[0], default=str), 400)
    # otherwise, return a db failure response
    else:
        return make_response(json.dumps("Sorry, an error has occurred"), 500)

# get request for the endpoint order-rate
def get():
    # verify if the data expected to be sent was sent indeed
    is_valid_header = check_endpoint_info(request.headers, ['token'])
    if(is_valid_header != None):
        return make_response(json.dumps(is_valid_header, default=str), 400)
    # calling a procedure that will get all rated orders that belongs to a client
    results = run_statement('CALL get_all_rated_orders(?)', [request.headers.get('token')])

    # calling a function that will organize the db response
    better_response = organize_rated_orders(results)

    # if results is a list and at 'row_updated' the value is 1, return a success response
    if(type(results) == list and len(results) > 0):
        return make_response(json.dumps(better_response, default=str), 200)
    # if results is a list and at 'row_updated' the value is 0, return a failure response
    elif(type(results) == list and len(results) == 0):
        return make_response(json.dumps("Wrong token"), 400)
    # otherwise, return a db failure response
    else:
        return make_response(json.dumps("Sorry, an error has occurred."), 500)

# get request for the endpoint order-rate
def patch():
    # verify if the data expected to be sent was sent indeed
    is_valid_header = check_endpoint_info(request.headers, ['token'])
    if(is_valid_header != None):
        return make_response(json.dumps(is_valid_header, default=str), 400)
    # verify if the data expected to be sent was sent indeed
    is_valid = check_endpoint_info(request.json, ['order_id', 'rate'])
    if(is_valid != None):
        return make_response(json.dumps(is_valid, default=str), 400)

    # calling a procedure that edit a rated order
    results = run_statement('CALL edit_rated_order(?,?,?)', [request.json.get('order_id'), request.json.get('rate'), request.headers.get('token')])

    # if results is a list and at 'row_updated' the value is 1, return a success response
    if(type(results) == list and results[0]['row_updated'] == 1):
        return make_response(json.dumps(results[0], default=str), 200)
    # if results is a list and at 'row_updated' the value is 0, return a failure response
    elif(type(results) == list and results[0]['row_updated'] == 0):
        return make_response(json.dumps(results[0], default=str), 400)
    # otherwise, return a db failure response
    else:
        return make_response(json.dumps("Sorry, an error has occurred."), 500)

# delete request for the endpoint order-rate
def delete():
    # verify if the data expected to be sent was sent indeed
    is_valid_header = check_endpoint_info(request.headers, ['token'])
    if(is_valid_header != None):
        return make_response(json.dumps(is_valid_header, default=str), 400)
    
    # verify if the data expected to be sent was sent indeed
    is_valid = check_endpoint_info(request.json, ['order_id'])
    if(is_valid != None):
        return make_response(json.dumps(is_valid, default=str), 400)
    
    # calling a procedure that will delete a rated order
    results = run_statement('CALL delete_rated_order(?,?)', [request.json.get('order_id'), request.headers.get('token')])

    # if results is a list and at 'row_updated' the value is 1, return a success response
    if(type(results) == list and results[0]['row_updated'] == 1):
        return make_response(json.dumps(results[0], default=str), 200)
    # if results is a list and at 'row_updated' the value is 0, return a failure response
    elif(type(results) == list and results[0]['row_updated'] == 0):
        return make_response(json.dumps(results[0], default=str), 400)
    # otherwise, return a db failure response
    else:
        return make_response(json.dumps("Sorry, an error has occurred."), 500)