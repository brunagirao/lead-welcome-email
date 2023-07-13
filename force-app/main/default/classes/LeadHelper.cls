/************************************************************************************************
* Name      : LeadHelper
* Purpose   : Helper class to Lead Trigger
* TestClass : LeadHelperTest
* Author    : Bruna Girão
* Date      : 12-07-2023
--------------------------------------------------------------------------------------------------
Date                Modified By             Description
--------------------------------------------------------------------------------------------------
12-07-2023         Bruna Girão             create class 
13-07-2023         Bruna Girão             update Custom Label
***************************************************************************************************/
public with sharing class LeadHelper {
    
    public static void sendWelcomeEmailMessage(List<Lead> newRecords) {
        System.debug('sendWelcomeEmailMessage');
        List<Lead> leadsToNotify = new List<Lead>();

        for(Lead ld : newRecords) {
            if(ld.NeedSendWelcomeMessage__c) {
                leadsToNotify.add(ld);
                System.debug('ld => ' + ld);
            }
            
        }
        System.debug('leadsToNotify => ' + leadsToNotify.size());
        EmailNotificationService.sendEmailNotificationLead(leadsToNotify, System.Label.LEAD_WELCOME_EMAIL_NOTIFICATION_TEMPLATE_NAME);
    }
}