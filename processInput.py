#!/usr/bin/env python
# -*- coding: utf-8 -*-
import sys
sys.path.insert(0, 'lib')
sys.path.insert(1, '')
import MySQLdb


def authenticate(from_number, from_body):
	sent_id = from_body.split(' ')[0]
	try:
		sent_id = int(sent_id)
	except ValueError:
		sent_id = 0
	db = MySQLdb.connect(host='localhost', user='root', passwd='mysqltesting', db='sms_input')
	sql = "SELECT from_number,hospital_id FROM registered_staff WHERE from_number = '"+from_number+"';"
	with db:
		cur = db.cursor()
		cur.execute(sql)
		users = cur.fetchone()
	if not users:
		return False, sent_id
	elif users[1] == sent_id:
		return True, sent_id
	else:
		return False, 0


def insertBed(from_body, hospital_id):
	sent_id = from_body.split(' ')[0]
	numBeds = from_body.split(' ')[-1]
	try:
		numBeds = int(numBeds)
		sent_id = int(sent_id)
	except ValueError:
		return False
	if sent_id != hospital_id:
		return False
	db = MySQLdb.connect(host='localhost', user='root', passwd='mysqltesting', db='sms_data')
	sql = "UPDATE hospital_beds SET beds = {0} WHERE hospital_id = {1} ;".format(numBeds, hospital_id)
	with db:
		cur = db.cursor()
		cur.execute(sql)
	return True


def logUser(from_number, from_body, hospital_id, authentic, success):
	db = MySQLdb.connect(host='localhost', user='root', passwd='mysqltesting', db='sms_input')
	sql = "INSERT INTO beds_report (from_number,from_body,hospital_id,authentic,success) VALUES ('{0}','{1}', {2}, {3}, {4});".format(from_number, from_body, hospital_id, authentic, success)
	with db:
		cur = db.cursor()
		cur.execute(sql)
	return


def responseHandler(authentic, success):
	if authentic and success:
		return u"Merci pour votre entrée. Vos données ont été saisies."
	elif authentic and not success:
		return u"Désolé, une erreur s'est produite lors de la saisie de vos données. S'il vous plaît essayer à nouveau et entrer votre ID de l'hôpital et le nombre de lits."
	else:
		return u"Désolé, soit votre numéro de téléphone n'est pas enregistré ou votre ID de l'hôpital n'est pas correct. Si vous enregistré, s'il vous plaît essayer à nouveau et entrer votre ID de l'hôpital et le nombre de lits."


if __name__ == "__main__":
	# should succeed
	authentic, hospital_id = authenticate('+16463877470', '1234 4')
	success = insertBed('1234 4', hospital_id)
	logUser('+16463877470', '1234 4', hospital_id, authentic, success)
	print responseHandler(authentic, success)
	# should fail
	authentic, hospital_id = authenticate('+16465555555', '1234 4')
	success = insertBed('1234 4', hospital_id)
	logUser('+16463877470', '1234 4', hospital_id, authentic, success)
	print responseHandler(authentic, success)
	# should fail
	authentic, hospital_id = authenticate('+16463877470', '1234 quatre')
	success = insertBed('1234 quatre', hospital_id)
	logUser('+16463877470', '1234 quatre', hospital_id, authentic, success)
	print responseHandler(authentic, success)




