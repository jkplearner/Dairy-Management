import { LightningElement, wire, track } from 'lwc';
import getInventoryItems from '@salesforce/apex/InventoryController.getInventoryItems';

export default class InventoryTracker extends LightningElement {
    @track inventoryItems = [];
    @track columns = [
        { label: 'Product ID', fieldName: 'Name', type: 'text', sortable: true },
        { label: 'Quantity in Stock', fieldName: 'Quantity__c', type: 'number', sortable: true },
        { label: 'Reorder Level', fieldName: 'Reorder_Level__c', type: 'number', sortable: true },
        { label: 'Status', fieldName: 'status', type: 'text' }
    ];
    @track isLoading = true;

    connectedCallback() {
        this.fetchInventoryItems();
    }

    fetchInventoryItems() {
        getInventoryItems()
            .then(result => {
                this.inventoryItems = result.map(item => {
                    const status = item.Quantity__c <= item.Reorder_Level__c ? 'Low Stock' : 'In Stock';
                    return { ...item, status };
                });
                this.isLoading = false;
            })
            .catch(error => {
                console.error('Error fetching inventory items: ', error);
                this.isLoading = false;
            });
    }
}