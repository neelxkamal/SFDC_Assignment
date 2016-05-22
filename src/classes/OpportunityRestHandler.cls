public class OpportunityRestHandler {
    private static final String rootEndPoint = 'https://superman-caves.herokuapp.com/';
	 public static void opportunityCallout(String accName, ID id) {
        //String endPoint = rootEndPoint + 'opportunities/1';
        accName = EncodingUtil.urlEncode(accName, 'UTF-8');
        String endPoint = rootEndPoint + 'opportunities?name='+accName; 
        //endPoint = EncodingUtil.urlEncode(endPoint, 'UTF-8');
        system.debug('End Point---'+endPoint);
         
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(endPoint);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
         
        system.debug('response body ---' + response.getBody());
        // If the request is successful, parse the JSON response.
        if (response.getStatusCode() == 200) {
            List<OpportunityDTO> dtoList = (List<OpportunityDTO>) JSON.deserialize(response.getBody(), List<OpportunityDTO>.class );
            system.debug('Opp results :::' + dtoList);
            List<Opportunity> oppList = new List<Opportunity>();
            Opportunity opp = null;
            for(OpportunityDTO dto : dtoList) {
                opp = new Opportunity();
                opp.AccountId = id;
                opp.name = dto.name;
                opp.Amount = dto.amount;
                opp.Description = dto.description;
                opp.ForecastCategoryName = dto.forecastcategoryname;
                opp.LeadSource = dto.LeadSource;
                opp.NextStep = dto.nextstep;
                opp.Probability = dto.probabliity;
                opp.quote__c = dto.quote;
                opp.StageName = dto.stagename;
                opp.Type = dto.type;  
                opp.CloseDate = system.today().addDays(5);
                
                oppList.add(opp);
            }
            
            //Checking opportunity already exist or not. If already exxit then no need to insert.
            List<Opportunity> oppExt = null;
            for(Opportunity oppr : oppList){
                oppExt = [select id from Opportunity where accountid =: oppr.AccountId and name=:oppr.Name];
            }
            
            system.debug('Existing Opp---'+oppExt);
            //Inserting Opportuning records
            if(oppExt == null || !(oppExt.size() > 0)){
                System.debug('---Opportunity Insert---');
                Database.SaveResult[] srList = Database.insert(oppList, false);
                
                for (Database.SaveResult sr : srList) {
                    if(sr.isSuccess()) {
                         System.debug('Records Inserted successfully');     
                    }
                    else {
                        String errorMsg='';
                        for(Database.Error err : sr.getErrors()) {
                            System.debug('The following error has occurred.');                    
                            errorMsg = err.getStatusCode() + ': ' + err.getMessage() + '\r\n';
                            System.debug(err.getStatusCode() + ': ' + err.getMessage());
                            System.debug('Account fields that affected this error: ' + err.getFields());
                        }
                        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.WARNING,errorMsg));
                    }                
                }
        	}
        }
        
    }

    
}