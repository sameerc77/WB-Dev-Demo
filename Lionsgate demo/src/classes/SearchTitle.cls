public class SearchTitle {
    public SearchTitle(){}
    
    @RemoteAction 
    public static List<Title__c> getRecords(String strQuery){
        List<Title__c> lstTitle = new List<Title__c>();
        if(String.isNotBlank(strQuery))
        	lstTitle = Database.query(strQuery);
        return lstTitle;
    }
}