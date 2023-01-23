@isTest
public with sharing class OpportunityTriggerTest {
    @TestSetup
    static void makeData(){
        Account anAccount = Build.anAccount()
            .whithName('Globant')
            .build();
        insert anAccount;


        Contact aContact = new Contact(
            LastName = 'Vargas',
            Email = 'maximiliano.vargas@globant.com',
            AccountId = anAccount.Id
        );
        insert aContact;
    }

    @IsTest
    static void whenANewOpportunityWasCreatedATaskWasCreatedAndRelatedWithTheFirstContactRoleAndTheOpportunity(){
        
        Account anAccount = [
            SELECT Id, (SELECT Id FROM Contacts)
            FROM Account
            WHERE Name = 'Globant'
            LIMIT 1
        ];

        Date closeDate = Date.today().addDays(30);

        Opportunity anOpportunity = new Opportunity(
            closeDate = closeDate,
            Name = 'test',
            AccountId = anAccount.Id,
            ContactId = anAccount.contacts[0].Id,
            StageName = 'Prospecting'
        );

        Test.startTest();
        insert anOpportunity;
        Test.stopTest();

        List<Task> tasks = [
            SELECT WhoId, WhatId
            FROM Task
        ];

        System.assertEquals(1, tasks.size(), 'the task was not created when the opportunity was inserted');

        System.assertEquals(
            anOpportunity.Id, tasks[0].WhatId, 
            'la tarea que se creo no esta relacionada correctamente con la oportunidad insertada'
        );
        System.assertEquals(
            anAccount.Contacts[0].Id, tasks[0].WhoId, 
            'la tarea que se creo no esta relacionada correctamente con el contact role de la oportunidad insertada'
        );
        
    }

    @IsTest
    static void whenInsertANewOpportunityTheNameIsChanged(){
        Date closeDate = Date.today().addDays(30);

        Opportunity anOpportunity = new Opportunity(
            closeDate = closeDate,
            Name = 'test',
            StageName = 'Prospecting'
        );
        Test.startTest();
        insert anOpportunity;
        Test.stopTest();

        Opportunity anOpportunityToCompare = [
            SELECT Name
            FROM Opportunity
            WHERE Id = :anOpportunity.Id
            LIMIT 1
        ];
        
        System.assertNotEquals(
            anOpportunity.Name, anOpportunityToCompare.Name, 
            'El nombre de la oportunidad no cambio'
        );
    }
}