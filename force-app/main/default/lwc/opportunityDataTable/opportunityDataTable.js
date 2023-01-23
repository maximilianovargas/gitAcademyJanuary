import { LightningElement, api } from 'lwc';
import OPPORTUNITY_NAME from '@salesforce/schema/Opportunity.Name';
import OPPORTUNITY_STAGE_NAME from '@salesforce/schema/Opportunity.StageName';
import OPPORTUNITY_AMOUNT from '@salesforce/schema/Opportunity.Amount';
import OPPORTUNITY_CLOSE_DATE from '@salesforce/schema/Opportunity.CloseDate';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

const columns = [
    { label: 'Name', fieldName: OPPORTUNITY_NAME.fieldApiName, editable: false },
    { label: 'Stage Name', fieldName: OPPORTUNITY_STAGE_NAME.fieldApiName, type: 'text', editable: false },
    { label: 'Amount', fieldName: OPPORTUNITY_AMOUNT.fieldApiName, type: 'text', editable: false },
    { label: 'Close Date', fieldName: OPPORTUNITY_CLOSE_DATE.fieldApiName, type: 'date', editable: true },
];
export default class OpportunityDataTable extends LightningElement {
    columns = columns
    @api opportunities = []

    handleSave(event){
        let table = this.template.querySelector('.table');
        let rows = table.getSelectedRows();
        let updatedOpportunities = [];
        console.log(rows);
        let toUpdateData = event.target.draftValues;
        console.log(toUpdateData);

        if (rows.length == 0) {
            this.showToast(
                'se debe seleccionar algo',
                'se debe seleccionar al menos una oportunidad',
                'Error'
            );
            return
        }
        toUpdateData.forEach(aCase => {
            //0
            aCase.id = aCase.id.split('-')[1]
        });

        for(let i = 0; i< rows.length; i++){
            updatedOpportunities.push({...rows[i], "CloseDate" : toUpdateData[i].CloseDate});
        }
        console.log(updatedOpportunities);
        this.dispatchEvent(
            new CustomEvent(
                'sendopportunities',
                {
                    detail: updatedOpportunities
                }
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