trigger UpdateBankAccountsCount on Bank_Account__c (after insert, after delete, after update) {
    if (Trigger.isInsert) {
        List<Legal_Entity__c> legalEntities = new List<Legal_Entity__c>();
        for (Bank_Account__c acc : Trigger.New) {
            if (acc.Legal_Entity__c != null) {
                String legalEntityId = (String) acc.Legal_Entity__c;
                Legal_Entity__c legalEntity = [SELECT Number_of_Bank_Accounts__c FROM Legal_Entity__c WHERE Id = :legalEntityId];
                legalEntity.Number_of_Bank_Accounts__c = legalEntity.Number_of_Bank_Accounts__c != null ?
                    legalEntity.Number_of_Bank_Accounts__c + 1 : 1;
                
                legalEntities.add(legalEntity);
            }
        }
        update legalEntities;
    } else if (Trigger.isDelete) {
        List<Legal_Entity__c> legalEntities = new List<Legal_Entity__c>();
        for (Bank_Account__c acc : Trigger.Old) {
            if (acc.Legal_Entity__c != null) {
                String legalEntityId = (String) acc.Legal_Entity__c;
                Legal_Entity__c legalEntity= [SELECT Number_of_Bank_Accounts__c FROM Legal_Entity__c WHERE Id = :legalEntityId];
                legalEntity.Number_of_Bank_Accounts__c = legalEntity.Number_of_Bank_Accounts__c != null ?
                    legalEntity.Number_of_Bank_Accounts__c - 1 : 1;

                legalEntities.add(legalEntity);
            }
        }
        update legalEntities;
    } else if (Trigger.isUpdate) {
        List<Legal_Entity__c> legalEntities = new List<Legal_Entity__c>();

        for (Integer i=0;i<Trigger.New.size();++i) {
            Bank_Account__c newRecord = Trigger.New[i], oldRecord = Trigger.Old[i];
            if (newRecord.Legal_Entity__c != oldRecord.Legal_Entity__c) {
                if (oldRecord.Legal_Entity__c != null) {
                    String legalEntityId = (String) oldRecord.Legal_Entity__c;
                    Legal_Entity__c legalEntity= [SELECT Number_of_Bank_Accounts__c FROM Legal_Entity__c WHERE Id = :legalEntityId];
                    legalEntity.Number_of_Bank_Accounts__c -= 1;
                    legalEntities.add(legalEntity);
                }

                if (newRecord.Legal_Entity__c != null) {
                    String legalEntityId = (String) newRecord.Legal_Entity__c;
                    Legal_Entity__c legalEntity= [SELECT Number_of_Bank_Accounts__c FROM Legal_Entity__c WHERE Id = :legalEntityId];
                    legalEntity.Number_of_Bank_Accounts__c += 1;
                    legalEntities.add(legalEntity);
                }
            }
        }

        update legalEntities;
    }
}