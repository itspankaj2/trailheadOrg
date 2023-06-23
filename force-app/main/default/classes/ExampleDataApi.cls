public with sharing class ExampleDataApi {
    public ExampleDataApi() {
    }

    public static Response getAccountInfo() {
        HttpRequest req = new HttpRequest();
        Http http = new Http();
        HTTPResponse response = new HTTPResponse();

        req.setMethod('GET');
        req.setEndpoint(
            'callout:selfsf/services/data/v57.0/query?q=SELECT+Id,Name+FROM+Account'
        );
        //here callout: is fixed, then after namecredintailname, then after add slash and appropitate url, in which url you want to hit
        response = http.send(req);

        System.debug('response-' + response);
        Response accounts = new Response();

        if (response.getStatusCode() != 200) {
            accounts.error = response.getStatusCode() + '' + response.getBody();
            return accounts;
        }

        try {
            accounts = (Response) JSON.deserializeStrict(
                response.getBody(),
                Response.class
            );
            System.debug(System.LoggingLevel.INFO, accounts);
        } catch (JSONException je) {
            accounts.error = 'JSON Exception :' + je.getCause();
            System.debug(System.LoggingLevel.ERROR, je);
            return accounts;
        }

        System.debug('response-' + response.getBody());
        return accounts;
    }

    public class Response {
        public Boolean done;
        public Integer totalSize;
        public List<Account> records;
        public String error;
    }
}
