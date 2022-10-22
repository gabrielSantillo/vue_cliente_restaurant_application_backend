#function responsible to the sent_data that will is going to be request.args or request.json and the
# expected_data taht is going to be the list of keys the endpoint requires
# this function will return a string in case of error and None otherwise

from dbhelpers import run_statement
from flask import Flask, request, make_response
import json

def check_endpoint_info(sent_data, expected_data):
    for data in expected_data:
        if(sent_data.get(data) == None):
            return f"The {data} argument is required."


def check_data_sent(sent_data, expected_data, client_info):
    client = {}
    i = 0
    for data in expected_data:
        if(sent_data.get(data) == None):
            client[data] = client_info[i]
        else:
            client[data] = sent_data[data]
        i += 1
    return client