@isTest
private with sharing class GetCommentsQueueableTest {
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
    static void whenCallCommentServiceQueueableThisCallToServiceAndInsertTheComments(){
        CommentServiceHttpCalloutMock myMock = new CommentServiceHttpCalloutMock();
        Test.setMock(HttpCalloutMock.class, myMock);
        List<Post__c> posts = [
            SELECT Id, External_Id__c
            FROM Post__c

        ];
        Test.startTest();
        GetCommentsQueueable queueable = new GetCommentsQueueable(posts);
        System.enqueueJob(queueable);
        Test.stopTest();

        List<Comment__c> comments = [
            SELECT Id, Name, Body__c, Email__c
            FROM Comment__c
        ];

        System.assertEquals(5, comments.size());
        
    }

    @IsTest
    static void methodName(){

        CommentServiceHttpCalloutMock myMock = new CommentServiceHttpCalloutMock();
        Test.setMock(HttpCalloutMock.class, myMock);
        List<Post__c> posts = [
            SELECT Id, External_Id__c
            FROM Post__c

        ];
        Test.startTest();
        GetCommentsQueueable queueable = new GetCommentsQueueable(posts);
        System.enqueueJob(queueable);
        Test.stopTest();

        Contact aContact = [
            SELECT Id
            FROM Contact
            LIMIT 1
        ];

        Comment__c aComment = [
            SELECT Contact__c
            FROM Comment__c
            WHERE Email__c = 'Isaias_Kuhic@jarrett.net'
            LIMIT 1
        ];

        System.assertEquals(aContact.Id, aComment.Contact__c);
        
    }
}