@RestResource(urlMapping='/LeadCreate/')
//To create  an API you need to create a global class
//Inside one class there can be only one method
global class DemoAPI {
@HTTPPost
    global static string doPost()
    {
        String fieldValue;
        String fieldName;
        String fName;
        String lName;
        String comp;
        
        //the request you are getting from external system
        RestRequest req=RestContext.request;
        //the response you are sending from your API
        RestResponse res= RestContext.response;
     
        //Converting JSON to String
        String arr=req.requestBody.toString();
        
        JSONParser parser= JSON.createParser(arr);
        
        //iterating through each key,value pair
        while(parser.nextToken()!=null)
        {
            if(parser.getCurrentToken()!= JSONToken.END_OBJECT)
            {
                parser.nextValue();
                fieldName= parser.getCurrentName();//getting key
                fieldValue=parser.getText();//getting value
                
                if(fieldName=='First Name')
                {
                    fName= parser.getText();
                }
                else if(fieldName=='Last Name')
                {
                    lname=parser.getText();
                }
                else if(fieldName=='Company')
                {
                    comp=parser.getText();
                }
            }
        }
        Lead lc=new Lead(FirstName=fName, lastName=lName,company=comp);
        insert lc;
        
        return lc.ID;
    }
}