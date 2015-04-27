package common;

import java.util.Calendar;

public class Order {
    public String number;
    public String id;
    public String name;
    public String court_id;
    public String date;
    public String time;
    public String money;
    public String type;
    public Order(String number,String id,String name,String court_id,String date,String time,String money,String type){
    	this.number=number;
    	this.id=id;
    	this.name=name;
    	this.court_id=court_id;
    	this.date=date;
    	this.time=time;
    	this.money=money;
    	this.type=type;
    }
    public boolean CompareTo(Order order){
    	Calendar cc=Calendar.getInstance();
    	Calendar co=(Calendar) cc.clone();
    	cc=CurrentDateTime.stringToCalendar(cc, this.date,this.time);
    	co=CurrentDateTime.stringToCalendar(co, order.date, order.time);
    	return co.after(cc);
    }
}
