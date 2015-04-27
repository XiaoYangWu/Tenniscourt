package common;

import java.io.PrintWriter;
import java.util.Calendar;

public class CurrentDateTime {
     private Calendar c;
     public CurrentDateTime()
     {
    	 c=c.getInstance();
     }
     public String getDate()
     {
    	 String date=null;
    	 int year = c.get(Calendar.YEAR); 
    	 int month = c.get(Calendar.MONTH)+1; 
    	 int day = c.get(Calendar.DATE); 
    	 date=year+"-"+month+"-"+day;
    	 
    	 return date;
     }
     public String getTime()
     {
    	 String time=null;
    	 int hour = c.get(Calendar.HOUR_OF_DAY); 
    	 int minute = c.get(Calendar.MINUTE); 
    	 int second = c.get(Calendar.SECOND); 
    	 time=hour+":"+minute+":"+second;
    	 return time;
     }
     public String getSpecifiedDate(int number){
    	 String date=null;
    	 if(0==number)
    		 return getDate();
    	 c.add(c.DATE,number);
    	 int year = c.get(Calendar.YEAR); 
    	 int month = c.get(Calendar.MONTH)+1; 
    	 int day = c.get(Calendar.DATE); 
    	 date=year+"-"+month+"-"+day;
    	 return date;
     }
     public static int timeStringToInt(String time){
    	 String []temp=time.split(":");
    	 return Integer.parseInt(temp[0]);
    	 
     }
     public static int[] timePeriodToInt(String time){
    	 int[] intTime=new int[2]; 
    	 String []temp1=time.split("-");
    	 String []temp2=temp1[0].split(":");
    	 String []temp3=temp1[1].split(":");
    	 intTime[0]=Integer.parseInt(temp2[0]);
    	 intTime[1]=Integer.parseInt(temp3[0]);
    	 return intTime;
     }
     public static String intPeriodToString(int starttime,int period){
    	 String time=null;
         int start=starttime+period-1;
         int end=starttime+period;
         if(start<10&&end<10)
        	 time="0"+start+":00-"+"0"+end+":00";
         else if(start<10&&end>=10)
        	 time="0"+start+":00-"+end+":00";
         else if(start>=10&&end<10)
        	 time=start+":00-"+"0"+end+":00";
         else
             time=start+":00-"+end+":00";
    	 return time;
     }
     
     public static int[] dayStringToIntArray(String day){
    	 String []temp=day.split(",");
    	 int []dayOfWeek=new int[temp.length];
    	 for(int i=0;i<temp.length;i++)
    	 {
    		 if("星期一".equals(temp[i]))
    			 dayOfWeek[i]=2;
    		 if("星期二".equals(temp[i]))
    			 dayOfWeek[i]=3;
    		 if("星期三".equals(temp[i]))
    			 dayOfWeek[i]=4;
    		 if("星期四".equals(temp[i]))
    			 dayOfWeek[i]=5;
    		 if("星期五".equals(temp[i]))
    			 dayOfWeek[i]=6;
    		 if("星期六".equals(temp[i]))
    			 dayOfWeek[i]=7;
    		 if("星期日".equals(temp[i]))
    			 dayOfWeek[i]=1;
    	 }
    	 return dayOfWeek;
     }
     public static int[][]  timePeriodsToInt(String period){
    	 int [][]timeperiods=null;
    	 String []temp1=period.split(",");
    	 timeperiods=new int[temp1.length][2];
    	 for(int i=0;i<temp1.length;i++){
    		 String []temp2=temp1[i].split("-");
    		 String []temp3=temp2[0].split(":");
    		 String []temp4=temp2[1].split(":");
    		 timeperiods[i][0]=Integer.parseInt(temp3[0]);
    		 timeperiods[i][1]=Integer.parseInt(temp4[0]);
    	 }
    	 return timeperiods;
    	 
     }
     public static String[] datesStringToArray(String datesFree){
    	 
    	 String []freeDate=datesFree.split(",");
    	 return freeDate;
    	 
     }
     public static String intDayOfWeekToString(int dayOfWeek){
    	 String week=null;
    	 if(1==dayOfWeek)
    		 week="Sunday";
    	 if(2==dayOfWeek)
    		 week="Monday";
    	 if(3==dayOfWeek)
             week="Tuesday";
    	 if(4==dayOfWeek)
    		 week="Wednesday";
    	 if(5==dayOfWeek)
    		 week="Thursday";
    	 if(6==dayOfWeek)
    		 week="Friday";
    	 if(7==dayOfWeek)
    		 week="Saturday";
    	 
    	 return week;
     }
     public int getCurrentHour(){
    	 int nowHour=c.get(Calendar.HOUR_OF_DAY);
    	 return nowHour;
     }
     public boolean isToday(String date){
    	 String[] temp=date.split("-");
    	 if((c.get(Calendar.YEAR)==Integer.parseInt(temp[0]))&&((c.get(Calendar.MONTH)+1)==Integer.parseInt(temp[1]))&&(c.get(Calendar.DATE)==Integer.parseInt(temp[2])))
    		 return true;
    	 else
    		 return false;
     }
     public static Calendar stringToCalendar(Calendar cc,String date,String time){
    	 String []temp1=date.split("-");
    	 String []temp2=time.split("-");
    	 String []temp3=temp2[0].split(":");
    	cc.set(Integer.parseInt(temp1[0]),Integer.parseInt(temp1[1])-1,Integer.parseInt(temp1[2]),Integer.parseInt(temp3[0]),0,0);
    	
    	 return cc;
     }
     public static String calendarDateToString(Calendar cc){
    	 String toDate=null;
    	 int year=cc.get(Calendar.YEAR);
    	 int month=cc.get(Calendar.MONTH)+1;
    	 int date=cc.get(Calendar.DATE);
    	 toDate=year+"-"+month+"-"+date;
    	 return toDate;
     }
}
