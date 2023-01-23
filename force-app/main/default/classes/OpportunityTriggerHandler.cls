public with sharing class OpportunityTriggerHandler {
    public static void createTasks(Map<Id,Opportunity> opportunitiesById) {
        List<Task> tasks = new List<Task>();

        List<OpportunityContactRole > opportunitiesContactRoles = [
            SELECT id, ContactId, OpportunityId 
            FROM OpportunityContactRole 
            WHERE isPrimary = true
            AND OpportunityId IN :opportunitiesById.keySet()
        ];

        for (OpportunityContactRole aContactRole : opportunitiesContactRoles) {
            Opportunity anOpportunity = opportunitiesById.get(aContactRole.OpportunityId);
            tasks.add(
                new Task(
                    Subject = 'Call',
                    whoId = aContactRole.ContactId,
                    WhatId =  anOpportunity.Id
                ) 
            );
        }
        insert tasks;
    }
}