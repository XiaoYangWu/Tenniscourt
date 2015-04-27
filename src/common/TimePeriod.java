package common;

public class TimePeriod {
      private boolean []period;
      public TimePeriod(int number)
      {
    	  period=new boolean[number];
    	  for(int i=0;i<number;i++){
    		  period[i]=true;
    	  }
      }
      public void setPeriod(int index,boolean status){
		  period[index]=status;
	  }
      public boolean getPeriod(int index){
    	  return period[index];
      }
}
