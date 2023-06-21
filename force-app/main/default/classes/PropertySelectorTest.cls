@isTest
public with sharing class PropertySelectorTest {
  public PropertySelectorTest() {
  }

  @isTest
  private static void getPropertyIN() {
    Property__c propertyChild = new Property__c(
      Name = 'Not Admin4444',
      State__c = 'IN'
    );
    insert propertyChild;

    Property__c property = new Property__c(
      Name = 'Not Admin55',
      State__c = 'IN',
      Property__c = propertyChild.id
    );
    insert property;

    Test.startTest();
    PropertySelector selector = new PropertySelector();
    List<Property__c> properties = selector.getPropertyIN();
    // Assert.areEqual(2, properties.size(), 'Properties size should be 2');
    // //Assert.areEqual(1, properties)
    Test.stopTest();
  }
}
