import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;


public class ReadCSV {

	public ReadCSV(String path){
		// Open the file
		try{
			FileInputStream fstream = new FileInputStream(path);
			BufferedReader br = new BufferedReader(new InputStreamReader(fstream));

			String strLine;
			PrintWriter writer = new PrintWriter("export.sql", "UTF-8");
			writer.println("INSERT INTO `michaelwijnands_lv`.`clients` (`user_name`, `company`, `email`, `serial_no`, `additional_information`) VALUES ");
			
			//Read File Line By Line
			int counter = 0;
			while ((strLine = br.readLine()) != null)   {
			  // Print the content on the console
			
			  System.out.println (strLine);
			  writer.println("('naam"+counter+"','company"+counter+"','mail"+counter+"@michaelwijnands.nl','"+strLine+"','extra-info"+counter+"'),");
			  counter++;
			}

			//Close the input stream
			br.close();
			writer.close();
		}catch(Exception e){
			System.out.println(e.getMessage());
		}
			}
	public static void main(String[] args){
		if(args.length > 0){
			new ReadCSV(args[0]);
		}
	}
}
