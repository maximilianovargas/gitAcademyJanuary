trigger CaseTrigger on Case (before insert, after insert) {
    if(Trigger.isBefore){
		system.debug('before');
    } else if(Trigger.isAfter){
		System.debug('after');
	}
}