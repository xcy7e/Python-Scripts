#
# Script to log into ABS using selenium and click the m4b convert button for a single book
#

# USAGE:
# python3 abs_m4bconvert.py {libraryItemId}
# python3 abs_m4bconvert.py "9ae4c7bb-f8d0-47dc-ae7f-6218ba479c34"

abs_host="https://my-audiobooks.com/audiobookshelf"
abs_username="admin"
abs_password="myPassword!"
abs_convert_btn_text="M4B-Kodierung starten "   # Be aware of a trailing space in the german language!

import sys,getopt
import time
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC

from selenium.webdriver.firefox.options import Options as FirefoxOptions

try:
    opt = FirefoxOptions()
    opt.add_argument("--headless")
    browser = webdriver.Firefox(options=opt)

    bookId = sys.argv[1]
    print("Start session for book {"+bookId+"}")

    # 1. Login
    url=abs_host+"/login/?redirect=%2Faudiobook%2F"+bookId+"%2Fmanage%3Ftool%3Dm4b"
    browser.get(url)
    assert 'Audiobookshelf' in browser.title

    wait = WebDriverWait(browser, 5)
    input_element = wait.until(EC.presence_of_element_located((By.NAME, 'username')))
    usernameInput = browser.find_element(By.NAME, value='username')  # Find username input
    passwordInput = browser.find_element(By.NAME, value='password')  # Find password input
    usernameInput.send_keys(abs_username)
    passwordInput.send_keys(abs_password + Keys.RETURN)
    browser.find_element(By.XPATH, '//form').submit()

    print("logging in")
    WebDriverWait(browser, 15).until(EC.url_changes(url))

    # 2. M4B Convert
    new_url = abs_host+'/audiobook/'+bookId+'/manage?tool=m4b'
    embed_url = abs_host+'/audiobook/'+bookId+'/manage?tool=embed'
    print(browser.current_url)

    if browser.current_url != new_url:
        if browser.current_url == embed_url:
            raise Exception("Book is already converted to m4b. Exit.")
        else:
            raise Exception("Unknown redirection to ["+browser.current_url+"]. Exit.")

    assert 'Audiobookshelf' in browser.title

    print("Convert-Page loaded")
    m4bBtn = wait.until(EC.presence_of_element_located((By.XPATH, "//button[text()='"+abs_convert_btn_text+"']")))
    print("Convert-Button found")

    print("Start converting")
    m4bBtn.click()
    print("Converting started!")

    time.sleep(10)  # Wait 10 seconds
    print("finish")
except AssertionError as ae:
    print("Assertion failed:", ae)
except Exception as error:
    print("Error:", error)
finally:
    browser.quit()

