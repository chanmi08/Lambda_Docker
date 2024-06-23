import dill
import sys
import math
from konlpy.tag import Okt
import json

# ����� �𵨰� ���� �ε�
with open('model_and_mapping_0623.pkl', 'rb') as f:
    saved_data = dill.load(f)

bf = saved_data['bayesian_filter']
keyword_to_category = saved_data['keyword_to_category']

# �ε�� ��ü�� ����Ͽ� �ؽ�Ʈ �з� �Լ� ����
def classify_text(text):
    text = text.lower()
    for keyword, category in keyword_to_category.items():
        if keyword in text:
            return category  # Ű���尡 �ؽ�Ʈ�� ������ �ش� ī�װ� ��ȯ

    # Ű���尡 ���ٸ� �ӽŷ��� �𵨷� ī�װ��� ����
    return bf.predict(text)

def handler(event, context):
    body = event["body-json"]
    title = body["title"]
    result = classify_text(title)

    return {
        'statusCode': 200,
        'body': json.dumps(result)
    }