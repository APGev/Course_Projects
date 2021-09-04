/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package CustomerSystem;

import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import static org.junit.Assert.*;
import org.junit.Ignore;

/**
 *
 * @author Pro-J
 */
public class CarReturnTest {
    
    public CarReturnTest() {
    }
    
    @BeforeClass
    public static void setUpClass() {
    }
    
    @AfterClass
    public static void tearDownClass() {
    }
    
    @Before
    public void setUp() {
    }
    
    @After
    public void tearDown() {
    }

    /**
     * Test of checkRegistration method, of class CarReturn.
     */
    @Test
    public void testCheckRegistration() {
        // testing description print
        System.out.println("checkRegistration");
        
        // declare registration variables
        // variables are set to correct values        
        int renterID = 1;
        String tagInput = "TST123";
        CarReturn instance = new CarReturn();
        
        // declare booleans used for results
        // checkRegistration expected to succeed
        boolean expResult = false;
        boolean result = false;
        // test checkRegistration methdo
        result = instance.checkRegistration(renterID, tagInput);
        // check expected result against actual result
        assertEquals(expResult, result);
    }

    /**
     * Test of validateInput method, of class CarReturn.
     */
    @Test
    public void testValidateInput() {
        // testing description print
        System.out.println("validateInput");
        
        // declare registration variables
        // variables are set to correct values 
        String userInput = "TST123";
        CarReturn instance = new CarReturn();
        boolean expResult = true;
        boolean result = true;
        
        // test validateInput method
        result = instance.validateInput(userInput);
        // check expected result against actual result
        assertEquals(expResult, result);
    }
    
    @Test
    public void testValidateInputFail() {
        // testing description print
        System.out.println("validateInputemptytest");
        
        // declare registration variables
        // variables are set to correct values 
        String userInput = "";
        CarReturn instance = new CarReturn();
        boolean expResult = false;
        boolean result = false;
        
        // test validateInput method
        result = instance.validateInput(userInput);
        // check expected result against actual result
        assertEquals(expResult, result);
    }      
}
