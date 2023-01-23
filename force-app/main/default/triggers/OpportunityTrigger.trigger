trigger OpportunityTrigger on Opportunity (after insert, before insert) {

    //trigger.new lista de objetos que estan pasando por el trigger
    //trigger.newMap mapa id,sobject de los objetos que estan pasando por el trigger
    //trigger.old lista de objetos que estan pasando por el trigger sin las nuevas actualizaciones
    //trigger.oldMap mapa id,sobject de los objetos que estan pasando por el trigger sin las nuevas actualizaciones
    if (Trigger.isBefore) {
        if (Trigger.isInsert) {
            for (Opportunity anOpportunity : Trigger.new) {
                anOpportunity.Name = 'Cambia Nombre';
            }
        }
    }
    else if (Trigger.isAfter) {
        if (Trigger.isInsert) {
        OpportunityTriggerHandler.createTasks(Trigger.newMap);

            /*List<Task> tasks = new List<Task>();
            Set<Id> opportunityIds = new Set<Id>();
            for (Opportunity anOpportunity : Trigger.New) {
                opportunityIds.add(anOpportunity.Id);
            }

            List<OpportunityContactRole > opportunitiesContactRoles = [
                SELECT id, ContactId, OpportunityId 
                FROM OpportunityContactRole 
                WHERE isPrimary = true
                AND OpportunityId IN :opportunityIds
            ];
            Map<Id, OpportunityContactRole> contactRolesByOpportunityId = new Map<Id, OpportunityContactRole>();
            for (OpportunityContactRole contactRole : opportunitiesContactRoles) {
                contactRolesByOpportunityId.put(contactRole.OpportunityId, contactRole);
            }

            for (Opportunity anOpportunity : Trigger.New) {
                OpportunityContactRole aContactRole = new OpportunityContactRole();
                aContactRole = contactRolesByOpportunityId.get(anOpportunity.Id);
                /*for (OpportunityContactRole contactRole : opportunitiesContactRoles) {
                    if (anOpportunity.Id == contactRole.OpportunityId) {
                        aContactRole = contactRole;
                    }
                }
                Task aTask =  new Task(
                    Subject = 'Call',
                    whoId = aContactRole.ContactId,
                    WhatId =  anOpportunity.Id
                );
                tasks.add(aTask);
            }

            insert tasks;*/
        }
    }
}