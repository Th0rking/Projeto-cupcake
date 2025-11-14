from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys

def test_login():
    driver = webdriver.Chrome()
    driver.get("http://localhost:8000/login.html")

    email_input = driver.find_element(By.ID, "email")
    senha_input = driver.find_element(By.ID, "senha")

    email_input.send_keys("teste@exemplo.com")
    senha_input.send_keys("SenhaForte123")
    senha_input.send_keys(Keys.RETURN)

    assert "menu.html" in driver.current_url
    driver.quit()
