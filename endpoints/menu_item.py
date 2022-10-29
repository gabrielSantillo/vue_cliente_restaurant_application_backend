from flask import request, make_response
from apihelpers import check_endpoint_info, check_data_sent
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

    if(type(results) == list and results[0]['row_updated'] == 1):
        return make_response(json.dumps(results[0], default=str), 200)
    if(type(results) == list and results[0]['row_updated'] == 0):
        return make_response(json.dumps(results[0], default=str), 400)
    else:
        return make_response(json.dumps("Sorry, an error has occurred."), 500)

def get():
    is_valid = check_endpoint_info(request.args, ['restaurant_id'])
    if(is_valid != None):
        return make_response(json.dumps(is_valid, default=str), 400)

    results = run_statement('CALL get_menu_item(?)', [request.args.get('restaurant_id')])

    if(type(results) == list and len(results) != 0):
        return make_response(json.dumps(results[0], default=str), 200)
    elif(type(results) == list and len(results) == 0):
        return make_response(json.dumps("Wrong restaurant id."), 400)
    else:
        return make_response(json.dumps("Sorry an error has occurred"), 500)

def patch():
    menu_info = run_statement('CALL get_menu_item_by_token(?)', [request.headers.get('token')])
    if(type(menu_info) == list and len(menu_info) == 0):
        return make_response(json.dumps("Wrong token."), 400)

    is_valid = check_endpoint_info(request.json, ['menu_id'])
    if(is_valid != None):
        return make_response(json.dumps(is_valid, default=str), 400)

    for item in menu_info:
        if(item['id'] == int(request.json.get('menu_id'))):
            is_valid = item

    update_menu_item = check_data_sent(request.json, menu_info[0], ['menu_id', 'description', 'image_url', 'name', 'price'])

    if(request.json.get('name') == None):
        results = run_statement('CALL edit_menu_item_but_name(?,?,?,?,?)', [update_menu_item['description'], update_menu_item['image_url'], update_menu_item['price'], request.headers.get('token'),update_menu_item['menu_id']])
    else:
        results = run_statement('CALL edit_menu_item(?,?,?,?,?,?)', [update_menu_item['description'], update_menu_item['image_url'], update_menu_item['name'], update_menu_item['price'], request.headers.get('token'),update_menu_item['menu_id']])
    

    if(type(results) == list and results[0]['row_updated'] == 1):
        return make_response(json.dumps(results[0], default=str), 200)
    elif(type(results) == list and results[0]['row_updated'] == 0):
        return make_response(json.dumps(results, default=str), 400)
    else:
        return make_response(json.dumps("Sorry, an error has occurred"), 500)


def delete():
    is_valid = check_endpoint_info(request.json, ['menu_id'])
    if(is_valid != None):
        return make_response(json.dumps(is_valid, default=str), 400)

    is_valid_header = check_endpoint_info(request.headers, ['token'])
    if(is_valid_header != None):
        return make_response(json.dumps(is_valid_header, default=str), 400)

    results = run_statement('CALL delete_menu_item(?,?)', [request.json.get('menu_id'), request.headers.get('token')])

    if(type(results) == list and results[0]['row_updated'] == 1):
        return make_response(json.dumps(results[0], default=str), 200)
    elif(type(results) == list and results[0]['row_updated'] == 0):
        return make_response(json.dumps(results[0], default=str), 400)
    else:
        return make_response(json.dumps("Sorry, an error has occurred."), 500)