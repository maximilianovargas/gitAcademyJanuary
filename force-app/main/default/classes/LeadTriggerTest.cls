@isTest
private with sharing class LeadTriggerTest {

    @TestSetup
    static void makeData(){
        Lead aLead = new Lead(
            LastName = 'vargas',
            FirstName = 'Maximiliano',
            Email = 'maximiliano.vargas@globant.com',
            Company = 'Globant'
        );

        insert aLead;
    }

    @IsTest
    static void cuandoSeInsertaUnProspectoCuyoEmailEsIgualAlDeOtroRegistroDeLaBaseDeDatosRecibimosUnError(){
        
        Lead aLead = new Lead(
            LastName = 'vargas',
            FirstName = 'Maximiliano',
            Email = 'maximiliano.vargas@globant.com',
            Company = 'Globant'
        );


        Test.startTest();
        Database.SaveResult result = Database.insert(aLead, false);
        Test.stopTest();

        System.assertEquals(false, result.isSuccess(),'El email duplicado se logro insertar, no deberia');
        System.assertEquals(
            'Email duplicado', result.getErrors()[0].getMessage(),
            'El mensaje de error esperado no es el que deberia'
            );
        
    }

    @IsTest
    static void cuandoSeActualizaUnLeadConElCorreoElectronicoDeOtroExistenteEnLaBaseDeDatosReciboUnError(){
        Lead aLead = new Lead(
            LastName = 'vargas',
            FirstName = 'Maximiliano',
            Email = 'maximiliano.vargas2@globant.com',
            Company = 'Globant'
        );

        insert aLead;

        aLead.Email = 'maximiliano.vargas@globant.com';

        Test.startTest();
        Database.SaveResult result = Database.update(aLead, false);
        Test.stopTest();

        System.assertEquals(false, result.isSuccess(),'El email duplicado se logro insertar, no deberia');
        System.assertEquals(
            'Email duplicado', result.getErrors()[0].getMessage(),
            'El mensaje de error esperado no es el que deberia'
            );
        
    }

    @IsTest
    static void whenInsertMultiplesLeadsWithTHeSameEmailTheFirstLeadWasInsertedButTheOtherHaveAnError(){
        
        List<Lead> leads = new List<Lead>();

        for (Integer i = 0; i < 3; i++) {
            leads.add(
                new Lead(
                    LastName = 'vargas',
                    FirstName = 'Maximiliano',
                    Email = 'maximiliano.vargas2@globant.com',
                    Company = 'Globant'
                ) 
            );
        }

        Test.startTest();
        Database.SaveResult[] results = Database.insert(leads, false);
        Test.stopTest();

        System.assertEquals(true, results[0].isSuccess());
        System.assertEquals(false, results[1].isSuccess(), 'no se logro detener la insercion del registro duplicado');
        System.assertEquals(
            'Email duplicado', results[1].getErrors()[0].getMessage(),
            'El mensaje de error esperado no es el que deberia'
            );
        
    }

    
}