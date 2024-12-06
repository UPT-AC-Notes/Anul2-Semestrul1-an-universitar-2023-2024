abstract class whiskey{
	protected nume;
	protected alcool;
	public whiskey(String nume,double alcool){
		this.nume=nume;
		this.alcool=alcool;
	}
	abstract public double getNrCalorii(double nr);
	abstract public String getConcentratieAlcool();
}
class ClassicWhiskey extends whiskey{
	public ClassicWhiskey(String nume,double alcool){
		super(nume,alcool);
	}
	public double getNrCalorii(double nr){
		return alcool*nr*5;
	}
	public String getConcentratieAlcool(){
		return nume+" ,Cantitate alcool: "+alcool+" %,Calorii pe 100ml: "+this.getNrCalorii+"kcal";
	}
}
class JackAndHoney extends whiskey{
	private int indulcitor;
	
}