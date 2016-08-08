@RestResource(urlMapping='/AuthConnection/*')
global with sharing class RESTAuthConnection {

@HttpPost   
  global static void doPost(String connectionId, String authorizeUrl) { 
      Connection__c connection = ([SELECT COUNT() FROM connection__c] > 0) ? [SELECT auth_url__c FROM connection__c LIMIT 1] : new connection__c();     
      connection.auth_url__c = authorizeUrl;
      upsert connection;
  }
  
  public static String cName() {
      return 'RESTAuthConnection';
  }
  
  public static String mName() {
      return 'doPost';
  }
}