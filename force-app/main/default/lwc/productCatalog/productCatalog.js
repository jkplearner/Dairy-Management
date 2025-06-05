import { LightningElement, wire, track } from 'lwc';
import getProducts from '@salesforce/apex/ProductController.getProducts';

export default class ProductCatalog extends LightningElement {
    @track products = [];
    @track columns = [
        { label: 'Product Name', fieldName: 'Name', type: 'text', sortable: true },
        { label: 'Product Type', fieldName: 'Product_Type__c', type: 'text', sortable: true },
        { label: 'Price', fieldName: 'Price__c', type: 'currency', sortable: true }
    ];
    @track isLoading = true;

    connectedCallback() {
        this.fetchProducts();
    }

    fetchProducts() {
        getProducts()
            .then(result => {
                this.products = result;
                this.isLoading = false;
            })
            .catch(error => {
                console.error('Error fetching products: ', error);
                this.isLoading = false;
            });
    }
}