public with sharing class PropertySelector extends fflib_SObjectSelector {
  final String STATE_IN = 'IN';
  public PropertySelector() {
    super(false);
  }

  public Schema.SObjectType getSObjectType() {
    return Property__c.SObjectType;
  }

  public List<Schema.SObjectField> getSObjectFieldList() {
    return new List<Schema.SObjectField>{
      Property__c.Id,
      Property__c.Name,
      Property__c.Start_Date__c,
      Property__c.End_Date__c
    };
  }

  public List<Property__c> getPropertyIN() {
    System.debug(
      LoggingLevel.INFO,
      Property__c.sObjectType.getDescribe().getChildRelationships().get(0)
    );
    return (List<Property__c>) Database.query(
      newQueryFactory()
        .selectField(Schema.Property__c.State__c)
        // .subSelectQuery(Property__c.sObjectType.getDescribe().getChildRelationships().get(0))
        .setCondition('State__c = :STATE_IN')
        .toSOQL()
    );
  }
}
