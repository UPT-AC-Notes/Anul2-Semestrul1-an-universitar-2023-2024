import java.util.*;
abstract class destinatri{
	abstract public void receptioneaza(destinatri z,String y);
	protected String nume;
	public destinatri(String nume)
	{
		this.nume=nume;
	}
	abstract public String getnume();
	public boolean equals(Object o){
	if(!(o instanceof destinatri))
		return false;
	else{
		if(((destinatri)o).getnume().equals(this.getnume()))
			return true;
		else
			return false;
	}
	}	
}
class Utilizatori extends destinatri{
	private  String jurnal="";
	public Utilizatori(String nume){
		super(nume);
	}
	public String getnume(){
		return this.nume;
	}
	public void trimite(destinatri z,String y){
		jurnal=jurnal+"TRimis catre "+z.getnume()+" masajul "+y+"\n";
		z.receptioneaza(this,y);
	}
	
	public void receptioneaza(destinatri z,String y){
		jurnal=jurnal+"Primit de la "+z.getnume()+" mesajul "+y+"\n";
	}
	public String toString(){
		return nume+"\n"+jurnal;
	}
}
class DestinatrDuplicat extends Exception{
	public DestinatrDuplicat(String mesaj){
	super(mesaj);
    }
}
class Grup extends destinatri{
	public List<destinatri>vect=new ArrayList<destinatri>();
	public Grup(String nume){
		super(nume);
	}
	public String getnume(){
		return this.nume;
	}
	public void inscriere(destinatri x)throws DestinatrDuplicat{
		int ok=0;
		Iterator<destinatri> it=vect.iterator();
		while(it.hasNext())
		{
			destinatri alfa=it.next();
			if(alfa.equals(x))
			{
				throw new DestinatrDuplicat("obiecte egale \n");
			}
		}
		if(ok==0)
		{
			vect.add(x);
		}			
	}
	public void receptioneaza(destinatri z,String y){
		Iterator<destinatri> it=vect.iterator();
		while(it.hasNext())
		{
			destinatri alfa=it.next();
			if(alfa.equals(z)!=true)
				alfa.receptioneaza(z,y);
		}
	}		
}
class Main{
	public static void main(String[] argv){
	Utilizatori a,c,b;
	a=new Utilizatori("Dan");
	b=new Utilizatori("Mihai");
	c=new Utilizatori("Alex");
	Grup d=new Grup("Carnivorii");
	try{
		d.inscriere(a);
	}catch(DestinatrDuplicat e)
	{
		System.out.println(e.getMessage());
	}
	try{
		d.inscriere(b);
	}catch(DestinatrDuplicat e)
	{
		System.out.println(e.getMessage());
	}
	try{
		d.inscriere(c);
	}catch(DestinatrDuplicat e)
	{
		System.out.println(e.getMessage());
	}
	try{
		d.inscriere(c);
	}catch(DestinatrDuplicat e)
	{
		System.out.println(e.getMessage());
	}
	c.trimite(d,"Am deschis");
	b.trimite(d,"vin imediat");
	System.out.println(a.toString());
	System.out.println(b.toString());
	System.out.println(c.toString());
	}		
}