public class CloseOpportunitiesBatch implements Database.Batchable<sObject> {

    private string relativeDate;

    public CloseOpportunitiesBatch(){
        this.relativeDate = 'LAST_N_DAYS:15';
    }

    public CloseOpportunitiesBatch(string relativeDate){
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
        for (Opportunity anOpportunity : opportunities) {
            anOpportunity.StageName = 'Closed Lost';
            anOpportunity.Description = 'Oportunidad cerada perdida por vencimiento de fecha';
        }

        update opportunities;
    }
    public void finish(Database.BatchableContext bc){
        // execute any post-processing operations
    }
}