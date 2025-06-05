import { LightningElement, wire, track } from 'lwc';
import getExpiringProducts from '@salesforce/apex/ExpiryController.getExpiringProducts';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class ExpiryNotification extends LightningElement {
    @track expiringProducts = [];
    @track columns = [
        { label: 'Product Name', fieldName: 'Name', type: 'text', sortable: true },
        { label: 'Expiry Date', fieldName: 'Expiry_Date__c', type: 'date', typeAttributes: { year: "numeric", month: "2-digit", day: "2-digit" } },
        { label: 'Status', fieldName: 'status', type: 'text' }
    ];
    @track isLoading = true;

    connectedCallback() {
        this.fetchExpiringProducts();
    }

    fetchExpiringProducts() {
        getExpiringProducts()
            .then(result => {
                const today = new Date();
                const warningDate = new Date();
                warningDate.setDate(today.getDate() + 7);  // 7 days from now

                this.expiringProducts = result.map(item => {
                    let status = '';
                    const expiryDate = new Date(item.Expiry_Date__c);

                    if (expiryDate < today) {
                        status = 'Expired';
                    } else if (expiryDate <= warningDate) {
                        status = 'Near Expiry';
                    } else {
                        status = 'Valid';
                    }

                    return { ...item, status };
                });

                this.isLoading = false;
            })
            .catch(error => {
                this.isLoading = false;
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error loading expiry data',
                        message: error.body.message,
                        variant: 'error'
                    })
                );
            });
    }
}