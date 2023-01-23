public with sharing class LeadTriggerHandler {

    public static void validateEmail(List<Lead> leads) {
        Set<String> emails = new Set<String>();
            Map<String, Lead> leadsByEmail = new Map<String, Lead>();

            for (Lead aLead : leads) {
                //emails.add(aLead.Email);
                if (leadsByEmail.containsKey(aLead.Email)) {
                    aLead.addError('Email duplicado');
                } else {
                  leadsByEmail.put(aLead.Email, aLead);  
                }
                
            }

            List<Lead> leadsFromDB = [
                SELECT Email
                FROM Lead 
                WHERE Email 
                IN :leadsByEmail.keySet()
                //IN :emails
            ];
            if (leadsFromDB.size() > 0) { //!leadsFromDB.isEmpty()
                for (Lead aLead : leadsFromDB) {
                    Lead newLead = leadsByEmail.get(aLead.Email);
                    newLead.addError('Email duplicado');
                }
            }
            

            /*for (Lead aLead : leadsFromDB) {
                for (Lead newLead : leads) {
                    if (aLead.Email == newLead.Email) {
                        newLead.addError('Email duplicado');
                        continue;
                    }
                }
            }*/
    }
}