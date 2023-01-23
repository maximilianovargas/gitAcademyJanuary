import { LightningElement } from 'lwc';
import getOpportunities from '@salesforce/apex/SearchOpportunitiesByAccountIdController.getOpportunities';
export default class SearchOpportunitiesByAccountId extends LightningElement {
    
    recordId;

    handleInput(event){
        this.recordId = event.target.value
    }

    getOpportunities(){
        getOpportunities({accountId: this.recordId}).then(
            response => {
                console.log(response);
                const sendOpportunties = new CustomEvent(
                    'sendopportunities', {
                        detail : response
                    }
                );
                console.log(sendOpportunties);
                this.dispatchEvent(sendOpportunties);
            }
        )
    }
}