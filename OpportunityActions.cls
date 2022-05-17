public class OpportunityActions {
    public class Input {
      @InvocableVariable(label='Opportunity for Input' description='Record for Input')
      public Opportunity inputOpportunity;
    }

    public class Output {
      @InvocableVariable(label='Contracts created' description='Records for Output')
      public Contract outputContract;
        
        public Output(Contract contractValue) {
            outputContract = contractValue;
        }
    }
    
  @InvocableMethod(label='Create Draft Contract from Opportunity' description='Creates a Draft Contract from an Opportunity.' category='Opportunity')
  public static List<Output> createDraftContract(List<Input> oportunitiesList) {
        List<Output> result = new List<Output>();
        
    List<Contract> draftContractsToCreate = new List<Contract>();
        
        for (Input singleOpportunity :oportunitiesList) {
            Contract newContract = new Contract(Status='Draft', AccountId=singleOpportunity.inputOpportunity.AccountId,
              StartDate=System.today(), ContractTerm=12, Pricebook2Id = singleOpportunity.inputOpportunity.Pricebook2Id );
            
            draftContractsToCreate.add(newContract);
            result.add(new Output(newContract));
        }
        
        insert draftContractsToCreate;
        
        return result;
  }
}
