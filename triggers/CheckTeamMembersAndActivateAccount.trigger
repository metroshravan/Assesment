trigger CheckTeamMembersAndActivateAccount on Account (before update) {
    
    Set<Id> accountIds = new Set<Id>();
    for(Account acc : Trigger.new) {
        if(acc.Active__c && !Trigger.oldMap.get(acc.Id).Active__c) {
            accountIds.add(acc.Id);
        }
    }
    
    if(accountIds.isEmpty()) {
        return;
    }
    
    List<Team_Members__c> hrTeamMembers = [SELECT Id FROM Team_Members__c WHERE Account__c IN :accountIds AND Member_Type__c = 'HR'];
    List<Team_Members__c> adminTeamMembers = [SELECT Id FROM Team_Members__c WHERE Account__c IN :accountIds AND Member_Type__c = 'Admin'];
    
    for(Account acc : Trigger.new) {
        if(acc.Active__c && !Trigger.oldMap.get(acc.Id).Active__c) {
            if(hrTeamMembers.size() == 0 || adminTeamMembers.size() == 0) {
                acc.addError('Accounts cannot be activated without at least one HR and one Admin team member.');
            }
        }
    }
    
    if(!UserInfo.getProfileId().equals('insert profile ID here')) {
        for(Account acc : Trigger.new) {
            if(acc.Active__c && !Trigger.oldMap.get(acc.Id).Active__c) {
                acc.addError('You do not have permission to activate accounts.');
            }
        }
    }
    
}