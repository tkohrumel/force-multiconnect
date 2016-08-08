public with sharing class AuthController {
    private Connection__c connection;
    public String authUrl;
    
    public AuthController(){
        Connection__c[] connections = [SELECT auth_url__c FROM connection__c limit 1];
        connection = (connections.size() > 0) ? connections[0] : null;
        if (connection != null) authUrl = connection.auth_url__c;
    }

    public String getAuthUrl() {
        if((connection == null)) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, 'Insufficient Access.'));
            return '';
        } else {
            return authUrl;
        }
    }
}