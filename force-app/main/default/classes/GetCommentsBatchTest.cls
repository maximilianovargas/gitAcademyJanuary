@isTest
private with sharing class GetCommentsBatchTest {
    @TestSetup
    static void makeData(){
        List<Post__c> posts = new List<Post__c>();
        Post__c aPost  = new Post__c(
            External_Id__c = '5',
            Title__c = 'nesciunt quas odio',
            Body__c = 'repudiandae veniam quaerat sunt sed\nalias aut fugiat'+ 
                'sit autem sed est\nvoluptatem omnis possimus esse voluptatibus'+
                ' quis\nest aut tenetur dolor neque'
        );
        posts.add(aPost);
        Post__c anOtherPost  = new Post__c(
            External_Id__c = '6',
            Title__c = 'nesciunt quas odio',
            Body__c = 'repudiandae veniam quaerat sunt sed\nalias aut fugiat'+ 
                'sit autem sed est\nvoluptatem omnis possimus esse voluptatibus'+
                ' quis\nest aut tenetur dolor neque'
        );
        posts.add(anOtherPost);
        insert posts;

        Contact aContact = new Contact(
            Email = 'Isaias_Kuhic@jarrett.net',
            LastName = 'Kuhic'
        );
        insert aContact;
    }

    @IsTest
    static void methodName(){
        CommentServiceHttpCalloutMock myMock = new CommentServiceHttpCalloutMock();
        Test.setMock(HttpCalloutMock.class, myMock);

        Test.startTest();
        GetCommentsBatch myBatch = new GetCommentsBatch();
        Id jobId = Database.executeBatch(myBatch,5);
        Test.stopTest();

        AsyncApexJob myJob = [
            SELECT id, JobItemsProcessed, Status, TotalJobItems 
            FROM AsyncApexJob 
            WHERE Id = :jobId
            LIMIT 1
        ];

        System.assertEquals('Completed', myJob.Status);
        System.assertEquals(1, myJob.JobItemsProcessed);

        
    }
}