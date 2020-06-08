package RMI;

import java.rmi.RemoteException;
import java.rmi.server.UnicastRemoteObject;

// ADDC is the implementation of interface on the Server Side
public class AddC extends UnicastRemoteObject implements AddI {

    public AddC() throws RemoteException {
        super();
    }

    @Override
    public int add(final int x, final int y) throws RemoteException {
        return x + y;
    }
}
