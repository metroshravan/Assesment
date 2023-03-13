trigger AcctTrigger on Account (before insert) {
    if(Trigger.isBefore && Trigger.isInsert){
        for(Account accrec : Trigger.New){
            accrec.Active__c = False;
        }
    }

}