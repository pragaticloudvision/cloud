public class CurrencyConvertClass {
public static Decimal convertCurrencyToINR(Decimal eur)
{
    Decimal inr=0.0,conversionRate=0.0;
    HTTP h=new HTTP();
    HTTPRequest req=new HTTPRequest();
  //  req.setEndpoint('https://api.exchangeratesapi.io/latest');
    req.setEndpoint('https://v6.exchangerate-api.com/v6/ede36ac367d3a2d0bcac7132/latest');
    req.setMethod('GET');
    
    HTTPResponse res=h.send(req);
    
    Map<String,Object> jsonBody= (Map<String,Object>)Json.deserializeUntyped(res.getBody());
    System.debug(jsonBody);
    
    Map<String,Object> mMap=(Map<String,Object>) jsonBody.get('rates');
     conversionRate=(Decimal)mMap.get('INR');
    
    inr=eur*conversionRate;
    return inr;
}
}