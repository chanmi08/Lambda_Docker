FROM amazon/aws-lambda-python:3.9

RUN /var/lang/bin/python3.9 -m pip install --upgrade pip
RUN yum update -y && yum install -y java-1.8.0-openjdk

RUN yum install git -y
RUN git clone https://github.com/chanmi08/Lambda_Docker.git
RUN pip install --no-cache-dir --upgrade -r Lambda_Docker/requirements.txt

RUN cp Lambda_Docker/lambda_function.py /var/task/
RUN cp Lambda_Docker/model_and_mapping_0725.pkl /var/task/
RUN cp Lambda_Docker/resampled_data.csv /var/task/
RUN cp Lambda_Docker/keyword_category.xlsx /var/task/

CMD ["lambda_function.handler"]
