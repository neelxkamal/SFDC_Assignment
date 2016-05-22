public class OpportunityController {
	
    public String name {
        get { return name;}
        set { name = value;}
    } 
    
    private List<Opportunity> oppr;
    
    public List<Opportunity> getOppr() {
        return oppr;
    }
    
    
    public PageReference getOpportunity() {
        String accName = '%' + name + '%';
        List<Account> accList = null;
        Set<String> nameSet = new Set<String>();
        
        accList = [Select id, name from account where name like:accName];
        system.debug('Print account name ::: ' + accList);
        
        if(accList==null || accList.size()==0) {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.WARNING,'Account name does not exist'));
        }
        else {
            for(Account acc : accList){
                if(!Test.isRunningTest()) {
                	OpportunityRestHandler.opportunityCallout(acc.name, acc.id);   
                }
                nameSet.add(acc.name);
			}
            
            oppr = [select account.name, name, account.billingstate, amount from Opportunity where account.name =: nameSet ];
            system.debug('Opportunity ::: ' + oppr);
    	}
        return null;
    }
    
    
}