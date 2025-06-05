public with sharing class RevenueController { 
    @AuraEnabled(cacheable=true)
    public static List<Dairy_Product__c> getProductOptions() {
        return [SELECT Id, Name FROM Dairy_Product__c];
    }

    @AuraEnabled(cacheable=true)
    public static List<SalesData> getSalesData(Id productId) {
        List<Sales__c> salesRecords = [SELECT Sale_Date__c, Quantity_Sold__c, Total_Price__c 
                                       FROM Sales__c 
                                       WHERE Product__c = :productId 
                                       ORDER BY Sale_Date__c];
        List<SalesData> salesDataList = new List<SalesData>();
        for (Sales__c sale : salesRecords) {
            salesDataList.add(new SalesData(sale));
        }
        return salesDataList;
    }

    public class SalesData {
        @AuraEnabled public Date saleDate;
        @AuraEnabled public Decimal quantitySold;
        @AuraEnabled public Decimal totalPrice;

        public SalesData(Sales__c sale) {
            this.saleDate = sale.Sale_Date__c;
            this.quantitySold = sale.Quantity_Sold__c;
            this.totalPrice = sale.Total_Price__c;
        }
    }
}