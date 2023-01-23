@isTest
private with sharing class AccountMessageControllerTest {
    @TestSetup
    static void makeData(){
        List<Account> accounts = new List<Account>();
        for (Integer i = 0; i < 10; i++) {
            accounts.add(
                new Account(
                    Name = 'Account '+i
                )
            );
        }

        insert accounts;
    }

    @IsTest
    static void cuandoInstancioElControllerSuListaDeWrapperTieneElMismoTamanioQueLasCuentasDeLaDB(){
        
        Test.startTest();
        AccountMessageController myController = new AccountMessageController();
        Test.stopTest();

        System.assertEquals(10, myController.wrappAccounts.size());
        
    }

    @IsTest
    static void cuandoSeColocaUnTextoAlInputYSeLlamaASaveSeGeneraUnMensajeEnBaseDeDatos(){
        AccountMessageController myController = new AccountMessageController();
        myController.message = 'un mensaje';
        myController.wrappAccounts[0].isChecked = true;

        Test.startTest();
        myController.save();
        Test.stopTest();
        
        List<Message__c> messages = [
            SELECT Id, Description__c
            FROM Message__c
        ];

        System.assertEquals(1, messages.size());
        System.assertEquals(myController.message, messages[0].Description__c);
    }

    @IsTest
    static void cuandoNoSeColocaUnTextoAlInputYSeLlamaASaveNoSeGuardaUnMensaje(){
        AccountMessageController myController = new AccountMessageController();
        myController.wrappAccounts[0].isChecked = true;

        Test.startTest();
        myController.save();
        Test.stopTest();
        
        List<Message__c> messages = [
            SELECT Id, Description__c
            FROM Message__c
        ];

        System.assertEquals(0, messages.size());
    }

    @IsTest
    static void cuandoSeleccionamosVariasCuentasYLlamamosALaFuncionSaveSeInsertaUnMessageInAccountPorCadaCuentaSeleccionada(){
        
        AccountMessageController myController = new AccountMessageController();
        myController.message = 'un mensaje';
        myController.wrappAccounts[0].isChecked = true;
        myController.wrappAccounts[1].isChecked = true;
        myController.wrappAccounts[2].isChecked = true;


        Test.startTest();
        myController.save();
        Test.stopTest();
        
        List<Message_in_Account__c> messagesInAccounts = [
            SELECT Id, Message__c, Account__c
            FROM Message_in_Account__c
        ];

        System.assertEquals(3, messagesInAccounts.size());

        Message__c aMessage = [
            SELECT Id
            FROM Message__c
            LIMIT 1
        ];

        for (Integer i = 0; i < messagesInAccounts.size(); i++) {
            System.assertEquals(
                myController.wrappAccounts[i].anAccount.Id, messagesInAccounts[i].Account__c
            );
            System.assertEquals(aMessage.Id,  messagesInAccounts[i].Message__c);
        }
    }

    @IsTest
    static void methodName(){
        
        AccountMessageController myController = new AccountMessageController();
        myController.message = 'un mensaje';

        Test.startTest();
        myController.save();
        Test.stopTest();
        
        List<Message__c> messages = [
            SELECT Id, Description__c
            FROM Message__c
        ];

        System.assertEquals(0, messages.size());
    }
}