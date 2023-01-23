public with sharing class CloseOpportunitiesSchedule implements Schedulable {
    public void execute(SchedulableContext ctx) {
        CloseOpportunitiesBatch myBatch = new CloseOpportunitiesBatch();
        Database.executeBatch(myBatch);
    }
}