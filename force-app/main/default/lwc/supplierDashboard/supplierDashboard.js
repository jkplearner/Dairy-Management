import { LightningElement, wire, track } from 'lwc';
import getSuppliers from '@salesforce/apex/SupplierController.getSuppliers';

export default class SupplierDashboard extends LightningElement {
    @track suppliers = [];
    @track columns = [
        { label: 'Supplier Name', fieldName: 'Name', type: 'text', sortable: true },
        { label: 'Contact Information', fieldName: 'Contact_Number__c', type: 'phone', sortable: true },
        { label: 'Rating', fieldName: 'Rating__c', type: 'number', sortable: true }
    ];
    @track isLoading = true;

    connectedCallback() {
        this.fetchSuppliers();
    }

    fetchSuppliers() {
        getSuppliers()
            .then(result => {
                this.suppliers = result;
                this.isLoading = false;
            })
            .catch(error => {
                console.error('Error fetching suppliers: ', error);
                this.isLoading = false;
            });
    }
}