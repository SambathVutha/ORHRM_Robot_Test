import json
import os

with open(os.path.join(os.path.dirname(__file__), '../orangehrm_users.json'), 'r', encoding='utf-8') as f:
    data = json.load(f)
   

json_data = data.join(map(lambda x: x['username'], data))
print(data)
print(json_data)
# print(str(json_data))
# print(type(json_data))