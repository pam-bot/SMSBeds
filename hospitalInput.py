#!/usr/bin/env python
# -*- coding: utf-8 -*-
import sys
sys.path.insert(0, 'lib')
sys.path.insert(1, '')

from flask import Flask, request, redirect
import twilio.twiml
from processInput import authenticate, insertBed, logUser, responseHandler


app = Flask(__name__)
app.config['DEBUG'] = True

app = Flask(__name__)
@app.route('/', methods=['GET', 'POST'])
def SMSante():
	from_number = request.values.get('From', None)
	from_body = request.values.get('Body', None)
	resp = twilio.twiml.Response()
	authentic, success = False, False
	if from_number and from_body:
		authentic, hospital_id = authenticate(from_number, from_body)
		authentic = True	# delete line to activate authentication
		if authentic:
			success = insertBed(from_body, hospital_id)
			response = responseHandler(True, success)
		else:
			response = responseHandler(False, False)
		resp.message(response)
		logUser(from_number, from_body, hospital_id, authentic, success)
		return str(resp)
	else:
		#success = insertBed('1234 5', 1234)
		success = True
		if success:
			return responseHandler(True, True)
		else:
			return responseHandler(False, False)


if __name__ == "__main__":
	app.run(debug=True)


