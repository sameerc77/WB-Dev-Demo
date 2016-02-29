public class AddReleaseWindowDetailsCntrl {
    public AddReleaseWindowDetailsCntrl(){}
    
    //Method for picklist value
    @RemoteAction
    public static List<String> getPicklistValues(String objectName, String fieldAPIName){
        List<String> options = new List<String>();
        Schema.SObjectType sObjectName = Schema.getGlobalDescribe().get(objectName);
		Schema.DescribeSObjectResult  describeSObjectResult = sObjectName.getDescribe();
		Schema.DescribeFieldResult describeFieldResult = describeSObjectResult.fields.getMap().get(fieldAPIName).getDescribe();
        List<Schema.PicklistEntry> ple = describeFieldResult.getPicklistValues();
        for( Schema.PicklistEntry f : ple)
            options.add(f.getValue());
       	return options;
        
    }//End
    
    //Access the release type value from custom setting
    @RemoteAction
    public static List<String> getReleaseTypes(){
        List<String> releaseTypeOpt = new List<String>();
        //Get the realese type value from custtom setting.
        for(String releaseValue : Release_Type__c.getall().values()[0].Release_Type_Value__c.split(',')){
            releaseTypeOpt.add(releaseValue);
        }
        return releaseTypeOpt;
    }
    
    //Method for save record
    @RemoteAction
    public static Id saveRecord(sObject template, List<sObject> lstReleaseObj){
        Database.SaveResult saveTemplateResult = Database.insert(template, false);
        if(saveTemplateResult.issuccess()){
            if(lstReleaseObj.size() > 0){
                for(sObject releaseObj: lstReleaseObj)
                    releaseObj.put('Template__c',saveTemplateResult.getId());
                List<Database.SaveResult> lstsaveResult = Database.insert(lstReleaseObj);
                Integer iErrorIndex = 0;
                for(Integer iIndex = 0; iIndex < lstsaveResult.size(); iIndex++){
                    if(!lstsaveResult[iIndex].isSuccess())
                       iErrorIndex++; 
                }
                if(iErrorIndex == 0)
                    return saveTemplateResult.getId();
                else
                    return null;
            }else
               return saveTemplateResult.getId(); 
        }else
            return null;
        return null;
    }//End
    
    
}