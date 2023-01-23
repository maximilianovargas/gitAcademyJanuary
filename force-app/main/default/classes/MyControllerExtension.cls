public class MyControllerExtension {
    public final Account anAccount {get;set;}
    public List<AccountWrapper> accountsWrapper {get; set;}
       // The extension constructor initializes the private member
      // variable acct by using the getRecord method from the standard
     // controller.
    public myControllerExtension(ApexPages.StandardController stdController) {
        this.anAccount = (Account)stdController.getRecord();
        List<Opportunity> opportunities = [
            SELECT Id, Name, StageName
            FROM Opportunity
            WHERE AccountId = :this.anAccount.Id
        ];
        this.accountsWrapper = new List<accountWrapper>();
        for (Opportunity anOpportunity : opportunities) {
            this.accountsWrapper.add(
                new AccountWrapper(
                    anOpportunity
                )
            );
        }
    }
    public String getGreeting() {
        return 'Hello ' + this.anAccount.name + ' (' + this.anAccount.id + ')';
    }

    

    public void saveAccount() {
        update this.anAccount;
    }

    public class AccountWrapper {
        public Opportunity anOpportunity {get; set;}
        public Boolean isChecked {get; set;}

        public AccountWrapper(Opportunity anOpportunity){
            this.anOpportunity = anOpportunity;
            this.isChecked = false;
        }
    }

}