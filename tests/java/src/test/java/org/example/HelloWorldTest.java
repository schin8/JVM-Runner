package org.example;

import org.junit.jupiter.api.Test;
import java.io.ByteArrayOutputStream;
import java.io.PrintStream;
import static org.junit.jupiter.api.Assertions.assertEquals;

/**
 * Unit test for simple App.
 */
public class HelloWorldTest {

    /**
    
     */
    @Test
    public void testMainOutput() {
        // Create a stream to hold the output
        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
        PrintStream originalOut = System.out;
        
        try {
            // Redirect System.out to our stream
            System.setOut(new PrintStream(outputStream));
            
            // Call the main method
            HelloWorld.main(new String[]{});
            
            // Get the output and trim any whitespace
            String output = outputStream.toString().trim();
            
            // Verify the output
            assertEquals("Hello World!", output);
        } finally {
            // Restore System.out
            System.setOut(originalOut);
        }
    }
}
