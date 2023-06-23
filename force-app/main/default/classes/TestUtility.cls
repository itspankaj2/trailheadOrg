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

        return admin;
    }
}
