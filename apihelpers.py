# function responsible to the sent_data that will is going to be request.args or request.json and the
# expected_data taht is going to be the list of keys the endpoint requires
# this function will return a string in case of error and None otherwise


def check_endpoint_info(sent_data, expected_data):
    for data in expected_data:
        if (sent_data.get(data) == None):
            return f"The {data} argument is required."


def check_data_sent(sent_data, original_data, expected_data):
    for data in expected_data:
        if (sent_data.get(data) != None):
            original_data[data] = sent_data[data]
    return original_data


def organize_response(response):
    orders = []
    ids = []

    for data in response:
        if (data['id'] in ids):
            menu_item = {
                'name': data['name'],
                'price': data['price'],
                'menu_item_id': data['menu_item_id'],
                'description': data['description'],
                'image_url': data['image_url']
            }
            item['menu_items'].append(menu_item)
        else:
            ids.append(data['id'])

            item = {
                'id': data['id'],
                'restaurant_id': data['restaurant_id'],
                'is_confirmed': data['is_confirmed'],
                'is_complete': data['is_complete'],
                'menu_items': [{
                    'name': data['name'],
                    'price': data['price'],
                    'menu_item_id': data['menu_item_id'],
                    'description': data['description'],
                    'image_url': data['image_url']
                }]
            }
            orders.append(item)

    return orders


def organize_rated_orders(response):
    orders = []
    ids = []

    for data in response:
        if (data['order_id'] in ids):
            menu_item = {
                'name': data['name'],
                'price': data['price'],
                'menu_item_id': data['menu_item_id'],
                'description': data['description'],
                'image_url': data['image_url']
            }
            item['menu_items'].append(menu_item)
        else:
            ids.append(data['order_id'])

            item = {
                'order_id': data['order_id'],
                'restaurant_id': data['restaurant_id'],
                'rate': data['rate'],
                'menu_items': [{
                    'name': data['name'],
                    'price': data['price'],
                    'menu_item_id': data['menu_item_id'],
                    'description': data['description'],
                    'image_url': data['image_url']
                }]
            }
            orders.append(item)

    return orders
