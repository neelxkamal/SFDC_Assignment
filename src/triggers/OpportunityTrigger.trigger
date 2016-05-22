trigger OpportunityTrigger on Opportunity (before insert) {
	
    for(Opportunity oppr : Trigger.new){
        oppr.Quote__c = (Oppr.Quote__c * 20) /100;
    }
}