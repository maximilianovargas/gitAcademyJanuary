import { LightningElement, api, wire } from 'lwc';
import getOpportunties from '@salesforce/apex/HelloWorldController.getOpportunties';
import getClosedOpportunities from '@salesforce/apex/HelloWorldController.getClosedOpportunities';
import saveOpportunities from '@salesforce/apex/HelloWorldController.saveOpportunities';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class Container extends LightningElement {

    @api recordId
    opportunitiesContainer
    closedOpportunities
    selectedOpportunities = []
    error
    @wire(getOpportunties,{accountId: '$recordId'})
    wiredGetOpportunities({error,data}){
        if(data){
            this.opportunitiesContainer = data;
            this.error = null
        } else{
            this.opportunitiesContainer = [];
            this.error = error;
        }
    }

    @wire(getClosedOpportunities,{accountId: '$recordId'})
    wiredGetClosedOpportunities({error,data}){
        if(data){
            this.closedOpportunities = data;
            this.error = null
        } else{
            this.closedOpportunities = [];
            this.error = error;
        }
    }

    handleOpportunities(event){
        console.log(event)
        this.selectedOpportunities = event.detail;

        saveOpportunities({opportunities: this.selectedOpportunities}).then(
            this.showToast(
                'update con exito',
                'se han actualizado las oportunidades',
                'success'
            )
        )
        
    }

    showToast(title,message,variant){
        const event = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant
        });
        
        this.dispatchEvent(event);
    }

}