public with sharing class SearchOpportunitiesByAccountIdController {
    @AuraEnabled(cacheable=true)
    public static List<Opportunity> getOpportunities(Id accountId){
        return [
            SELECT Name, StageName, CloseDate, Amount
            FROM Opportunity
            WHERE AccountId = :accountId
        ];
    }
}