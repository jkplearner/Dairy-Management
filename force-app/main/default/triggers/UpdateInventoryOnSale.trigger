trigger UpdateInventoryOnSale on Sales__c (after insert, after update) {
    // Map to hold quantity adjustments by product
    Map<Id, Decimal> productQuantityMap = new Map<Id, Decimal>();

    // Process records for insert and update
    if (Trigger.isInsert || Trigger.isUpdate) {
        for (Sales__c sale : Trigger.new) {
            if (sale.Product__c != null && sale.Quantity_Sold__c != null) {
                Decimal quantityAdjustment = sale.Quantity_Sold__c;

                // If it's an update, calculate the difference between old and new quantity
                if (Trigger.isUpdate) {
                    Sales__c oldSale = Trigger.oldMap.get(sale.Id);
                    if (oldSale != null && oldSale.Quantity_Sold__c != null) {
                        quantityAdjustment -= oldSale.Quantity_Sold__c;
                    }
                }

                // Add to the map, initialize if product ID is not yet in the map
                if (productQuantityMap.containsKey(sale.Product__c)) {
                    productQuantityMap.put(sale.Product__c, productQuantityMap.get(sale.Product__c) + quantityAdjustment);
                } else {
                    productQuantityMap.put(sale.Product__c, quantityAdjustment);
                }
            }
        }
    }

    // Ensure the correct API name for the Product lookup field in Inventory__c
    List<Inventory__c> inventoriesToUpdate = [
        SELECT Id, Quantity__c, Product__c
        FROM Inventory__c
        WHERE Product__c IN :productQuantityMap.keySet()
    ];

    // Update the quantity in Inventory records based on the sales adjustments
    for (Inventory__c inventory : inventoriesToUpdate) {
        Decimal quantityAdjustment = productQuantityMap.get(inventory.Product__c);
        if (quantityAdjustment != null) {
            inventory.Quantity__c = (inventory.Quantity__c != null ? inventory.Quantity__c : 0) - quantityAdjustment;
        }
    }

    // Perform the update
    update inventoriesToUpdate;
}