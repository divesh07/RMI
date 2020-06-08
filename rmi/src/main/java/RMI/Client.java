package RMI;

import java.rmi.Naming;

public class Client {

    public static void main(String[] args)
            throws Exception {
        // Look up for implementation on server using registry
        // Look up would return object of ADD C hence type cast to ADDI
        AddI stub = (AddI) Naming.lookup("rmi://localhost:5000/test");
        int i = stub.add(5, 4);
        System.out.println("Output " + i);
    }
}
