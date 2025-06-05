trigger insertTrigger1 on Teacher__c (before insert) {
    for(Teacher__c teacher : Trigger.new){
        if(teacher.TName__c == 'NewTeacher'){
            teacher.Experience__c = 2; 
        }else{
            teacher.Experience__c = 5; 
        }
    }
}