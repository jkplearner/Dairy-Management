trigger insertTrigger on Branch__c (after insert) {
    for (Branch__c branch : Trigger.new) {
        if (branch.BName__c == 'NewBranch') {
            Teacher__c newTeacher = new Teacher__c();
            newTeacher.TName__c = 'NewBranchTeacher';
            insert newTeacher;
        }
    }
}