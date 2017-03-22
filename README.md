# Mini-Mobile-AI
A shiny based AI that takes speech input and perform various functions. This Ai takes a form of rusty the dog. (Based on my actual dog's name) Combining Annyang js (for speech to text), Watson API (for text to speech) and Wunderground Weather API.  
<br>
Try it in your Android chrome browser! 


# *Demo*:
<br>
Removed due to my watson API calls being limited. 

# *How to use*
<br>
Get your IBM watson API key from bluemix and Wunderground weather API key from their website. Then enter it into the shiny app.R
<br>
Say **rusty** - commands to speak to the app. Alternatively, you can type in the text box. 
<br>
The button play will output Rusty's answer (text to speech)
<br>
However, note that text to speech only works for command 1-4. If you use text to speech on Google query, app will crash. Simply refresh. 

# *Commands*

1) hello 
2) what is the best food in singapore?
3) what is the weather today?
4) what is the weather tomorrow?

5) anything under the sun- celebrities, personnels, locations, countries. Rusty will perform a google query.


# Bugs 
<br>
Google query not string, as a result, Watson cannot convert it using text to speech API. 

# Credits
<br>
CognizeR, XD, Robert from stackoverflow 
