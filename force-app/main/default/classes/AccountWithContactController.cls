public with sharing class AccountWithContactController {
  /**
   *
   */
  @AuraEnabled(cacheable=true)
  public static List<Account> getAccountWithContact() {
    try {
      List<Account> accounts = [
        SELECT id, name, website, phone, (SELECT id, name, phone FROM Contacts)
        FROM Account
        LIMIT 10
      ];
      return accounts;
    } catch (Exception e) {
      throw new AuraHandledException(e.getMessage());
    }
  }
}
