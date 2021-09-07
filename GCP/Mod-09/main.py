import requests
import sendgrid
import json
import os
from flask import escape
from flask_cors import CORS, cross_origin
from sendgrid import SendGridAPIClient
from sendgrid.helpers.mail import Mail, Email
from python_http_client.exceptions import HTTPError

@cross_origin()
def recebe_requisicao(request):
    request_form = request.form

    if request_form and 'inputNome' and 'inputSobrenome' and 'inputEmail' in request_form:
        nome = request_form['inputNome']
        sobrenome = request_form['inputSobrenome']
        email = request_form['inputEmail']

        resultado = cria_usuario_moodle(email,nome,sobrenome)

        if resultado == 'sucesso':
        	return 'Solicitação recebida com sucesso.'
        else:
        	print('RR:ERRO:CRIACAO_DE_USUARIO_FALHOU')
        	return 'Erro, entre em contato com o administrator do sistema.'
    else:
        print('RR:ERRO:PARAMETRO_NAO_ENCONTRADO')
        return 'Erro, entre em contato com o administrator do sistema.'



def cria_usuario_moodle(email,nome,sobrenome):
	
	token = os.environ.get('MOODLE_TOKEN')
	servidor = os.environ.get('MOODLE_SERVER')

	function = 'core_user_create_users'
	url = 'http://{0}/webservice/rest/server.php?wstoken={1}&wsfunction={2}&moodlewsrestformat=json'.format(servidor,token,function)

	email = email
	username = email.split("@")[0]

	users = {'users[0][username]': username,
	        'users[0][email]': email,
	        'users[0][lastname]': sobrenome,
	        'users[0][firstname]': nome,
	        'users[0][password]': 'P@40ssword123'}

	try:
		response = requests.post(url,data=users)
		if 'exception' in json.loads(response.text):
			print('Result: ' + response.text)
			return 'erro'
		else:
			print('Result: ' + response.text)	
			return 'sucesso'
	except Exception as e:
		print(e)
		return 'erro'


def SendEmail(email):
    sg = SendGridAPIClient(os.environ['EMAIL_API_KEY'])

    html_content = "<p>Olá, sua conta foi criada, sua senha é P@40ssword123</p>"

    message = Mail(
        to_emails = (email),
        from_email='tcb.alansilva@gmail.com',
        subject="Sua conta foi criada!",
        html_content=html_content
        )
    message.add_bcc("tcb.alansilva@gmail.com")

    try:
        response = sg.send(message)
        return f"email.status_code={response.status_code}"

    except HTTPError as e:
        return e.message
