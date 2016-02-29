// Demo test
public with sharing class AccountJSONCreator {

    public String getJSON()
    {
        String TitleName = Apexpages.currentPage().getParameters().get('TitleName');
        List<TitleWrapper> wrp = new List<TitleWrapper>();
        for (Title__c a : [Select a.Id, a.Dx__c, a.Name, a.Theat_Rls__c, a.Producer__c, a.IMDB_Grade__c
                            From
                                Title__c a
                            WHERE Name Like : '%'+TitleName+'%' ]) {
               TitleWrapper w = new TitleWrapper (a.Name, a.Theat_Rls__c , nullToBlank (a.Producer__c), a.Id);
               wrp.add(w);
            }
        return JSON.serialize(wrp);
    }

    public String nullToBlank(String val)
    {
        return val == null ?'':val;
    }

    
	
	 public class TitleWrapper
    {
        String TitleName,Producer,AccId;
        Date ReleaseDate;

        Public TitleWrapper(String aName, Date relDate, String Producer, String i)
        {
            TitleName = aName;
            ReleaseDate= relDate;
            Producer = Producer;
            AccId = i ;
        }
    }

    
}
