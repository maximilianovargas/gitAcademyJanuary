@isTest
private with sharing class WSEFAuthenticationTest {
    @IsTest
    static void getTokenWithAuthentication(){
        
        XHttpCalloutMock calloutMock = new XHttpCalloutMock();
        calloutMock.buildResponse()
            .withStatusCode(200)
            .withBody('{"token": "TOKEN"}')
            .addForAddress('callout:servicioEjercicio/token');
        test.setMock(HttpCalloutMock.class, calloutMock);

        Test.startTest();
        WSEFAuthentication.Response response = WSEFAuthentication.getToken();
        Test.stopTest();
        
        System.assertEquals(200, response.response.getStatusCode(), 'The token was not the same');
        System.assertEquals('TOKEN', response.token.token, 'the token was not the same');
    }

    @IsTest
    static void itHasToSetTheHeaderWithTheTokenInTheRestWSObject(){
        XHttpCalloutMock calloutMock = new XHttpCalloutMock();
        calloutMock.buildResponse()
            .withStatusCode(200)
            .withBody('{"token": "TOKEN"}')
            .addForAddress('callout:servicioEjercicio/token');
        test.setMock(HttpCalloutMock.class, calloutMock);

        RestWS service = new RestWS('endpoint','GET',null);
        Test.startTest();
        WSEFAuthentication.setAuth(service);
        Test.stopTest();

        System.assertEquals('Bearer TOKEN', service.request.getHeader('Authorization'));
        
    }
    @IsTest
    static void methodName(){
        XHttpCalloutMock calloutMock  = new XHttpCalloutMock();
        calloutMock.buildResponse().withStatusCode(500).addForAddress('callout:servicioEjercicio/token');
        test.setMock(HttpCalloutMock.class, calloutMock);
        Test.startTest();
        WSEFAuthentication.Response response = WSEFAuthentication.getToken();
        Test.stopTest();

        System.assertEquals(true, response.hasError);
        
    }
}