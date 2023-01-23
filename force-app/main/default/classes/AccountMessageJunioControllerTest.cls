@isTest
private with sharing class AccountMessageJunioControllerTest {
    @TestSetup
    static void makeData(){
        List<Account> accounts = new List<Account>();

        for (Integer i = 0; i < 10; i++) {
            accounts.add(
                Build.anAccount().whithName('Test'+i).build()
            );
        }

        insert accounts;
    }

    @IsTest
    static void whenInstanceTheClassAccountMessageJunioControllerTheWrapperListIsTheSameSizeOfTheAccountListInSetup(){
        
        Test.startTest();
        AccountMessageJunioController myController = new AccountMessageJunioController();
        Test.stopTest();
        
        System.assertEquals(
            10, 
            myController.accountsWrapper.size(), 
            'the size of wrapper was not the same size of accounts into setup'
        );
    }

    @IsTest
    static void whenCallSaveFunctionWithAccountSelectedAndDescriptionPopulatedIntoDatabaseExistAMessage(){
        
        AccountMessageJunioController myController = new AccountMessageJunioController();
        myController.accountsWrapper[0].isChecked = true;
        myController.description = 'a description';

        Test.startTest();
        myController.save();
        Test.stopTest();
        
        List<Message__c> messages = [
            SELECT Id, Description__c
            FROM Message__c
        ];

        System.assertEquals(1, messages.size(), 'the size of list was not the expected');

        System.assertEquals(
            'a description', 
            messages[0].Description__c, 
            'the description into message was not the same of the input of the visualforce'
        );

    }

    @IsTest
    static void whenCallSaveFuntionButTheDescriptionIsEmptyTheMessageWasNotInserted(){
        
        AccountMessageJunioController myController = new AccountMessageJunioController();
        myController.accountsWrapper[0].isChecked = true;

        Test.startTest();
        myController.save();
        Test.stopTest();

        List<Message__c> messages = [
            SELECT Id, Description__c
            FROM Message__c
        ];

        System.assertEquals(0, messages.size(), 'the size of list was not the expected');
    }

    @IsTest
    static void whenCallSaveFuntcionWithAccountSelectedTheMessagesInAccountWasInserted(){
        AccountMessageJunioController myController = new AccountMessageJunioController();
        myController.accountsWrapper[0].isChecked = true;
        myController.accountsWrapper[1].isChecked = true;
        myController.accountsWrapper[2].isChecked = true;
        myController.description = 'a description';
        Test.startTest();
        myController.save();
        Test.stopTest();

        Message__c aMessage = [
            SELECT Id
            FROM Message__c
            LIMIT 1
        ];

        List<Message_in_Account__c> messagesInAccounts = [
            SELECT Id, Message__c, Account__c
            FROM Message_in_Account__c
        ];

        System.assertEquals(
            3, messagesInAccounts.size(), 
            'the messages in Accounts dont have the same size of accounts'+
            ' selected into visualforce'
        );

        for (Integer i = 0; i < messagesInAccounts.size(); i++) {
            System.assertEquals(aMessage.Id, messagesInAccounts[i].Message__c);
            System.assertEquals(
                myController.accountsWrapper[i].anAccount.Id,
                messagesInAccounts[i].Account__c
            );
        }
    }

    @IsTest
    static void methodName(){
        
        AccountMessageJunioController myController = new AccountMessageJunioController();
        myController.description = 'a description';

        Test.startTest();
        myController.save();
        Test.stopTest();
        
        List<Message__c> messages = [
            SELECT Id, Description__c
            FROM Message__c
        ];

        System.assertEquals(0, messages.size(), 'the size of list was not the expected');
    }


}