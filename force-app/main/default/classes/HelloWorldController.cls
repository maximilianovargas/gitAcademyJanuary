public with sharing class HelloWorldController {
    @AuraEnabled(cacheable=true)
    public static List<Opportunity> getOpportunties(Id accountId){
        return [
            SELECT Id, Name, Amount, StageName, CloseDate
            FROM Opportunity
            WHERE AccountId = :accountId
        ];
    }

    @AuraEnabled(cacheable=true)
    public static List<Opportunity> getClosedOpportunities(Id accountId){
        return [
            SELECT Id, Name, Amount, StageName, CloseDate
            FROM Opportunity
            WHERE AccountId = :accountId
            AND isClosed = true
        ];
    }

    @AuraEnabled
    public static void saveOpportunities(List<Opportunity> opportunities){
        update opportunities;
    }
}