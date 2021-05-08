public class accountlist {
    @AuraEnabled
    public static list<account>accounts()
    {
        return [select name,type,annualrevenue from account limit 20];
    }
    @AuraEnabled
    public static list<account>accountbyname(String aname)
    {
        return [select name,type,annualrevenue from account where name like:aname+'%']; 
    }
}