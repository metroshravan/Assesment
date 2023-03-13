trigger CreateTeamMembers on Account (after insert) {

    List<Team_Members__c> teamMembersToInsert = new List<Team_Members__c>();
    
    for(Account acc : Trigger.new) {
        
        //Team Member 1
        Team_Members__c	 team1 = new Team_Members__c();
        team1.Account__c = acc.Id;
        team1.Name = 'Team Member 1';
        team1.Member_Type__c = 'Blank';
        team1.Contact_Info__c = 'Blank';
        teamMembersToInsert.add(team1);
        
        //Team Member 2
        Team_Members__c	 team2 = new Team_Members__c	();
        team2.Account__c = acc.Id;
        team2.Name = 'Team Member 2';
        team2.Member_Type__c = 'Blank';
        team2.Contact_Info__c = 'Blank';
        teamMembersToInsert.add(team2);
    }
    
    // Insert the new team member records
    insert teamMembersToInsert;

}