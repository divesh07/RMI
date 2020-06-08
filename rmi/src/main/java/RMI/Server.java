package RMI;

import java.net.MalformedURLException;
import java.rmi.Naming;
import java.rmi.RemoteException;

//RMI Server
public class Server {

    public static void main(String[] args) throws RemoteException, MalformedURLException {
        //Create object of Add C
        // Instantiate the implementation class
        AddI stub = new AddC();

        // Server needs to registry the object name in registry
        // Use Rebind method for this
        Naming.rebind("rmi://localhost:5000/test", stub);
        System.out.println("Server Started");
    }
}
