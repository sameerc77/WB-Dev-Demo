public class ReleasePlaningPageController{

    public ReleasePlaningPageController() {

    }




    public Title__c Title{get;set;}
    public List<Title__c > TitleRec{get;set;} 
    public List<Contact> ContactList{get;set;} 
    public String selectedId ;
    public Boolean Match{get;set;}
    public Boolean pgblk{get;set;}
    public Boolean NoMatch{get;set;}
    public Boolean AllMatch{get;set;}
    public Boolean AllContact{get;set;}
    public Boolean recNoConMatch{get;set;}
    public Boolean Buttn{get;set;}
    public String inputTitle{get;set;}
    public String type{get;set;}
    
    public String Categories{get;set;}
    public List<SelectOption> getCategoriesOptions() {
    List<SelectOption> CategoriesOptions = new List<SelectOption>();
    CategoriesOptions.add(new SelectOption('','-None-'));
    CategoriesOptions.add(new SelectOption('a','A'));
    CategoriesOptions.add(new SelectOption('aa','AA'));
    CategoriesOptions.add(new SelectOption('aaa','AAA'));
    CategoriesOptions.add(new SelectOption('c','C'));
    CategoriesOptions.add(new SelectOption('d','D'));


    return CategoriesOptions;
    }
    
   /*public ReleasePlaningPageController(ApexPages.StandardController controller) {
       selectedId ='';
        Title =new Title__c();
       // pgblk=false;
       
    }*/
  
    public void createTable(){
       
        Buttn = false;
        Allcontact=false;
        Match=false;
        NoMatch=false;
        AllMatch=false;
        pgblk= false;
        if((inputTitle != null &&inputTitle !='') || (type != null ) || (Categories!= null && Categories!='')){  
           string query = 'select Name,Dx__c ,TV_Grade__c,Director__c,Producer__c,Rating__c,Writer__c from Title__c where  ';        
            if(inputTitle!= null && inputTitle!=''){
                query +=' ( Name=\''+ inputTitle+'\' ) '; 
            }  
            /*if(type!= null && type!=''){
                if(inputTitle== null || inputTitle==''){
                    query +='(Dx__c =\''+ type+'\' ) '; 
                }
                else{
                    query +='And (Dx__c=\''+ type+'\' ) '; 
                }
            } */
            if(Categories!= null && Categories!=''  ){
                if((inputTitle== null || inputTitle=='') )
                {
                    query +=' (TV_Grade__c =\''+ Categories+'\' ) ';

                }else{
                    query +='And (TV_Grade__c =\''+ Categories+'\' ) '; 
                }
            }    
            TitleRec =Database.query(query); 
            if(TitleRec.size()>0)
            {
                Match=true;
                pgblk=true;
                
            }else
            {
                NoMatch=true;
                pgblk=true;
            }
        }
            else{
                AllMatch=true;
                pgblk=true;
                Buttn =true;
                TitleRec =[select Name,Dx__c ,TV_Grade__c,Director__c,Producer__c,Rating__c,Writer__c from Title__c];
            }

    }
     
    
  
    

}