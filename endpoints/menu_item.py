from flask import request, make_response
from apihelpers import check_endpoint_info, check_data_sent
import json
from dbhelpers import run_statement

# post request for the endpoint menu-item
def post():
    # verify if the data expected to be sent was sent indeed
    is_valid = check_endpoint_info(request.json, ['description', 'image_url',
    'name', 'price'])
    if(is_valid != None):
        return make_response(json.dumps(is_valid, default=str), 400)

    # verify if the data expected to be sent was sent indeed
    is_valid_header = check_endpoint_info(request.headers, ['token'])
    if(is_valid_header != None):
        return make_response(json.dumps(is_valid_header, default=str), 400)

    # calling the procedure that will add a menu item in the db
    results = run_statement('CALL add_menu_item(?,?,?,?,?)', [request.json.get('description'), request.json.get('image_url'), request.json.get('name'), request.json.get('price'), request.headers.get('token')])

    # if results is a list and at 'row_updated' the value is 1, return a success response
    if(type(results) == list and results[0]['row_updated'] == 1):
        return make_response(json.dumps(results[0], default=str), 200)
    # if results is a list and at 'row_updated' the value is 0, return a failure response
    if(type(results) == list and results[0]['row_updated'] == 0):
        return make_response(json.dumps(results[0], default=str), 400)
    # otherwise, return a db failure response
    else:
        return make_response(json.dumps("Sorry, an error has occurred."), 500)

# post request for the endpoint menu-item
def get():
    # verify if the data expected to be sent was sent indeed
    is_valid = check_endpoint_info(request.args, ['restaurant_id'])
    if(is_valid != None):
        return make_response(json.dumps(is_valid, default=str), 400)

    # calling a procedure that will get a menu item
    results = run_statement('CALL get_menu_item(?)', [request.args.get('restaurant_id')])

    # if results is a list and the length of it is different than zero, return a success response
    if(type(results) == list and len(results) != 0):
        return make_response(json.dumps(results[0], default=str), 200)
    # if results is a list and the length of it is equal to zero, return a failure response
    elif(type(results) == list and len(results) == 0):
        return make_response(json.dumps("Wrong restaurant id."), 400)
    # otherwise, return a db failure response
    else:
        return make_response(json.dumps("Sorry an error has occurred"), 500)

# patch request for the endpoint menu-item
def patch():
    # calling a procedure that will get all menu items that belongs to a restaurant
    menu_info = run_statement('CALL get_menu_item_by_token(?)', [request.headers.get('token')])
    if(type(menu_info) == list and len(menu_info) == 0):
        return make_response(json.dumps("Wrong token."), 400)

    # verify if the data expected to be sent was sent indeed
    is_valid = check_endpoint_info(request.json, ['menu_id'])
    if(is_valid != None):
        return make_response(json.dumps(is_valid, default=str), 400)

    # looping through menuinfo to see which menu item the user wants to edit
    for item in menu_info:
        if(item['id'] == int(request.json.get('menu_id'))):
            is_valid = item

    # calling a function that will fill all information that was not sent by the client in the request
    # to return all menu item info filled out
    update_menu_item = check_data_sent(request.json, menu_info[0], ['menu_id', 'description', 'image_url', 'name', 'price'])

    # if the name was not sent call a procedure that will update every row but name
    if(request.json.get('name') == None):
        results = run_statement('CALL edit_menu_item_but_name(?,?,?,?,?)', [update_menu_item['description'], update_menu_item['image_url'], update_menu_item['price'], request.headers.get('token'),update_menu_item['menu_id']])
    # else call a procedure that will update everything
    else:
        results = run_statement('CALL edit_menu_item(?,?,?,?,?,?)', [update_menu_item['description'], update_menu_item['image_url'], update_menu_item['name'], update_menu_item['price'], request.headers.get('token'),update_menu_item['menu_id']])
    
    # if results is a list and the length of it is different than zero, return a success response
    if(type(results) == list and results[0]['row_updated'] == 1):
        return make_response(json.dumps(results[0], default=str), 200)
    # if results is a list and the length of it is equal to zero, return a failure response
    elif(type(results) == list and results[0]['row_updated'] == 0):
        return make_response(json.dumps(results, default=str), 400)
    # otherwise, return a db failure response
    else:
        return make_response(json.dumps("Sorry, an error has occurred"), 500)

# delete request for the endpoint menu-item
def delete():
    # verify if the data expected to be sent was sent indeed
    is_valid = check_endpoint_info(request.json, ['menu_id'])
    if(is_valid != None):
        return make_response(json.dumps(is_valid, default=str), 400)

    # verify if the data expected to be sent was sent indeed
    is_valid_header = check_endpoint_info(request.headers, ['token'])
    if(is_valid_header != None):
        return make_response(json.dumps(is_valid_header, default=str), 400)

    # calling a procedure that will delete a menu item form db
    results = run_statement('CALL delete_menu_item(?,?)', [request.json.get('menu_id'), request.headers.get('token')])

    # if results is a list and the length of it is different than zero, return a success response
    if(type(results) == list and results[0]['row_updated'] == 1):
        return make_response(json.dumps(results[0], default=str), 200)
    # if results is a list and the length of it is equal to zero, return a failure response
    elif(type(results) == list and results[0]['row_updated'] == 0):
        return make_response(json.dumps(results[0], default=str), 400)
    # otherwise, return a db failure response
    else:
        return make_response(json.dumps("Sorry, an error has occurred."), 500)