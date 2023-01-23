public with sharing class AsyncClassJune implements Queueable  {

    private List<Account> accounts;

    public AsyncClassJune(List<Account> accounts){
        this.accounts = accounts;
    }

    public void execute(QueueableContext context) {
        for (Account anAccount : this.accounts) {
            String newName = anAccount.Name + ' ' + 'Active';
            anAccount.Name = newName;
        }

        update accounts;
    }

    @future
    public static void updateAccounts(List<Id> accountIds) {
        List<Account> accounts = [
            SELECT Id, Name
            FROM Account
            WHERE Id IN :accountIds
            AND Active__c = 'Yes'
        ];

        for (Account anAccount : accounts) {
            String newName = anAccount.Name + ' ' + 'Active';
            anAccount.Name = newName;
        }

        update accounts;
    }
}