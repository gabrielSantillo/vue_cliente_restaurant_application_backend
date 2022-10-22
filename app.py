import secrets
from flask import Flask, request, make_response
from dbhelpers import run_statement
from apihelpers import check_endpoint_info, check_data_sent
from dbcreds import production_mode
import json
import endpoints.client, endpoints.client_login, endpoints.restaurant

# calling the Flask function which will return a value that I will be used for my API
app = Flask(__name__)

####################################
# CLIENT #
####################################
@app.post('/api/client')
def post_client():
    return endpoints.client.post()


@app.get('/api/client')
def get_client():
    return endpoints.client.get()


@app.patch('/api/client')
def patch_client():
    return endpoints.client.patch()


@app.delete('/api/client')
def delete_client():
    return endpoints.client.delete()


@app.post('/api/client-login')
def log_in_client():
    return endpoints.client_login.post()


@app.delete('/api/client-login')
def delete_client_token():
    return endpoints.client_login.delete()


####################################
# RESTAURANT #
####################################

@app.post('/api/restaurant')
def post_restaurant():
    return endpoints.restaurant.post()

@app.get('/api/restaurant')
def get_restaurant():
    return endpoints.restaurant.get()

@app.patch('/api/restaurant')
def patch_restaurant():
    return endpoints.restaurant.patch()

@app.delete('/api/restaurant')
def delete_restaurant():
    return endpoints.restaurant.delete()


# if statement to check if the production_mode variable is true, if yes, run in production mode, if not, run in testing mode
if (production_mode):
    print("Running in Production Mode")
    import bjoern  # type: ignore
    bjoern.run(app, "0.0.0.0", 5000)
else:
    from flask_cors import CORS
    CORS(app)
    print("Running in Testing Mode")
    app.run(debug=True)
