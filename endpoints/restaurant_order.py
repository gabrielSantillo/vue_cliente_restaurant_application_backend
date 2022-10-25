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