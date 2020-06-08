package RMI;

public class Rmi {
    int i;
    int j;
    public void show(){};
    public void display(){};
}

class child {
    public static void main(String[] args) {
        // object is stored on stack memory
        // obj | 102
        // 102 is the address where the RMI object is actually created on stack
        Rmi object = new Rmi();
    }
}

// Note : What if stack and Heap are part of different JVM
// In that case we need to use RMI . Class A and Class B are on different machines

// 1. Create the remote interface - Ex : AddI
// 2. Implementation of Remote interface - Ex: AddC
// 3. Compile , stub (client) and skeleton ( Server - Heap Area - where object is created) ( rmic )
// 4. Start the registry (rmiregistry) - Mapping of address to the global names to avoid name
// conflicts.
// 5. Create and start server
// 6. Create and start client





