public with sharing class CloseOpportunitySchedule implements Schedulable {
    public void execute(SchedulableContext ctx) {
        CloseOpportunitiesBatch myBatch = new CloseOpportunitiesBatch();
        Database.executeBatch(myBatch);
    }
}