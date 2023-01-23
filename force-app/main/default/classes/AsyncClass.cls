public with sharing class AsyncClass implements Queueable {

    private List<Opportunity> opportunities;

    public AsyncClass(Set<Id> opportunitiesIds){
        this.opportunities = [
            SELECT Name, StageName
            FROM Opportunity
            WHERE Id IN :opportunitiesIds
        ];
    }

    public AsyncClass(List<Opportunity> opportunities){
        this.opportunities = opportunities;
    }


    public void execute(QueueableContext context) {
        // awesome code here

        system.debug(this.opportunities);
    }


    @future
    public static void myFutureMethod(Set<Id> opportunitiesIds) {
        List<Opportunity> opportunities = [
            SELECT Name, StageName
            FROM Opportunity
            WHERE Id IN :opportunitiesIds
        ];

        System.debug(opportunities);
    }
}