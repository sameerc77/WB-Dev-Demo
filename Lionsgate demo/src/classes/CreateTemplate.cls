public class CreateTemplate {
    public Template__c Template;
    public String releaseType {get;set;}
    public CreateTemplate(){}
    
  	//Access the release type value from custom setting
    public List<SelectOption> getReleaseTypes(){
        List<SelectOption> relaeseTypeOpt = new List<SelectOption>();
        //Get the realese type value from custtom setting.
        for(String realeseVlaue : Release_Type__c.getall().values()[0].Release_Type_Value__c.split(',')){
            relaeseTypeOpt.add(new SelectOption(realeseVlaue,realeseVlaue));
        }
        return relaeseTypeOpt;
    }
    
    //Method for Create Template record
    public void createTemplate(){
        Template = new Template__c(Name=releaseType,Release_Type__c=releaseType);
        Database.SaveResult saveTemplateResult = Database.insert(Template, false);
	}
        
}