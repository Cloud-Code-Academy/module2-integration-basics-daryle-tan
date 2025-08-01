public with sharing class ContactTriggerHandler {
    public static void beforeInsert(List<Contact> newContacts) {
        for(Contact c : newContacts) {
            if(c.DummyJSON_Id__c == null) {
                Integer randomNum = Math.mod(Math.abs(Crypto.getRandomInteger()), 101);
                c.DummyJSON_Id__c = String.valueOf(randomNum);
            }
        }
    }

    public static void afterInsert(List<Contact> newContacts) {
        for(Contact c : newContacts) {
            if(c.DummyJSON_Id__c != null && Integer.valueOf(c.DummyJSON_Id__c) <= 100) {
                DummyJSONCallout.getDummyJSONUserFromId(c.DummyJSON_Id__c);
            }
        }
    }

    public static void afterUpdate(List<Contact> updatedContacts) {
        for(Contact c : updatedContacts) {
            if(c.DummyJSON_Id__c != null && Integer.valueOf(c.DummyJSON_Id__c) > 100) {
                DummyJSONCallout.postCreateDummyJSONUser(c.Id);
            }
        }
    }
}