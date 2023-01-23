@isTest
private with sharing class CommentServiceTest {
    @IsTest
    static void methodName(){
        CommentServiceHttpCalloutMock myMock = new CommentServiceHttpCalloutMock();
        Test.setMock(HttpCalloutMock.class, myMock);
        Test.startTest();
        HttpResponse response = CommentService.getComments('5');
        Test.stopTest();

        System.assertEquals(200, response.getStatusCode());
        System.assertEquals('Ok', response.getStatus());
        System.assertEquals(myMock.json, response.getBody());
        
    }
}