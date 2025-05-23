# import csv

# class SaveToCSV:
#     def save_data_to_csv(self, data, filename):
#         # Save only meaningful columns, skip headerless rows
#         filtered = [row for row in data if len(row) >= 5]
#         headers = ["#", "Username", "User Role", "Employee Name", "Status"]

#         with open(filename, mode='w', newline='', encoding='utf-8') as f:
#             writer = csv.writer(f)
#             writer.writerow(headers)
#             for row in filtered:
#                 writer.writerow(row[:5])


import csv
import json
from robot.api.deco import keyword

@keyword
def save_data_to_json(data, file_path):
    with open(file_path, 'w', encoding='utf-8') as f:
        json.dump(data, f, indent=4, ensure_ascii=False)

@keyword
def save_data_to_csv(data, file_path):
    with open(file_path, 'w', newline='', encoding='utf-8') as f:
        writer = csv.writer(f)
        writer.writerows(data)



# class SaveToFile:
#     def save_data_to_csv(self, data, filename):
#         filtered = [row for row in data if len(row) >= 5]
#         headers = ["#", "Username", "User Role", "Employee Name", "Status"]

#         with open(filename, mode='w', newline='', encoding='utf-8') as f:
#             writer = csv.writer(f)
#             writer.writerow(headers)
#             for row in filtered:
#                 writer.writerow(row[:5])

#     def save_data_to_json(self, data, filename):
#         filtered = [row for row in data if len(row) >= 5]
#         json_data = []

#         for row in filtered:
#             user = {
#                 "Username": row[1],
#                 "User Role": row[2],
#                 "Employee Name": row[3],
#                 "Status": row[4]
#             }
#             json_data.append(user)

#         with open(filename, mode='w', encoding='utf-8') as f:
#             json.dump(json_data, f, indent=2)

# def save_data_to_csv(data, filename):
#     with open(filename, mode='w', newline='', encoding='utf-8') as file:
#         writer = csv.writer(file)
#         for row in data:
#             writer.writerow(row)

# def save_data_to_json(data, filename):
#     with open(filename, mode='w', encoding='utf-8') as file:
#         json.dump(data, file, indent=4, ensure_ascii=False)
