public with sharing class SupplierController {
    @AuraEnabled(cacheable=true)
    public static List<Supplier__c> getSuppliers() {
        return [SELECT Id, Name, Contact_Number__c, Rating__c FROM Supplier__c];
    }
}