public with sharing class AccountMessageJunioController {
    public List<AccountWrapper> accountsWrapper {get;set;}
    public string description {get;set;}

    public AccountMessageJunioController() {
        this.accountsWrapper = new List<AccountWrapper>();

        for (Account anAccount : [
            SELECT Id, Name
            FROM Account
            LIMIT 30
        ]) {
            this.accountsWrapper.add(
                new accountWrapper(
                    anAccount
                )
            );
        }
    }

    public void save() {

        if (String.isEmpty(this.description)) {
            apexpages.addMessage(
                new ApexPages.message(
                    Apexpages.Severity.WARNING,'No se escribio una descripcion para el mensaje'
                )
            );
            return;
        }
        Savepoint sp = Database.setSavepoint();

        Message__c aMessage = new Message__c(
            Description__c = this.description
        );
        insert aMessage;

        List<Message_in_Account__c> messagesInAccounts = new List<Message_in_Account__c>();

        for (AccountWrapper anAccountWrapper : this.accountsWrapper) {
            if (anAccountWrapper.isChecked) {
                messagesInAccounts.add(
                    new Message_in_Account__c(
                        account__c = anAccountWrapper.anAccount.Id,
                        message__c = aMessage.Id
                    )
                );
            }   
        }

        if (messagesInAccounts.isEmpty()) {
            apexpages.addMessage(
                new ApexPages.message(
                    Apexpages.Severity.WARNING,'No se seleccionaron cuentas'
                )
            );
            Database.rollback(sp);
            return;
        }

        insert messagesInAccounts;
        apexpages.addMessage(
            new ApexPages.message(
                Apexpages.Severity.CONFIRM,'El mensaje fue insertado correctamente'
            )
        );
    }

    public class AccountWrapper {
        public Account anAccount {get;set;}
        public Boolean isChecked {get;set;}
        public AccountWrapper(Account anAccount){
            this.anAccount = anAccount;
            this.isChecked = false;
        }
    }
}