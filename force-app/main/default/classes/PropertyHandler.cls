public with sharing class PropertyHandler extends fflib_SObjectDomain {
  //private static  final fflib_Logger LOgger = fflib_LoggerUtil.getFactory().createLogger('hello');
  PropertySelector selector = new PropertySelector();
  public PropertyHandler(List<Property__c> records) {
    super(records);
  }

  public class Constructor implements fflib_SObjectDomain.IConstructable {
    public fflib_SObjectDomain construct(List<SObject> records) {
      return new PropertyHandler(records);
    }
  }

  public override void onBeforeInsert() {
    for (Property__c property : (List<Property__c>) Records) {
      property.Name = property.Name + '1';
    }
  }

  public override void onAfterInsert() {
  }
}
