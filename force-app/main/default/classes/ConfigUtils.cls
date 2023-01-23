public with sharing class ConfigUtils {
    public static Organization currentOrg;

	public static Boolean isProductionEnviroment() {

		if (currentOrg == null) {
			currentOrg = [SELECT Id, Name, IsSandbox FROM Organization LIMIT 1];
		}

		return !currentOrg.isSandbox;
	}

	public static Webservice_Endpoint_Setting__mdt getWebServiceConfig(String wsName) {
		return [
			SELECT 
				DeveloperName, 
				URL__c, 
				IsProduction__c, 
				User__c,
				Pass__c,
				TokenAPI__c
			FROM Webservice_Endpoint_Setting__mdt
			WHERE IsProduction__c = :isProductionEnviroment()
				AND MasterLabel = :wsName
			LIMIT 1
		];
	}
}