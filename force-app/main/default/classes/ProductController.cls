public with sharing class ProductController {
    @AuraEnabled(cacheable=true)
    public static List<Dairy_Product__c> getProducts() {
        return [SELECT Id, Name, Product_Type__c, Price__c FROM Dairy_Product__c];
    }
}