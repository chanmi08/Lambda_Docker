FROM amazon/aws-lambda-python:3.9

RUN /var/lang/bin/python3.9 -m pip install --upgrade pip

RUN yum install git -y

RUN git clone https://github.com/chanmi08/Lambda_Docker.git

RUN pip install -r Lambda_Docker/requirements.txt

RUN cp Lambda_Docker/lambda_function.py /var/task/

CMD ["lambda_function.handler"]