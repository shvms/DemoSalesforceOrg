public with sharing class ContactAndLeadSearch {
    public static List<List<SOBJECT>> searchContactsAndLeads(String searchKey) {
        List<List<SOBJECT>> results = [FIND :searchKey IN ALL FIELDS RETURNING Contact(FirstName, LastName), Lead(FirstName, LastName)];
        
        return results;
    }
}
