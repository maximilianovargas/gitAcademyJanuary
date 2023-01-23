public with sharing class AccountMessageController {
    public List<WrappAccount> wrappAccounts {get;set;}
    public string message {get;set;}
    
    public AccountMessageController() {
        this.wrappAccounts = new List<WrappAccount>();
        for (Account anAccount : [
            SELECT Id, Name
            FROM Account
            LIMIT 30
        ]) {
            this.wrappAccounts.add(
                new WrappAccount(
                    anAccount
                )
            );
        }
    }

    public void save() {

        if (String.isBlank(this.message)) {
            apexpages.addMessage(
                new ApexPages.message(
                    Apexpages.Severity.WARNING,'No se escribio una descripcion para el mensaje'
                )
            );
            return;
        }

        Savepoint sp = Database.setSavepoint();

        Message__c aMessage = new Message__c(
            Description__c = this.message
        );

        insert aMessage;

        List<Message_in_Account__c> messagesInAccounts = new List<Message_in_Account__c>();

        for (WrappAccount aWrappAccount : this.wrappAccounts) {
            if (aWrappAccount.isChecked) {
                messagesInAccounts.add(
                    new Message_in_Account__c(
                        Account__c = aWrappAccount.anAccount.Id,
                        Message__c = aMessage.Id
                    )
                );
            }
        }
        if (messagesInAccounts.isEmpty()) {
            Database.rollback(sp);
            apexpages.addMessage(
                new ApexPages.message(
                    Apexpages.Severity.WARNING,'No se seleccionaron cuentas'
                )
            );
            return;
            
        }
        insert messagesInAccounts;
        apexpages.addMessage(
            new ApexPages.message(
                Apexpages.Severity.CONFIRM,'El mensaje fue insertado correctamente'
            )
        );
    }

    public class WrappAccount{
        public Boolean isChecked {get;set;}
        public Account anAccount {get;set;}

        public WrappAccount(Account anAccount){
            this.anAccount = anAccount;
            this.isChecked = false;
        }

    }
}