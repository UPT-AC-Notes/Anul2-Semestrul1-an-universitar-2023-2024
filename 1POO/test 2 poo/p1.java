abstract class Utilizator{
	protected String nume;
	abstract public double calculezaVenit(int nr);
	public Utilizator(String nume){
		this.nume=nume;
	}
}
class Subscriber extends Utilizator{
	
	private int nivel;
	public Subscriber(String nume,int nivel){
		super(nume);
		this.nivel=nivel;
	}	
	public double calculezaVenit(int nr){
		return nivel*nr*(1.5);
	}
	public String toString(){
		return nume+" -subscriber- "+nivel+" "; 
	}
}
class Creator extends Utilizator{
	private Subscriber[] sub=new Subscriber[2];
	private int contor=0;
	public Creator(String nume){
		super(nume);
	}
	public void adaugaSubscriber(Subscriber x){
		if(contor==sub.length)
		{
			Subscriber[] aux =new Subscriber[2*sub.length];
			for(int i=0;i<contor;i++)
				aux[i]=sub[i];
			sub=aux;
		}
		sub[contor]=x;
		contor++;
	}
	public double calculezaVenit(int nr){
		double s=0;
		for(int i=0;i<contor;i++)
			s=s+sub[i].calculezaVenit(nr);
		return s;
	}
	public String toString(){
		String s=" ";
		s=s+nume+" -creator- ";
		for(int i=0;i<contor;i++)
		{
			s=s+sub[i].toString();
		}
		return s;
	}
}
class Platforma{
	private Utilizator[] util=new Utilizator[1000];
	private int contor=0;
	public boolean adaugaUtilizator(Utilizator u){
		if(contor==util.length)
		{
			return false;
		}
		util[contor]=u;
		contor++;
		return true;
	}
	public Utilizator determinareVIP(int nr)
	{
		if(contor!=0)
		{
			Utilizator u=util[0];
			for(int i=1;i<contor;i++)
			{
				if(u.calculezaVenit(nr)<util[i].calculezaVenit(nr))
				{
					u=util[i];
				}
			}
			return u;
		}
		return null;
	}
}
class main{
	public static void main(String[] argv){
		Subscriber a,b,c,d,e,f;
		a=new Subscriber("a",1);
		b=new Subscriber("b",1);
		c=new Subscriber("c",1);
		d=new Subscriber("d",1);
		e=new Subscriber("e",1);
		f=new Subscriber("f",1);
		Creator x,y;
		x=new Creator("x");
		x.adaugaSubscriber(a);
		x.adaugaSubscriber(b);
		y=new Creator("y");
		y.adaugaSubscriber(c);
		y.adaugaSubscriber(d);
		y.adaugaSubscriber(e);
		//System.out.println(y.toString());
		Platforma p=new Platforma();
		p.adaugaUtilizator(x);
		//p.adaugaUtilizator(y);
		p.adaugaUtilizator(f);
		Utilizator h;
		h=p.determinareVIP(30);
		System.out.println(h.toString());
	}
}