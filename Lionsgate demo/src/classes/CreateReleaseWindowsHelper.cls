public class CreateReleaseWindowsHelper {
    public CreateReleaseWindowsHelper(){}
    
    public static void createReleaseWindow(List<Title__c> lstTitles, Boolean isUpdate) {
        Integer baseMonth;
        Set<Id> tilteId = new Set<Id>();
        for(Title__c title: lstTitles)
            tilteId.add(title.Id);
        
        Map<Id,List<Title__c>> mapLstOfTemplateWithTemId = new Map<Id,List<Title__c>>();
        if(isUpdate){
            List<Release_Window__c> lstOfOldReleaseWindow = [Select Id, Name From Release_Window__c Where Title__c =: lstTitles[0].Id];
            if(lstOfOldReleaseWindow.size()>0)
                delete lstOfOldReleaseWindow;
        }
       
        
        if(String.isNotBlank(lstTitles[0].Template__c)){
            List<Release_Window__c> lstReleaseWindow = new List<Release_Window__c>();
        	List<Release_Window_Details__c> lstReleaseWindowDetails = [Select Id, Name, Start_Months__c, Duration__c, Distribution_Type__c, Template__c From Release_Window_Details__c Where Template__c =:lstTitles[0].Template__c ORDER BY Start_Months__c DESC]; 
            for(Release_Window_Details__c rec :lstReleaseWindowDetails){
                if(rec.Distribution_Type__c == 'Theatrical')
                    baseMonth = Integer.valueOf(rec.Start_Months__c);
            }
            if(lstReleaseWindowDetails.size() > 0){
                for(Release_Window_Details__c releaseWinDetail :lstReleaseWindowDetails){
                    Release_Window__c releaseWindow = new Release_Window__c();
                    releaseWindow.Title__c = lstTitles[0].Id;
                    releaseWindow.Name = releaseWinDetail.Distribution_Type__c;
                    releaseWindow.Start_Date__c = CreateReleaseWindowsHelper.startDate(releaseWinDetail,lstTitles[0].Theat_Rls__c,baseMonth);
                	releaseWindow.End_Date__c = (releaseWindow.Start_Date__c).addMonths(Integer.valueOf(releaseWinDetail.Duration__c));
                    lstReleaseWindow.add(releaseWindow);
                }
            }
            insert lstReleaseWindow;
        }
    }//End
    
    public static Date startDate(Release_Window_Details__c objReleaseDetail, Date theatRlsDate, Integer baseMonth){
        if(objReleaseDetail.Distribution_Type__c == 'Theatrical')
         return theatRlsDate;
        else
         return theatRlsDate.addMonths(Integer.valueOf(objReleaseDetail.Start_Months__c) - baseMonth);
    }
    
    
}