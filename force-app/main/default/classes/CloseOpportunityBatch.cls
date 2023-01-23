public with sharing class CloseOpportunityBatch implements Database.Batchable<sObject> {
    String relativeDate;
    public CloseOpportunityBatch() {
        this.relativeDate = 'LAST_N_DAYS:15';
    }

    public CloseOpportunityBatch(String relativeDate) {
        this.relativeDate = relativeDate;
    }

    public Database.QueryLocator start(Database.BatchableContext bc) {
        // collect the batches of records or objects to be passed to execute
        return Database.getQueryLocator(
            'SELECT id FROM Opportunity WHERE CloseDate < '
            +this.relativeDate +' AND IsClosed = false'
        );
    }
    public void execute(Database.BatchableContext bc, List<Opportunity> opportunities){
        // process each batch of records
        for (Opportunity anOpportunity : opportunities) {
            anOpportunity.StageName = 'Closed Lost';
            anOpportunity.Description = 'cerrado por fecha de cierre vencida';
        }

        update opportunities;
    }
    public void finish(Database.BatchableContext bc){
        // hacer la logica para mandar un correo electornico
    }
}