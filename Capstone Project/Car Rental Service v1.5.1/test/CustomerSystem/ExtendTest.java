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

/**
 *
 * @author Pro-J
 */
public class ExtendTest {
    
    public ExtendTest() {
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
     * Test of checkRegistration method, of class Extend.
     */
    @Test
    public void testCheckRegistration() {
        System.out.println("checkRegistration");
        
        // declare registration variables
        // variables are set to correct values  
        int renterID = 1;
        String tagInput = "TST123";
        Extend instance = new Extend();
        
        // declare booleans used for results
        // checkRegistration expected to succeed
        boolean expResult = false;
        boolean result = false;
        result = instance.checkRegistration(renterID, tagInput);
        assertEquals(expResult, result);
    }

    /**
     * Test of extendRental method, of class Extend.
     */
    @Test
    public void testExtendRental() {
        System.out.println("extendRental");
        String tagInput = "1";
        String newDate = "1";
        Extend instance = new Extend();
        instance.extendRental(tagInput, newDate);
    }

    /**
     * Test of calculateCharge method, of class Extend.
     */
    @Test
    public void testCalculateCharge() {
        System.out.println("calculateCharge");
        int rentalType = 1;
        String oldDate = "1";
        String newDate = "JAN 1 2021";
        Extend instance = new Extend();
        int expResult = 0;
        int result = instance.calculateCharge(rentalType, oldDate, newDate);
        assertEquals(expResult, result);
    }
    
}
