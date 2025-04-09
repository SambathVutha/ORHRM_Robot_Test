class DemoLibrary:
    def __init__(self,):
        print(f"Sample Library initialized with args")
 
    def my_keyword(self,):
        print("Hello from my_keyword")


    def get_responce(self, url):
        import requests
        response = requests.get(url)
        print(response.status_code)
        print(response.json(indent=4))

        # response.raise_for_status()
        # try:
        #     data = response.json()

        # except requests.JSONDecodeError:
        #     data = response.text
        
        # print(data)
        # Uncomment the lines below to see the headers and response text
        # print("Response Headers:")
        # print(response.headers)
        # if response.status_code != 200:
        #     raise Exception(f"Failed to fetch data from {url}. Status code: {response.status_code}")
        # print(f"Response from {url}: {response.text}")
        # return response.text
        # import requests

        # site_request = requests.get(url)

        # site_response = str(site_request.content)
        # print(site_response)
        # return site_response
