@isTest
global with sharing class ExampleDataApiTest implements HttpCalloutMock {
    private static String responseBody = '';
    private static Integer statusCode = 200;
    private User admin = TestUtility.getAdminUser();
    public ExampleDataApiTest() {
    }

    @TestSetup
    static void makeData() {
        // admin = TestUtility.getAdminUser();
        Database.SaveResult result = Database.insert(
            this.admin,
            true,
            AccessLevel.SYSTEM_MODE
        );

        if (!result.isSuccess()) {
            Assert.fail('Failed to insert admin account, It should not happen');
        }
    }

    @isTest
    private static void testForGettingAccounUsingRest() {
        System.debug(LoggingLevel.ERROR, this.admin);
        responseBody = '{"totalSize":339,"done":true,"records":[{"attributes":{"type":"Account","url":"/services/data/v57.0/sobjects/Account/0011000001NxsMMAAZ"},"Id":"0011000001NxsMMAAZ","Name":"Testchangechange"},{"attributes":{"type":"Account","url":"/services/data/v57.0/sobjects/Account/0011000001LxeuWAAR"},"Id":"0011000001LxeuWAAR","Name":"MyAccount0changechange"}]}';
        System.runAs(this.admin) {
            //given
            Test.startTest();
            Test.setMock(HttpCalloutMock.class, new ExampleDataApiTest());

            // when
            ExampleDataApi.Response res = ExampleDataApi.getAccountInfo();
            Test.stopTest();

            // then
            Assert.areEqual(339, res.totalSize);
            Assert.areEqual(true, res.done, 'should come as true');
        }
    }

    @isTest
    private static void testForBadJson() {
        responseBody = '{"totalSiz":339,"done":true,"records":[{"attributes":{"type":"Account","url":"/services/data/v57.0/sobjects/Account/0011000001NxsMMAAZ"},"Id":"0011000001NxsMMAAZ","Name":"Testchangechange"},{"attributes":{"type":"Account","url":"/services/data/v57.0/sobjects/Account/0011000001LxeuWAAR"},"Id":"0011000001LxeuWAAR","Name":"MyAccount0changechange"}]}';
        System.runAs(this.admin) {
            //given
            Test.startTest();
            Test.setMock(HttpCalloutMock.class, new ExampleDataApiTest());

            // when
            ExampleDataApi.Response res = ExampleDataApi.getAccountInfo();
            Test.stopTest();

            // then
            Assert.isTrue(
                res.error.contains('JSON Exception'),
                'JSON Format is incorrect'
            );
            System.debug(LoggingLevel.INFO, res);
        }
    }

    @isTest
    private static void testForNotOkStatusCode() {
        statusCode = 404;
        responseBody = '{"totalSiz":339,"done":true,"records":[{"attributes":{"type":"Account","url":"/services/data/v57.0/sobjects/Account/0011000001NxsMMAAZ"},"Id":"0011000001NxsMMAAZ","Name":"Testchangechange"},{"attributes":{"type":"Account","url":"/services/data/v57.0/sobjects/Account/0011000001LxeuWAAR"},"Id":"0011000001LxeuWAAR","Name":"MyAccount0changechange"}]}';
        System.runAs(this.admin) {
            //given
            Test.startTest();
            Test.setMock(HttpCalloutMock.class, new ExampleDataApiTest());

            // when
            ExampleDataApi.Response res = ExampleDataApi.getAccountInfo();
            Test.stopTest();

            // then
            Assert.isTrue(res.error.contains('400'), 'Status code not correct');
            System.debug(LoggingLevel.INFO, res);
        }
    }

    global HTTPResponse respond(HTTPRequest req) {
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody(responseBody);
        res.setStatusCode(statusCode);
        return res;
    }
}
