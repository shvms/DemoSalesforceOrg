public with sharing class AggBankAccToEntity {
    public static void initialize() {
        List<Legal_Entity__c> legalEntities = [SELECT Id, Number_of_Bank_Accounts__c FROM Legal_Entity__c];
        for (Legal_Entity__c legalEntity : legalEntities) {
            legalEntities.Number_of_Bank_Accounts__c = 0;
        }

        update legalEntities;
    }

    public static void aggregateValues() {
        List<AggregateResult> result = 
        [SELECT Legal_Entity__c, count(Id) accounts FROM Bank_Account__c WHERE Legal_Entity__c != null GROUP BY Legal_Entity__c];

        List<Legal_Entity__c> legalEntities = new List<Legal_Entity__c>();
        for (Integer i=0;i<result.size();++i) {
            Legal_Entity__c legalEntity = new Legal_Entity__c(
                Id=(String)result[i].get('Legal_Entity__c'),
                Number_of_Bank_Accounts__c=(Integer)result[i].get('accounts')
            );
            legalEntities.add(legalEntity);
        }

        System.debug(legalEntities);

        upsert legalEntities;
    }
}
