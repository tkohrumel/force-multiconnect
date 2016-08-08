global without sharing class HerokuConnectSetup implements System.InstallHandler {
    global void onInstall(InstallContext context) {
      if(context.isUpgrade()){
        return;
      }
      
      Connection__c conn = new Connection__c();
      insert conn;
      
      sendRequest(context.installerId());
    }
    
    public static void testRequest() {
      Connection__c conn = new Connection__c();
      insert conn;
      
      String id = UserInfo.getUserId(); 
          
      sendRequest(id);
    }
    
    @future (callout=true)
    public static void sendRequest(String installerId) {
      HttpRequest request = new HttpRequest();
      HttpResponse response = new HttpResponse();
      Http http = new Http();

      User[] users = [SELECT email FROM User WHERE id = :installerId];
      User admin = (users.size() > 0) ? users[0] : null;
      
      Heroku_Config__c heroku_config = Heroku_Config__c.getInstance('Rails App');

      String endpoint = 'https://' + heroku_config.app_name__c  + '.herokuapp.com/organizations';

      request.setMethod('POST');
      request.setEndpoint(endpoint);
      request.setHeader('Content-Type', 'application/json');
      request.setHeader('Accept', 'application/json');
      request.setBody('{"org_id":"'+UserInfo.getOrganizationId()+ '", "admin_email":"' +admin.email+ '", "org_name":"' +UserInfo.getOrganizationName()+ '"}');

      response = http.send(request);
      System.debug(response.toString());
      System.debug(response.getBody());
      System.debug(response.getStatus());
    }
}