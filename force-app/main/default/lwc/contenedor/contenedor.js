import { LightningElement } from 'lwc';

export default class Contenedor extends LightningElement {
    opportunities = []
    handleOpportunities(event){
        this.opportunities = []
        event.detail.forEach(opportunity => {
            this.opportunities.push(opportunity);
        });
        console.log(this.opportunities);
    }

}