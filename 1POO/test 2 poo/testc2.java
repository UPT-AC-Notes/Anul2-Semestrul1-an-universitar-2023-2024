import java.util.*;
abstract class teste{
	abstract public int getNumarTeste();
}
class WrongQualityIndicatorException extends Exception{
	public WrongQualityIndicatorException(String nume){
		super(nume);
	}
}
class WrongComponetcomplexiti extends Exception{
	public WrongComponetcomplexiti(String nume){
		super(nume);
	}
}
abstract class testesimple extends teste{
	protected String nume;
	protected int indicator;
	public testesimple(String nume,int indicator) throws WrongQualityIndicatorException
	{
		if(indicator<=10&&indicator>=1)
			this.indicator=indicator;
		else
			throw new WrongQualityIndicatorException("indicator gresit");
		this.nume=nume;
	}
	public int getNumarTeste(){
		return 1;
	}
	
}
class Integrationtest extends testesimple{
	public Integrationtest(String nume,int indicator)throws WrongQualityIndicatorException
	{
		super(nume,indicator);
	}
	public String toString(){
		return "Integrationtest(nume=["+nume+"] , qualiti indicator "+indicator+")";
	}
}
class Componenttest extends testesimple{
	private int complexitate;
	public Componenttest(String nume,int indicator,int complexitate) throws WrongComponetcomplexiti,WrongQualityIndicatorException
	{	super(nume,indicator);
		if(complexitate>0)
		this.complexitate=complexitate;
		else
			throw new WrongComponetcomplexiti("a aparut o exceptie");
		
	}
	public String toString(){
		return "Integrationtest(nume=["+nume+"] , qualiti indicator "+indicator+" complexitate "+ complexitate+")";
	}
}
class TesteSuita extends teste{
	private List<teste> mul=new ArrayList<teste>();
	public int getNumarTeste(){
		int i=0;
		Iterator <teste>it=mul.iterator();
		while(it.hasNext())
		{
			teste alfa=it.next();
			i=i+alfa.getNumarTeste();
		}
		return i;
	}
	public boolean addNewIntegrationtest(String nume,int indicator)
	{
		try{
			Integrationtest alfa=new Integrationtest(nume,indicator);
			mul.add(alfa);
		}catch(WrongQualityIndicatorException e){
			return false;
		}
		return true;
	}
	public boolean addNewComponenttest(String nume,int indicator,int complexiti)
	{
		try{
			Componenttest alfa=new Componenttest(nume,indicator,complexiti);
			mul.add(alfa);
		}catch(WrongComponetcomplexiti e){
			System.out.println(e.getMessage());
		}catch(WrongQualityIndicatorException e){
			return false;
		}
		return true;
	}
	public String toString(){
		String i="teste :(\n";
		Iterator <teste>it=mul.iterator();
		while(it.hasNext())
		{
			teste alfa=it.next();
			i=i+alfa.toString()+"\n";
		}
		i=i+")";
		return i;
	}
}
class Main{
	public static void main(String[] argv){
		TesteSuita t=new TesteSuita();
		t.addNewIntegrationtest("1",11);
		t.addNewIntegrationtest("2",2);
		t.addNewComponenttest("3",3,-5);
		t.addNewComponenttest("4",4,5);
		System.out.println(t.getNumarTeste()+"\n"+t.toString());
	}
}