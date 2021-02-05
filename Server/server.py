import stripe
import os
from flask import Flask
from flask import request
from flask import json
from dotenv import load_dotenv, find_dotenv

load_dotenv(find_dotenv())
app = Flask(__name__)

#1
@app.route('/pay', methods=['POST'])
def pay():

  #2
  # Set this to your Stripe secret key (use your test key!)
  stripe.api_key = os.getenv('STRIPE_SECRET_KEY')

  #3
  # Parse the request as JSON
  json = request.get_json(force=True)

  # Get the credit card details
  token = json['stripeToken']
  amount = json['amount']
  description = json['description']
  metadata = json['metadata']
  shipping = json['shipping']

  # Create the charge on Stripe's servers - this will charge the user's card
  try:
    #4
    charge = stripe.Charge.create(
				  amount=amount,
				  currency="brl",
				  card=token,
				  description=description,
                  metadata=metadata,
                  shipping=shipping
			          )
  except StripeError as error:
    # The card has been declined
    print(error)
    pass

  #5
  return "Success!"

if __name__ == '__main__':
  # Set as 0.0.0.0 to be accessible outside your local machine
  app.run(debug=True, host= '127.0.0.1')