@isTest
public class OpportunityControllerTest {
    public static testMethod void testController() {
        Account accTest = new Account(name='Ankunding-Maggio', billingstate='CT');
        insert accTest;
        Opportunity oppTest = new Opportunity(name='Test Opportunity', accountId=accTest.id, Quote__c=6868, StageName='Prospecting', CloseDate=system.today());
        insert oppTest;
        PageReference pageRef = Page.AssociatedOpportunity; 
        Test.setCurrentPage(pageRef); 
		
        OpportunityController conlr = new OpportunityController();
        conlr.name = 'Ankunding-Maggio';
        system.debug('conlr.getOpportunity()---'+conlr.getOpportunity());
        conlr.getOpportunity();
        conlr.getOppr();
        
        
        //system.assertEquals(expected, actual)
    }
}