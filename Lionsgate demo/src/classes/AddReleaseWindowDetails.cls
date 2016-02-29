public class AddReleaseWindowDetails {
    public Template__c Templates;
    public Release_Window_Details__c del;
    public List<Release_Window_Details__c> addReleaseWindowDetailsList {get;set;}
    public List<Release_Window_Details__c> delReleaseWindowDetailsList {get;set;}
    public List<Release_Window_Details__c> ReleaseWindowDetailsList {get;set;}
    public Integer totalCount {get;set;}
    public Integer rowIndex {get;set;}
    public Template__c Template;
    public String releaseType {get;set;}
    public id templateId {get;set;}
 
    public List<Release_Window_Details__c> delReleaseWindowDetails {get; set;} 
    public AddReleaseWindowDetails() {
        //Templates = (Template__c)controller.getRecord();
        //ReleaseWindowDetailsList = [Select id, Active__c, Distribution_Type__c, Duration__c, Start_Months__c from Release_Window_Details__c where Template__c =: Templates.Id];
        ReleaseWindowDetailsList = new List<Release_Window_Details__c>();
        totalCount = ReleaseWindowDetailsList.size();
        delReleaseWindowDetailsList = new List<Release_Window_Details__c>();
        delReleaseWindowDetails = new List<Release_Window_Details__c>();
    }
 
     public void addRow(){
        addReleaseWindowDetailsList = new List<Release_Window_Details__c>();
        ReleaseWindowDetailsList.add(new Release_Window_Details__c());
     }
 
     /*public PageReference saveReleaseWindowDetails(){
        for(Release_Window_Details__c RelDetList : ReleaseWindowDetailsList){
             RelDetList.Template__c = templateId;     
        }
        upsert ReleaseWindowDetailsList;
        delete delReleaseWindowDetailsList;
        //return (new ApexPages.StandardController(Templates)).view();
        //return new PageReference(templateId);
        PageReference pageRedirect = new PageReference('/'+templateId);   
        //pageRedirect.setRedirect(true);
        return pageRedirect;
     }*/ 
 
     public void deleteRow(){
         rowIndex = Integer.valueOf(ApexPages.currentPage().getParameters().get('rowIndex'));
         System.debug('row to be deleted ' + rowIndex );
         System.debug('row item to be deleted '+ReleaseWindowDetailsList[rowIndex]);
         del = ReleaseWindowDetailsList.remove(rowIndex);
         delReleaseWindowDetailsList.add(del);
     
     }
 
    //Access the release type value from custom setting
    public List<SelectOption> getReleaseTypes(){
        List<SelectOption> releaseTypeOpt = new List<SelectOption>();
        //Get the realese type value from custtom setting.
        for(String releaseValue : Release_Type__c.getall().values()[0].Release_Type_Value__c.split(',')){
            releaseTypeOpt.add(new SelectOption(releaseValue,releaseValue));
        }
        return releaseTypeOpt;
    }
    
    //Method for Create Template with Release Window Details Record.
    public PageReference crtTemplteWithRelWindowDetail(){
        Template = new Template__c(Name=releaseType,Release_Type__c=releaseType);
        Database.SaveResult saveTemplateResult = Database.insert(Template, false);
        if(saveTemplateResult.issuccess()){
            for(Release_Window_Details__c RelDetList : ReleaseWindowDetailsList)
             RelDetList.Template__c = saveTemplateResult.getId();    
        	
            upsert ReleaseWindowDetailsList;
            delete delReleaseWindowDetailsList;
            PageReference pageRedirect = new PageReference('/'+saveTemplateResult.getId());   
            pageRedirect.setRedirect(true);
            return pageRedirect;
         }else
             return null;
     }
}