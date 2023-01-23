@isTest
private with sharing class WSPricebooksTest {
    
    @IsTest
    static void methodName(){
        
        XHttpCalloutMock calloutMock = new XHttpCalloutMock();
        calloutMock.buildResponse()
            .withStatusCode(200)
            .withBody('{"token": "TOKEN"}')
            .addForAddress('callout:servicioEjercicio/token');
        calloutMock.buildResponse()
            .withStatusCode(200)
            .withBody(
            '['+
            '    {'+
            '        \"Id\": 1,'+
            '        \"Name\": \"Valores Argentina\"'+
            '    },'+
            '    {'+
            '        \"Id\": 2,'+
            '        \"Name\": \"Valores Uruguay\"'+
            '    }'+
            ']')
            .addForAddress('callout:servicioEjercicio/listas');
        Test.setMock(HttpCalloutMock.class, calloutMock);
        Test.startTest();
        WSPricebooks.Response response = WSPricebooks.getPricebooks();
        Test.stopTest();

        System.assertEquals(200, response.response.getStatusCode(), 'the status code was not the same');
        System.assertEquals('Valores Argentina', response.pricebooks[0].Name, 'the Name code was not the same');


        
    }
}