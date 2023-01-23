import { LightningElement, api, wire } from 'lwc';
import getOpportunties from '@salesforce/apex/HelloWorldController.getOpportunties';
import OPPORTUNITY_NAME from '@salesforce/schema/Opportunity.Name';
import OPPORTUNITY_STAGE_NAME from '@salesforce/schema/Opportunity.StageName';
import OPPORTUNITY_AMOUNT from '@salesforce/schema/Opportunity.Amount';
import OPPORTUNITY_CLOSE_DATE from '@salesforce/schema/Opportunity.CloseDate';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

const columns = [
    { label: 'Name', fieldName: OPPORTUNITY_NAME.fieldApiName, editable: false },
    { label: 'Stage Name', fieldName: OPPORTUNITY_STAGE_NAME.fieldApiName, type: 'text', editable: false },
    { label: 'Amount', fieldName: OPPORTUNITY_AMOUNT.fieldApiName, type: 'text', editable: false },
    { label: 'Close Date', fieldName: OPPORTUNITY_CLOSE_DATE.fieldApiName, type: 'date', editable: false },
];

export default class HelloWorld extends LightningElement {
    @api recordId;
    inputText = 'titulo';
    accountId
    columns = columns
    opportunities = [];
    error;
    /*@wire(getOpportunties,{accountId: '$recordId'})
    opportunities esto recibe un objeto que tiene dos variables data y error*/
    @wire(getOpportunties,{accountId: '$recordId'})
    wiredGetOpportunities({error,data}){
        if(data){
            this.opportunities = data;
            this.error = error
        } else {
            this.error = error;
            this.opportunities = [];
        }
    }

    handleInputText(event){
        let variable = event.target.value;
        this.accountId = variable;
    }

    getOpportuntiesButton(){
        console.log(this.opportunities);
        this.showToast(
            'Esto es una notificacion',
            'esto es una notificacion lanzada desde un evento', 
            'Error'
        );
        /*getOpportunties({accountId: this.accountId}).then(
            Response => {
                console.log('here')
                this.opportunities = Response;
                console.log(this.opportunities);
            }
        ).catch(
            err => {
                console.log(err)
            }
        )*/
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