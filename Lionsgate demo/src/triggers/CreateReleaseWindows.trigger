trigger CreateReleaseWindows on Title__c (after insert, after update) {
    CreateReleaseWindowsHelper.createReleaseWindow(Trigger.New,Trigger.isUpdate); 
}