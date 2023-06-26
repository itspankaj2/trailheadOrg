public abstract with sharing class TestUtility {
    public TestUtility() {
    }

    public static User getAdminUser() {
        Profile adminProfile = [
            SELECT id
            FROM Profile
            WHERE Name = 'System Administrator'
            WITH SYSTEM_MODE
        ];

        User admin = new User(
            LastName = 'testUserRandom007',
            email = 'testAdmin@amanwakahe.com',
            username = 'testAdmin@amanwakahe.com',
            profileId = adminProfile.id,
            Alias = 'admin',
            TimeZoneSidKey = 'GMT',
            LocaleSidKey = 'en_US',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US'
        );

        Database.SaveResult result = Database.insert(
            admin,
            true,
            AccessLevel.SYSTEM_MODE
        );

        if (!result.isSuccess()) {
            Assert.fail('Failed to insert admin account, It should not happen');
        }
        return admin;
    }
}
