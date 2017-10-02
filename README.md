# Powershell Invoke-RestMethod (debugging)

I've used Invoke-RestMethod for publishing QA report data to Slack using their WebHooks and also to pre-load data into an application via RestAPI calls.

One thing that's 'not great' about vanilla Invoke-RestMethod is there's sometimes a lack of feedback if things don't work 100% and it can be a challenge to understand why something's gone bang...

So here's a simple example. In this case I went with using -ErrorVariable because I felt it was a bit clearer as to what's happening although there's also a 'try/catch' example in the comments. I should also probably try this with Invoke-WebRequest and see what (if any) differences there are.

In this example I was also struggling with the fact that the Rest-API that I was testing against doesn't _seem_ to return a 200 Success code when things work properly. Calling the function with added -Verbose flag got me the response from the $(headerToken) call but not the 'success' which was weird. I'll have to get into that with the development team 'cause I'm actually using our API/application to test against!  

Here's what you get in addition to angry red noise:

![alt text](/Post-method.png "errors for Invoke-RestMethod")