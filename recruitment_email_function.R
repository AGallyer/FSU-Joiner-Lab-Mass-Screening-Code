#install packages if aren't already installed on your computer.
install.packages("tidyverse")
install.packages("mailR")
install.packages("readxl")
#Load required packages
library(tidyverse)
library(mailR)
library(readxl)
#Function to import mass screening data, identify suicide ideators or attempters, and send recruitment email.
mass_screening_email <- function(email_subject = "Psychology Study Invitation", participants = "self", n = NA, score = NA) {
  print("Click on mass screening file")
  mass_path <- file.choose()
  print("Click on email body file")
  email_body <- file.choose()
  mass_data <- read_excel(path = mass_path)
  mass_data <- mass_data[-2, ]
  mass_data <- mass_data[-1, ]
  if (participants == "ideators") {
  mass_data <- mass_data %>%
    select(Email, Joiner_13) %>%
    rename("email" = Email, "life_thoughts" = Joiner_13) %>%
    filter(life_thoughts == 1 & !is.na(email))
  email_addresses <- mass_data$email
  }
  if (participants == "some ideators") {
        mass_data2 <- mass_data %>%
              select(Email, Joiner_13) %>% 
              rename("email" = Email, "life_thoughts" = Joiner_13, "life_attempters" = Joiner_14a) %>% 
              filter(life_thoughts == 1 & life_attempters == 2 & !is.na(email)) %>% 
              sample_n(size = n)
        email_addresses <- mass_data2$email
  }
  if (participants == "attempters"){
    mass_data <- mass_data %>%
      select(Email, Joiner_14a) %>%
      rename("email" = Email, "life_attempters" = Joiner_14a) %>%
      filter(life_attempters == 1 & !is.na(email))
    email_addresses <- mass_data$email
  }
  if (participants == "some healthy") {
        mass_data2 <- mass_data %>%
              select(Email, Joiner_13, Joiner_14a) %>% 
              rename("email" = Email, "life_thoughts" = Joiner_13, "life_attempters" = Joiner_14a) %>% 
              filter(life_thoughts == 2 & life_attempters == 2 & !is.na(email)) %>% 
              sample_n(size = n)
        email_addresses <- mass_data2$email
  }
  if (participants == "all healthy") {
        mass_data2 <- mass_data %>%
              select(Email, Joiner_13, Joiner_14a) %>% 
              rename("email" = Email, "life_thoughts" = Joiner_13, "life_attempters" = Joiner_14a) %>% 
              filter(life_thoughts == 2 & life_attempters == 2 & !is.na(email)) %>% 
        email_addresses <- mass_data2$email
  }
  if (participants == "fsu ideators") {
        mass_data2 <- mass_data %>%
              select(Email, Joiner_10) %>% 
              rename("email" = Email, "current_thoughts" = Joiner_10) %>% 
              filter(current_thoughts == 1 & !is.na(email)) 
        email_addresses <- mass_data2$email
  }
  if (participants == "dsiss") {
        mass_data2 <- mass_data %>% 
              select(Email, Joiner_SR1, Joiner_SR2, Joiner_SR3, Joiner_SR4) %>% 
              rename("email" = Email)
        mass_data2$Joiner_SR1 <- as.numeric(mass_data2$Joiner_SR1)
        mass_data2$Joiner_SR2 <- as.numeric(mass_data2$Joiner_SR2)
        mass_data2$Joiner_SR3 <- as.numeric(mass_data2$Joiner_SR3)
        mass_data2$Joiner_SR4 <- as.numeric(mass_data2$Joiner_SR4)
        mass_data2 <- mass_data2 %>% 
              mutate("dsiss" = Joiner_SR1 + Joiner_SR2 + Joiner_SR3 + Joiner_SR4) %>% 
              filter(dsiss >= score & !is.na(email)) 
        email_addresses <- mass_data2$email
  }
  if (participants == "self"){
        email_addresses <- "Gallyer@psy.fsu.edu"
  }
  sender <- "Gallyer@psy.fsu.edu"
  password <- readline(prompt = "Enter email password: ")
  send.mail(
    to = sender,
    from = sender,
    bcc = email_addresses,
    subject = email_subject,
    body = email_body,
    smtp = list(host.name = "smtp.gmail.com", port = 465, user.name = "agallyer@gmail.com", passwd = password, 
                ssl = TRUE),
    authenticate = TRUE,
    send = TRUE
  )
}
write.csv(email_addresses, "email_addresses.csv")