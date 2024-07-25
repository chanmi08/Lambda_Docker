FROM amazon/aws-lambda-python:3.9

# 시스템 패키지 업데이트 및 필요 패키지 설치
RUN yum update -y && \
    yum install -y java-1.8.0-openjdk-devel git

# 환경 변수 설정
ENV JAVA_HOME /usr/lib/jvm/java-1.8.0-openjdk
ENV PATH $JAVA_HOME/bin:$PATH

# pip 업데이트 및 JPype1 설치
RUN /var/lang/bin/python3.9 -m pip install --upgrade pip
RUN /var/lang/bin/pip install JPype1==1.3.0

# 저장소 클론
RUN git clone https://github.com/chanmi08/Lambda_Docker.git

# requirements.txt 설치
RUN pip install -r Lambda_Docker/requirements.txt

# 필요한 파일 복사
RUN cp Lambda_Docker/lambda_function.py /var/task/
RUN cp Lambda_Docker/model_and_mapping_0623.pkl /var/task/
RUN cp Lambda_Docker/resampled_data.csv /var/task/
RUN cp Lambda_Docker/keyword_category.xlsx /var/task/

# Lambda 함수 핸들러 설정
CMD ["lambda_function.handler"]
