public with sharing class GetCommentsSchedule implements Schedulable {
    public void execute(SchedulableContext ctx) {
        GetCommentsBatch myBatch = new GetCommentsBatch();
        Database.executeBatch(myBatch,5);
    }
}