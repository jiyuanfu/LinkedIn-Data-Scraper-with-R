# LinkedIn-Data-Scraper-with-R
LinkedIn Data Scraper


## Goal of the project
This project aims to help HR quickly obtain candidates' resume information to proceed to the next interview process. Because it is very inefficient to manually query the LinkedIn profile of each job candidate, the work efficiency of HR is slowed down. The project will create a module in R with a Shiny interface that scrapes the LinkedIn resume information into a data file as text given a list of names. The tool will help HR get candidates' LinkedIn resume easily.

### About shiny
"Shiny is an open source R package that provides an elegant and powerful web framework for building web applications using R. Shiny helps you turn your analyses into interactive web applications without requiring HTML, CSS, or JavaScript knowledge".(Resource: https://www.rstudio.com/products/shiny/)

## Getting started
These instructions will get you a copy a the project up and running on your local machine for development and testing purpose.

### Prerequisites
R Studio
Chrome
Selenium Server
Microsoft Office Excel
Valid Account on ShinyApp

### Installation
Integrated Development Environment for R (e.g. RStudio, R Tools for Visual Studio, Rattle, PyCharm, Eclipse) https://www.rstudio.com/products/rstudio/
Selenium Server for chrome https://www.selenium.dev/downloads/
Chrome and ChromeDriver https://chromedriver.chromium.org/

### Testing
Install necessary package before running install.packages("dplyr") install.packages("RSelenium") install.packages("rvest") install.packages('stringr') install.packages("shiny")
Run java -Dwebdriver.chrome.driver=D:\Chromedriver.exe -jar D:\selenium-server-standalone-3.141.59.jar on CMD
Run the codes and view the result in environment

### Running the project locally
Download the neccessary files.
Input java -Dwebdriver.chrome.driver=D:\Chromedriver.exe -jar D:\selenium-server-standalone-3.141.59.jar on your CMD
![1637637152(1)](https://user-images.githubusercontent.com/59487206/142966111-1fa743e5-84b8-480a-ab14-841fecab3586.png)

The Selenium server is running on **port 4444**
Open the server.r and ui.r in local IDE and click the buttom "Run App"
Input your LinkedIn username and password, the skills you are looking for and how many candidates you want to find
The shiny app will display the result and allow users to download the analysis to local directory
