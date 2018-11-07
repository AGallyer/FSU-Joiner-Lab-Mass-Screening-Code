This code creates a function in R that can be used to send a mass email to participants identified by lifetime ideation or lifetime attempt questions
on the FSU psychology mass screening. Before using it, make the following changes to code:

(1) change "sender" variable to a string containing your gmail account address. If you have your gmail set up to send from your psy address as well, you can use that here.
(2) change "user.name" argument at the bottom to the username of your gmail account (same as instruction 1 if you aren't using your psy account).
(3) Change gmail settings to allow access from less secure apps, otherwise the email won't send. 
(4) Save the mass screening data with the password deactivated

INTSTRUCTIONS

(1) Make sure you have installed necessary packages located at the top of the code.
(2) Run rest of code.
(3) Make sure mass screening file is in .xls or .xlsx format and that the password has been deactivated.
(4) Create a .txt file containing the body of the email you want to send. Make each paragraph of the email one line.
(5) Use the mass_screening_email function, specify what the subject line will be with a string as the first argument.
(6) If you want to recruit lifetime ideators (i.e., those that answer "yes" to Joiner_13), enter "ideators" as the second argument. If you want lifetime attempters, 
enter the string "attempters" as the second argument. If you just want to test what your email looks like and only send it to your own email address, 
don't add a second argument.
(7) First prompt will ask you to click on the mass screening file.
(8) Second prompt will ask you to click on the body file you created in step 4.
(9) Third prompt will ask you to enter your gmail password.

Console should then say "Java-Object{org.apache.commons.mail.SimpleEmail@...". If the email sent, you should have an email in your inbox with all 
the participants entered in the Bcc section. This can probably be used with other email hosts as well, but that will require you to change a few things. 

Email me if you need help with it: agallyer@gmail.com


