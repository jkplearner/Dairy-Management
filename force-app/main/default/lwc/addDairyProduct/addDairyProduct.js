import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class AddDairyProduct extends LightningElement {
    handleSuccess(event) {
        // Show a success message when the record is created
        const toastEvent = new ShowToastEvent({
            title: 'Success!',
            message: 'Dairy Product created successfully',
            variant: 'success',
        });
        this.dispatchEvent(toastEvent);
    }
}