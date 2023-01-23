@isTest
private with sharing class WSProductsTest {
    @TestSetup
    static void makeData(){
        
    }

    @IsTest
    static void GetTokenFromProductsService(){
        XHttpCalloutMock calloutMock  = new XHttpCalloutMock();
        calloutMock.buildResponse()
            .withStatusCode(200)
            .withBody('{"token": "TOKEN"}')
            .addForAddress('callout:servicioEjercicio/token');
        calloutMock.buildResponse()
            .withStatusCode(200)
            .withBody(
                '['+
                    '{'+
                        '"id": 1,'+
                       ' "Nombre": "Truffle Paste",'+
                        '"Codigo": "0268-0863",'+
                        '"Descripcion": "Disp fx of distal phalanx of unsp lesser toe(s), init",'+
                        '"NecesitaAprobacion": true'+
                    '},'+
                    '{'+
                        '"id": 2,'+
                        '"Nombre": "Pastry - Butterscotch Baked",'+
                        '"Codigo": "58517-200",'+
                        '"Descripcion": "Corrosion of second degree of right ankle and foot, sequela",'+
                        '"NecesitaAprobacion": false'+
                    '}'+
                ']'
            )
            .addForAddress('callout:servicioEjercicio/productos');
        Test.setMock(HttpCalloutMock.class, calloutMock);
        Test.startTest();
        WSProducts.Response response = WSProducts.getProducts();
        Test.stopTest();


        System.assertEquals(200, response.response.getStatusCode());
        System.assertEquals('Truffle Paste', response.products[0].Nombre);
        
    }
}