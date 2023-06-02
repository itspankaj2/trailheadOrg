public with sharing class accountWithContactController {
  @AuraEnabled
  public static List<Account> getAccountWithContact() {
    try {
      List<Account> accounts = [
        SELECT id, name, website, phone
        FROM Account
        LIMIT 10
      ];
      return accounts;
    } catch (Exception e) {
      throw new AuraHandledException(e.getMessage());
    }
  }
}
