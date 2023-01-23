public with sharing class GetCommentsBatch implements Database.Batchable<sObject>, Database.AllowsCallouts {
    public List<Post__c> start(Database.BatchableContext bc) {
        // collect the batches of records or objects to be passed to execute
        return [
            SELECT Id, External_Id__c
            FROM Post__c
            WHERE CreatedDate = TODAY
        ];
    }
    public void execute(Database.BatchableContext bc, List<Post__c> posts){
        GetCommentsQueueable queueable = new GetCommentsQueueable(posts);
        System.enqueueJob(queueable);
    }
    public void finish(Database.BatchableContext bc){
        // execute any post-processing operations
    }
}