package portchecker;


import java.net.*;
import java.io.*;

public class portcheck {
    public static void main(String[] args) throws IOException {
    	int portNumber =0;
    	ServerSocket serverSocket = null;
        try{
        	if (args.length != 1) {
                System.err.println("Usage: java -jar portcheck.jar <port number>");
                System.exit(1);
            }else{
            	portNumber = Integer.parseInt(args[0]);
            }
        }catch(Exception e){
        	
        }
    	
    	try{
    		serverSocket = new ServerSocket(portNumber);
        }catch(Exception e){
        	System.err.println("Can't assign a port number to the socketserver.");
        	System.exit(1);
        }
    	
    	while(true){
    	   try{
    		    
               Socket clientSocket = serverSocket.accept();
         } catch (IOException e) {
              System.out.println("Exception caught when trying to listen on port "
                  + portNumber + " or listening for a connection");
              System.out.println(e.getMessage());
          }
    	  
      }
        

     
    }
}

