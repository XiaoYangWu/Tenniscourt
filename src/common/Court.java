package common;

public class Court {
    private int index; 
	private int openTimeAmount;
	private String startTime;
	private TimePeriod timePeriod;
     
    public Court(int index,String startTime,int openTimeAmount){
    	this.index=index;
    	this.startTime=startTime;
    	this.openTimeAmount=openTimeAmount;
    	timePeriod=new TimePeriod(openTimeAmount);
    }
    public void setTimePeriod(TimePeriod timePeriod){
    	this.timePeriod=timePeriod;
    }
    public TimePeriod getTimePeriod(){
    	return timePeriod;
    }
    public void setOpenTimeAmount(int openTimeAmount){
    	this.openTimeAmount=openTimeAmount;
    }
    public int getOpenTimeAmount(){
    	return openTimeAmount;
    }
    public void startTime(String startTime){
    	this.startTime=startTime;
    }
    public String getstartTime(){
    	return startTime;
    }
    public void setIndex(int index){
    	this.index=index;
    }
    public int getIndex(){
    	return index;
    }
}
