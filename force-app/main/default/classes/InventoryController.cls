public with sharing class InventoryController {
    @AuraEnabled(cacheable=true)
    public static List<Inventory__c> getInventoryItems() {
        return [SELECT Id, Name, Quantity__c, Reorder_Level__c FROM Inventory__c];
    }
}