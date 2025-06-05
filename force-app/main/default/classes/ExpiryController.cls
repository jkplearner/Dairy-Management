public with sharing class ExpiryController {
    @AuraEnabled(cacheable=true)
    public static List<Dairy_Product__c> getExpiringProducts() {
        return [SELECT Id, Name, Expiry_Date__c FROM Dairy_Product__c WHERE Expiry_Date__c != NULL];
    }
}