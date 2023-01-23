@RestResource(urlMapping='/myRest/*')
global class ExposeService {
    @HttpGet
    global static ResponseWrapper getAccount() {
        RestRequest request = RestContext.request;
        //https://yourInstance.salesforce.com/services/apexrest/myRest/001IY000002ierNYAQ
        String accountId = request.requestURI.substring(request.requestURI.lastIndexOf('/')+1);
        Account anAccount =[
            SELECT Name,
                (SELECT FirstName, LastName FROM Contacts LIMIT 1)
            FROM Account
            WHERE Id = :accountId
            LIMIT 1
        ];

        return new ResponseWrapper(anAccount);
    }

    global class ResponseWrapper {
        public String accountName {get;set;}
        public String contactFirstName {get;set;}
        public String contactLastName {get;set;}

        public ResponseWrapper(Account anAccount){
            this.accountName = anAccount.Name;
            this.contactFirstName = anAccount.contacts[0].FirstName;
            this.contactLastName = anAccount.Contacts[0].LastName;
        }
    }
}