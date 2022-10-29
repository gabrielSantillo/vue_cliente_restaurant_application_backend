# function responsible to the sent_data that will is going to be request.args or request.json and the
# expected_data taht is going to be the list of keys the endpoint requires
# this function will return a string in case of error and None otherwise


def check_endpoint_info(sent_data, expected_data):
    for data in expected_data:
        if (sent_data.get(data) == None):
            return f"The {data} argument is required."


def check_data_sent(sent_data, original_data, expected_data):
    for data in expected_data:
        if(sent_data.get(data) != None):
            original_data[data] = sent_data[data]
    return original_data


def organize_response(response):
    keys = ['order_id', 'restaurant_id', 'is_confirmed', 'is_complete',
            'name', 'price', 'id', 'description', 'image_url']
    order = {}
    menu_items = []

    i = 0
    for data in response:
        item = {}
        for order_info in data:
            if (i < 4):
                order[keys[i]] = order_info
            elif (i >= 4 and i < 9):
                item[keys[i]] = data[i]
            else:
                break
            i += 1
        i = 4
        menu_items.append(item)
    order['menu_item_ids'] = menu_items

    return order


def organize_rated_orders(response):
    keys = ['order_id', 'restaurant_id', 'rate', 'name',
            'image_url', 'price', 'description', 'item_id']
    order = {}
    menu_items = []

    i = 0
    for data in response:
        item = {}
        for order_info in data:
            if (i < 3):
                order[keys[i]] = order_info
            elif (i >= 3 and i < 8):
                item[keys[i]] = data[i]
            else:
                break
            i += 1
        i = 3
        menu_items.append(item)
    order['menu_items'] = menu_items

    return order
