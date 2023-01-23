trigger LeadTrigger on Lead (before insert, before update, after insert) {

    //Trigger.new una lista de los registros que se estan procesando del objeto del trigger
    //Trigger.old una lista de los registros que se estan procesando del objeto del trigger pero sin los nuevos valores
    //trigger.newMap un mapa de id,SObject de los registros que se estan procesando del objeto del trigger
    //trigger.oldMap un mapa de id,SObject de los registros que se estan procesando del objeto del trigger pero sin los nuevos valores

    if (Trigger.isBefore) {
        if (Trigger.isInsert) {

            List<Lead> leadsToValidateEmail = new List<Lead>();

            for (Lead aLead : Trigger.new) {
                if (!String.isBlank(aLead.Email)) { //aLead.Email != null || aLead.Email != ''
                    leadsToValidateEmail.add(aLead);
                }
            }

            if (!leadsToValidateEmail.isEmpty()) { // leadsToValidateEmail.size() > 0
               LeadTriggerHandler.validateEmail(leadsToValidateEmail); 
            }
            

        }else if (Trigger.isUpdate) {
            List<Lead> leadsToValidateEmail = new List<Lead>();

            for (Lead aLead : Trigger.new) {
                Lead oldLead = Trigger.oldMap.get(aLead.Id);
                if (
                    !String.isBlank(aLead.Email)
                    && aLead.Email != oldLead.Email
                    ) { 
                    leadsToValidateEmail.add(aLead);
                }
            }

            if (!leadsToValidateEmail.isEmpty()) { // leadsToValidateEmail.size() > 0
               LeadTriggerHandler.validateEmail(Trigger.new); 
            }
        }
    } else if (Trigger.isAfter) {
        if (Trigger.isInsert) {
            // logica del after
        }
    }
}