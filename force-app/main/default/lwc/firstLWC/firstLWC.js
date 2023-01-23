import { LightningElement, api, wire } from 'lwc';

import getOpportunities from '@salesforce/apex/FirstLWCController.getOpportunities';
import saveOpportunities from '@salesforce/apex/FirstLWCController.saveOpportunities';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

import OPPORTUNITY_NAME from '@salesforce/schema/Opportunity.Name';
import OPPORTUNITY_STAGE_NAME from '@salesforce/schema/Opportunity.StageName';
import OPPORTUNITY_CLOSE_DATE from '@salesforce/schema/Opportunity.CloseDate';
import OPPORTUNITY_AMOUNT from '@salesforce/schema/Opportunity.Amount';

const COLUMNS = [
    { label: 'Name', fieldName: OPPORTUNITY_NAME.fieldApiName, type:'text', editable: false },
    { label: 'Stage Name', fieldName: OPPORTUNITY_STAGE_NAME.fieldApiName, type:'text', editable: false },
    { label: 'Close Date', fieldName: OPPORTUNITY_CLOSE_DATE.fieldApiName, type:'Date', editable: false },
    { label: 'Amount', fieldName: OPPORTUNITY_AMOUNT.fieldApiName, type:'Number', editable: true },
]

export default class FirstLWC extends LightningElement {
    @api recordId;
    inputText
    columns = COLUMNS
    objet = {}
    //array = []
    opportunities = []
    error

    /*@wire(getOpportunities,{ accountId : '$recordId' })
    opportunities*/
    @wire(getOpportunities,{ accountId : '$recordId' })
    wiredOpportunities({error,data}){
        if(data){
            this.opportunities = data
            error = null
        }else{
            error = error;
        }
    }

    getInputText(event){
        this.inputText = event.target.value;
        this.objet.name = this.inputText;
        //this.array.push(this.objet);
    }

    showInputText(){
        console.log(this.opportunities)
        /*getOpportunities({ accountId : this.inputText }).then(
            response => {
                this.opportunities = response;
                console.log(this.opportunities);
            }
        ).catch(
            err => {
                console.log(err);
            }
        )*/
    }

    handleSave(event){
        const recordEdited = JSON.parse(JSON.stringify(event.detail.draftValues))
        console.log(recordEdited);
        saveOpportunities({opportunities : recordEdited}).then(
            response => {
                this.showToast('actualizadas', 'se han actualizado las oportunidades', 'success')
            }
        ).catch(
            err => {
                this.showToast('ocurrio un error', err, 'error')
            }
        )
    }

    showToast(titile,message,variant){
        const event = new ShowToastEvent({
            title: titile,
            message:message,
            variant: variant
        });
        this.dispatchEvent(event);
    }
}