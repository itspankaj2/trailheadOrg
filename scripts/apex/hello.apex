// Use .apex files to store anonymous Apex.
// You can execute anonymous Apex in VS Code by selecting the
//     apex text and running the command:
//     SFDX: Execute Anonymous Apex with Currently Selected Text
// You can also execute the entire file by running the command:
//     SFDX: Execute Anonymous Apex with Editor Contents

string tempvar = 'Enter_your_name_here';
System.debug('Hello World!');
System.debug('My name is ' + tempvar);

Database.SaveResult result = StreamingApiDemo.sendMessage('Hello test 1');
System.debug(result);

Property__c property = new Property__c(
    Name = 'Not Admin',
    State__c = 'IN'
);
insert property;

ExampleDataApi.getAccountInfo();

Database.UnitOfWork