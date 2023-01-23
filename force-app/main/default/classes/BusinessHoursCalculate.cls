public with sharing class BusinessHoursCalculate {
    
    @InvocableMethod(label='Is Bussiness Hours' description='return true o false in bussiness hours')
    public static List<ResponseWrapper> isBusinessHours() {
        BusinessHours aBusinessHours = [
            SELECT Id
            FROM BusinessHours
            WHERE IsDefault = true
            LIMIT 1
        ];
        ResponseWrapper aResponseWrapper = new ResponseWrapper();
        DateTime targetTime = Datetime.now();
        aResponseWrapper.isBusinessHours = BusinessHours.isWithin(
            aBusinessHours.id, targetTime
        );
        List<ResponseWrapper> responseWrappers = new List<ResponseWrapper>();
        responseWrappers.add(aResponseWrapper);
        return responseWrappers;
    }
    
    public class ResponseWrapper {
        @InvocableVariable
        public Boolean isBusinessHours;
        public ResponseWrapper(){
            this.isBusinessHours = false;
        } 
    }
}