import dill
import sys
import math
import pandas as pd
from konlpy.tag import Okt
import json

okt = Okt()

# 저장된 모델과 매핑 로드
with open('/var/task/model_and_mapping_0725.pkl', 'rb') as f:
    data = dill.load(f)
    bf = data['bayesian_filter']
    keyword_to_category = data['keyword_to_category']

# 로드된 객체를 사용하여 텍스트 분류 함수 정의
def classify_text(text):
    text = text.lower()
    for keyword, category in keyword_to_category.items():
        if keyword in text:
            return category  # 키워드가 텍스트에 있으면 해당 카테고리 반환

    # 키워드가 없다면 머신러닝 모델로 카테고리를 예측
    predicted_category, _ = bf.predict(text)
    return predicted_category

def handler(event, context):
    body = event["body-json"]
    title = body["title"]
    result = classify_text(title)

    return {
        'statusCode': 200,
        'body': json.dumps(result)
    }
