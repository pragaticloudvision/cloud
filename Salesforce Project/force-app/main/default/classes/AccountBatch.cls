global class AccountBatch implements Database.Batchable <sObject>,Database.Stateful { 
    global Integer recordsProcessed = 0;
    
 global Database.QueryLocator start(Database.BatchableContext info){ 
     String SOQL='SELECT ID, BillingStreet, BillingCity, BillingState,BillingPostalCode, (SELECT ID, MailingStreet, MailingCity,MailingState, MailingPostalCode FROM Contacts) FROM Account';
       return Database.getQueryLocator(SOQL);
   }
     global void execute(Database.BatchableContext bc, List<Account> scope) {
       
       List<Contact> UpdatedContact = new List<Contact>();
         for (Account a: scope) {
             for (Contact c : a.contacts ) {
                c.MailingStreet= a.BillingStreet;
                c.MailingCity= a.BillingCity;
                c.MailingState= a.BillingState;
                c.MailingPostalCode= a.BillingPostalCode;
                UpdatedContact.add(c); //adding contact to the list to be updated
                recordsProcessed = recordsProcessed + 1;
             }
        }
        update UpdatedContact;   
    }
   global void finish(Database.BatchableContext bc) {
    System.debug(recordsProcessed + ' records processed');
        AsyncApexJob job = [Select ID, status, NumberOfErrors, JobItemsProcessed, TotalJobItems, CreatedBy.Email FROM AsyncApexJob
                            WHERE ID = :bc.getJobId()];
        //getting the id of the asyncApexJob representing this batch job
         Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            String[] toAddresses = new String[] {job.CreatedBy.Email};
            mail.setToAddresses(toAddresses);
            mail.setSubject('Match Merge Batch ' + job.Status);
            mail.setPlainTextBody('The batch Apex job processed ' + job.TotalJobItems +
           ' batches with '+ job.NumberOfErrors + ' failures.');
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }     
}