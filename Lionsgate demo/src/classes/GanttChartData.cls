public with sharing class GanttChartData {

	public String jsonString {get;set;}
	
	//Constructor
	public GanttChartData(ApexPages.StandardController stdController) 
	{
		jsonString = prepareData();

	}	
	//Temp Method to prepare the Data
	private String prepareData()
	{
		List<Release_Window_Details__c> lstReleaseWindowDetail = [Select Id, Name, Distribution_Type__c, Duration__c, Start_Date__c, Start_Months__c, End_Month__c, Template__c From Release_Window_Details__c Where Template__c='a0228000008iKtv'];
        system.debug('--List of ReleseWindowDetails--'+lstReleaseWindowDetail);
        
        List<Details> lstDetails = new List<Details>();
        
        for(Release_Window_Details__c releaseWindowDetail : lstReleaseWindowDetail){
            system.debug('--List of In--'+releaseWindowDetail);
            List<ReleaseWindowDetail> lstObj = new List<ReleaseWindowDetail>();
            
            ReleaseWindowDetail obj = new ReleaseWindowDetail();
            obj.setFromDate(String.valueOf(datetime.newInstance((releaseWindowDetail.Start_Date__c).year(), (releaseWindowDetail.Start_Date__c).month(),(releaseWindowDetail.Start_Date__c).day()).getTime())); 
			obj.setToDate(String.valueOf(datetime.newInstance((releaseWindowDetail.End_Month__c).year(), (releaseWindowDetail.End_Month__c).month(),(releaseWindowDetail.End_Month__c).day()).getTime())); 
			obj.desc_PH = releaseWindowDetail.Name;
			obj.label = releaseWindowDetail.Name;
			obj.customClass = 'ganttRed';
            lstObj.add(obj);
            
            Details objDetail = new Details();
			objDetail.name = releaseWindowDetail.Name;
			objDetail.desc_PH = '';
			objDetail.values = lstObj;
            
            lstDetails.add(objDetail);
        }
        system.debug('--List of lstDetails--'+lstDetails);
        /*List<ReservationDetail> dtlObj = new List<ReservationDetail>();
		
		ReservationDetail obj1 = new ReservationDetail();
		ReservationDetail obj2 = new ReservationDetail();
		ReservationDetail obj3 = new ReservationDetail();
		
		obj1.setFromDate(String.valueOf(datetime.newInstance(2016,04, 1, 0, 0, 0).getTime())); 
		obj1.setToDate(String.valueOf(datetime.newInstance(2016,05, 30, 0, 0, 0).getTime()));
		obj1.desc_PH = 'Booked by : Testing 1 <br /> for JQuery Demo';
		obj1.label = 'Testing 1';
		obj1.customClass = 'ganttRed';
		
		obj2.setFromDate(String.valueOf(datetime.newInstance(2016,06, 1, 0, 0, 0).getTime()));
		obj2.setToDate(String.valueOf(datetime.newInstance(2016,07, 30, 0, 0, 0).getTime()));
		obj2.desc_PH = 'Booked by :  Testing 2 <br /> for Wireless Lecture';
		obj2.label = 'Testing 2';
		obj2.customClass = 'ganttOrange';
		
		
		obj3.setFromDate(String.valueOf(datetime.newInstance(2016,09, 01, 0, 0, 0).getTime()));
		obj3.setToDate(String.valueOf(datetime.newInstance(2016,010, 30, 0, 0, 0).getTime()));
		obj3.desc_PH = 'Booked by :  Testing 3 <br /> for SAP Basis';
		obj3.label = 'Testing 3';
		obj3.customClass = 'ganttGreen';
		
		dtlObj.add(obj1);
		dtlObj.add(obj2);
		dtlObj.add(obj3);
		
		Room r = new Room();
		r.name = 'Training Room';
		r.desc_PH = 'This is Training Room';
		r.values = dtlObj;
		
		List<Room> r1 = new List<Room>();
		r1.add(r);*/
		
			
		return JSON.serialize(lstDetails).replaceAll('frm_PH','from').replaceAll('desc_PH','desc');
        //return null;
	}
	public class DetailsList
	{
		public List<Details> details;
	}
	public class Details
	{
		public String name{get;set;}
		public String desc_PH{get;set;}
		public List<ReleaseWindowDetail> values{get;set;}
	} 
	
	public class ReleaseWindowDetail
	{
		//actual variable name needed was "from", but it is keyword so we cant use that
		public String frm_PH{get;set;}
		public String to{get;set;}
		
		public String desc_PH{get;set;}
		public String label{get;set;}
		
		/*
			Custom class Can be anything from below:
			ganttRed
			ganttGreen
			ganttOrange
			
		*/
		public String customClass{get;set;}
		
		public void setToDate(String val)
		{
			to = setDate(val);
		}
		public void setFromDate(String val)
		{
			frm_PH = setDate(val);
		}
		//Date should be in special format as it is used in regular expression
		private String setDate(String val)
		{
			return '/Date('+val+')/';
		}
	}
}