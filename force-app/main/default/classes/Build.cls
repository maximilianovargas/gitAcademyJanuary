@isTest
public class Build {

    public class AccountBuilder{
        private Account obj = new Account(
            Name = 'STRING'
        );

        public AccountBuilder whithName(String value){
            this.obj.Name = value;
            return this;
        }

        public AccountBuilder withParent(Account value){
            this.obj.ParentId = value.Id;
            return this;
        }

        public AccountBuilder withActive(String value){
            this.obj.Active__c = value;
            return this;
        }

        public Account build(){
            return obj;
        }
    }

    public static AccountBuilder anAccount(){
        return new AccountBuilder();
    }

    public class MessageBuilder {
        private Message__c obj = new Message__c();

        public MessageBuilder withDescription(string value){
            this.obj.Description__c = value;
            return this;
        }

        public Message__c build(){
            return obj;
        }
    }

    public static MessageBuilder aMessage(){
        return new MessageBuilder();
    }
    
}