public with sharing class DairyProductController {
    @AuraEnabled
    public static Dairy_Product__c saveDairyProduct(Dairy_Product__c dairyProduct) {
        try {
            // Validate required fields (for example)
            if (String.isBlank(dairyProduct.Name)) {
                throw new AuraHandledException('Name is required.');
            }
            if (dairyProduct.Expiry_Date__c == null) {
                throw new AuraHandledException('Expiry Date is required.');
            }
            if (dairyProduct.Price__c == null) {
                throw new AuraHandledException('Price is required.');
            }
            if (String.isBlank(dairyProduct.Product_Type__c)) {
                throw new AuraHandledException('Product Type is required.');
            }

            // Insert the Dairy Product record
            insert dairyProduct;

            return dairyProduct; // Return the inserted record
        } catch (Exception e) {
            throw new AuraHandledException('Error saving dairy product: ' + e.getMessage());
        }
    }
}