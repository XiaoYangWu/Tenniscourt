package common;

public class CourtSet {
    private static CourtSet courtset;
    private Court court1;
    private Court court2;
    private Court court3;
    private Court court4;
    private CourtSet(String startTime,int openTimeAmount){
    	court1=new Court(1, startTime, openTimeAmount);
    	court2=new Court(2, startTime, openTimeAmount);
    	court3=new Court(3, startTime, openTimeAmount);
    	court4=new Court(4, startTime, openTimeAmount);
    }
    public static CourtSet getInstance(String startTime,int openTimeAmount){
    	courtset=new CourtSet(startTime,openTimeAmount);
    	return courtset;
    }
    public Court getCourt(int i){
    	
    		if(1==i)
    			return court1;
    		else if(2==i)
    			return court2;
    		else if(3==i)
    			return court3;
    		else 
    			return court4;
    	
    	
    }
    	
}

