from flask import Flask, render_template_string

app = Flask(__name__)

personal_info = {
    'name': 'Karolina Jaworska',
    'email': 'karola.jaworska@wp.pl',
    'phone': '+48 511 114 933'
}

html_template = '''
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Person info</title>
  </head>
  <body>
    <h1>Person info</h1>
    <p><strong>Name:</strong> {{ info.name }}</p>
    <p><strong>Email:</strong> {{ info.email }}</p>
    <p><strong>Phone:</strong> {{ info.phone }}</p>
  </body>
</html>
'''

@app.route('/')
def index():
    return render_template_string(html_template, info=personal_info)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)
