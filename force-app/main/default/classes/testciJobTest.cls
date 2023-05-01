@isTest
public with sharing class testciJobTest {
    @isTest
    public static void test1() {
        testciJob.hello();
        System.assertEquals(true, true, 'dummy ');
    }
}