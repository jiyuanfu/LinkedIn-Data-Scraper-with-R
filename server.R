# cmd input: 
# java -Dwebdriver.chrome.driver=D:\Chromedriver.exe -jar D:\selenium-server-standalone-3.141.59.jar
library(plyr)
library(RSelenium)
library(rvest)
library(stringr)
library(shiny)

get_resume = function(username,password,skillname,n){
  searchjoburl = function(skillname,n){
    pagenumber = 1
    n = as.numeric(n)
    counts= n/10
    candidatesURL = list()
    for (i in 0:counts){
      url=paste0('https://www.linkedin.com/search/results/people/?keywords=',
                 skillname,'&origin=SWITCH_SEARCH_VERTICAL&page=',pagenumber)
      remDr$navigate(url)
      Sys.sleep(5)
      a=remDr$getPageSource()[[1]]
      b=read_html(a) %>% html_nodes('body')
      candidatesnewURL= b%>% html_nodes(xpath='//*[contains(@class,"app-aware-link")]') %>% html_attr("href") %>% unique()
      candidatesURL = append(candidatesURL,candidatesnewURL)
      pagenumber = pagenumber + 1
    }
    candidatesURL %>% unique()
    candidatesURL = candidatesURL[-grep("www.linkedin.com/search/results/people", candidatesURL)]
    candidatesURL = head(candidatesURL, n)
    return (candidatesURL)
  }
  #Get data function
  getdata = function(candidatesURL){
    total = as.data.frame(matrix(nrow=0,ncol=3))
    n = length(candidatesURL)
    i = 1
    for (i in 1:n){
      Testurl = candidatesURL[i]
      remDr$navigate(Testurl[[1]])
      t4=remDr$findElements(using='css','.link-without-hover-state')
      lapply(t4,function(e)e$clickElement())
      a=remDr$getPageSource()[[1]]
      b=read_html(a) %>% html_nodes('body')
      name1=b%>% html_nodes(xpath='//*[contains(@class,"text-heading-xlarge inline t-24 v-align-middle break-words")]')
      exp1=b%>% html_nodes(xpath='//*[contains(@class,"pv-entity__position-group-pager pv-profile-section__list-item ember-view")]')
      edu1=b%>% html_nodes(xpath='//*[contains(@class,"pv-profile-section__list-item pv-education-entity pv-profile-section__card-item ember-view")]')
      Sys.sleep(5)
      i = i +1
      name = name1 %>% html_text() 
      education=
        plyr::llply(as.list(edu1),function(data){
          text=data %>%html_text()
          text=gsub('  ','',text)
          text=gsub('\n','',text)
          if(length(text)==0){text=NA}
          education=data.frame(Education=text)
        })
      df1 = data.frame(Education = education)
      education=tidyr::unite(df1, "Education")
      experience=
        plyr::llply(as.list(exp1),function(data){
          text=data %>%html_text()
          text=gsub('  ','',text)
          text=gsub('\n','',text)
          if(length(text)==0){text=NA}
          experience=data.frame(exp=text)
        })
      df1 = data.frame(exp = experience)
      experience=tidyr::unite(df1, "Experience")
      total2 = data.frame(Name = name,Education=education,Experience=experience)
      total = rbind(total,total2)
    }
    return(total)
  }
  remDr=remoteDriver(browserName='chrome')
  remDr$open()
  loginurl='https://www.linkedin.com/login?fromSignIn=true&trk=guest_homepage-basic_nav-header-signin'
  remDr$navigate(loginurl)
  t0=remDr$findElement(using='css','#username')
  t0$sendKeysToElement(list(username))
  t0=remDr$findElement(using='css','#password')
  t0$sendKeysToElement(list(password))
  t0=remDr$findElement(using='css','.from__button--floating')
  t0$clickElement()
  Sys.sleep(5)
  candidatesURL = searchjoburl(skillname,n)
  summary = getdata(candidatesURL)
  return(summary)
}
###############################shiny####################
shinyServer(function(input ,output, session) {
  gettab <- eventReactive(input$go,{
    req(input$username)
    req(input$password)
    req(input$skillname)
    req(input$n)
    
    get_resume(input$username,input$password,input$skillname,as.numeric(input$n))
  })
  
  output$summary <- renderTable({
    gettab()
  })
  
  
  
  output$downloadData <- downloadHandler(
    filename =  function() { 
      paste(input$n,input$skillname, "candidates_profile.csv", sep="")
    },
    
    content = function(file1){
      write_csv(gettab(),file1)
    })
})
