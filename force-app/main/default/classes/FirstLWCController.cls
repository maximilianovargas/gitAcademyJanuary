public with sharing class FirstLWCController {

    @AuraEnabled(cacheable=true)
    public static List<Opportunity> getOpportunities(Id accountId){
        return [
            SELECT Name, StageName, CloseDate, Amount
            FROM Opportunity
            WHERE AccountId = :accountId
        ];
    }

    @AuraEnabled
    public static void saveOpportunities(List<Opportunity> opportunities){
        update opportunities;
    }
}