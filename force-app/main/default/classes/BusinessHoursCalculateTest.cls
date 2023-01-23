@isTest
private with sharing class BusinessHoursCalculateTest {
    @IsTest
    static void methodName(){
        BusinessHours aBusinessHours = [
            SELECT Id
            FROM BusinessHours
            WHERE IsDefault = true
            LIMIT 1
        ];
        DateTime targetTime = Datetime.now();
        Boolean expected = BusinessHours.isWithin(aBusinessHours.id, targetTime);
        Test.startTest();
        List<BusinessHoursCalculate.ResponseWrapper> response = 
            BusinessHoursCalculate.isBusinessHours();
        Test.stopTest();

        System.assertEquals(1, response.size(), 'the size of list is incorrect');

        System.assertEquals(expected,response[0].isBusinessHours, 'the function not response TRUE');
        
    }
}