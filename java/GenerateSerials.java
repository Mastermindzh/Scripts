import java.io.FileNotFoundException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.Random;


public class GenerateSerials {
	public static double 	version 	= 1.0;
	String 					randoms 	= "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
	String					nrsonly		= "0123456789";
	Random					r			= new Random();
	public GenerateSerials(String groups, String members, String amount , String name, boolean nronly){
		if((isInteger(groups) && isInteger(members) && isInteger(amount))){
			//create new variables with the correct type
			int nrgroups = Integer.parseInt(groups);
			int nrmembers = Integer.parseInt(members);
			int nramount = Integer.parseInt(amount);
			if(nrgroups == 0 || nrmembers == 0 || nramount == 0){
				//error if either one is 0
				System.out.println("0 is an invalid character");
			}else{
				//if name is empty, use default
				if(name == ""){
					name = "export.txt";
				}
				try {
					PrintWriter writer = new PrintWriter(name, "UTF-8");
					//generation loop
					for(int a=1; a<=nramount; a++){
						//clear serial for next run.
						String serial = "";
						for(int i=1; i<=nrgroups; i++){
							  for(int ii=1; ii<=nrmembers; ii++){
								  if(nronly){
									  //use only numbers
									  serial = serial + nrsonly.charAt(r.nextInt(nrsonly.length()));
								  }
								  else{//use numbers and letters
									  serial = serial + randoms.charAt(r.nextInt(randoms.length()));  
								  }
							  }
							  //if not last print -
							  if(!(i==nrgroups)){
								  serial = serial + "-";
							  }
				        }
						writer.println(serial);
					} 
					//close printer so that file really gets written
					writer.close();
				} catch (FileNotFoundException | UnsupportedEncodingException e) {
					//error if something goes wrong with creating the writer
					e.printStackTrace();
				}		
			}
		}else{//error if the first 3 arguments aren't an integer
			System.out.println("One of the required arguments isn't an integer");
			System.exit(0);
		}
		
	}
	public GenerateSerials(String argument){
		switch(argument){
			case "--usage":
				printUsageInfo();
				break;
			case "--version":
				System.out.println(version);
				break;
		}
	}
	//main
	public static void main(String[] args){
		switch(args.length){
		case 0:
			System.out.println("You have to give at least 1 argument to run this program.");
			System.out.println("Append the argument '--usage' to find out how to use this program.");
			break;
		case 1:
			new GenerateSerials(args[0]);
			break;
		case 3:
			new GenerateSerials(args[0], args[1], args[2], "" , false);
			break;
		case 4:
			new GenerateSerials(args[0], args[1], args[2], args[3],false);
			break;
		case 5:
			new GenerateSerials(args[0], args[1], args[2], args[3], Boolean.valueOf(args[4]));
			break;
		}
	}
	
	//Methods
	public boolean isInteger(String s) {
	    try { 
	        Integer.parseInt(s); 
	    } catch(NumberFormatException e) { 
	        return false; 
	    }
	    return true;
	}
	
	public void printUsageInfo(){
		System.out.println("======== Usage Information ========");
		System.out.println("In order for this program to function properly you should provide at least 3 arguments.");
		System.out.println("The entire command should look like: java -jar class.java 0 0 0");
		System.out.println("Replace the first zero with the amount of groups you want and the second with the amount of members in each group. "
				+ "The third zero should be replaced with the number of serials you want.");
		System.out.println();
		System.out.println("Optional arguments:");
		System.out.println("  You can append a 4th argument to change the export file's path and name.");
		System.out.println("  The 5th argument is a boolean (true / false) if you give it true it will generate serials without letters");
		System.out.println();
		System.out.println("Single arguments:");
		System.out.println();
		System.out.println("--version");
		System.out.println("   prints program version number");
		System.out.println();
		System.out.println("--usage");
		System.out.println("   prints this list of usage info.");
	}
}

