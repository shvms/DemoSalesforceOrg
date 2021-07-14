public with sharing class ContactSearch {
    public static List<Contact> searchForContacts(String lastName, String mailingPostalCode) {
        /** not scalable: should consider appending the list in a for loop
         *  if the SOQL query is expected to produce more than 200 records.
         */
        List<Contact> contacts = [SELECT Id, Name FROM Contact WHERE LastName=:lastName AND MailingPostalCode=:mailingPostalCode];
        return contacts;
    }
}

// not possible because only root queries support aggregate expressions
// SELECT Name, (SELECT COUNT(Id) FROM Contacts GROUP BY Id) FROM Account

// SELECT AccountId, count(Id) FROM Contact GROUP BY AccountId
// SELECT Account.Name, count(Id) FROM Contact WHERE Account.Name != null GROUP BY Account.Name