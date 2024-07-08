FROM amazon/aws-lambda-python:3.9

RUN /var/lang/bin/python3.9 -m pip install --upgrade pip
RUN yum install -y java-1.8.0-openjdk-devel
RUN /var/lang/bin/pip install JPype1==1.3.0

RUN yum install git -y

RUN git clone https://github.com/chanmi08/Lambda_Docker.git

RUN pip install -r Lambda_Docker/requirements.txt

RUN cp Lambda_Docker/lambda_function.py /var/task/
RUN cp Lambda_Docker/model_and_mapping_0623.pkl /var/task/

CMD ["lambda_function.handler"]
