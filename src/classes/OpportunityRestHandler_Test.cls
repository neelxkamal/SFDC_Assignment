@isTest
public class OpportunityRestHandler_Test {
    @isTest static void OpportunityCallout(){
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('OpportunityTestData');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
        // Associate the callout with a mock response
        Test.setMock(HttpCalloutMock.class, mock);
        
        Account accTest = new Account(name='Ankunding-Maggio');
        //insert accTest;
        
        OpportunityRestHandler.opportunityCallout(accTest.name, accTest.Id);
        
        
	}
}