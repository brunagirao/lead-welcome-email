/************************************************************************************************
* Name      : EmailNotificationService
* Purpose   : Service class to send Email Notifications
* TestClass : EmailNotificationServiceTest
* Author    : Bruna Girão
* Date      : 12-07-2023
--------------------------------------------------------------------------------------------------
Date                Modified By             Description
--------------------------------------------------------------------------------------------------
12-07-2023         Bruna Girão             create class and sendEmailNotificationLead() method
13-07-2023         Bruna Girão             fix problem with Email Template merged fields
13-07-2023         Bruna Girão             add custom label to use as an attach in the email
***************************************************************************************************/
public with sharing class EmailNotificationService {
    
    public static String LEAD_WELCOME_EMAIL_TEMPLATE_PDF = System.Label.LEAD_WELCOME_EMAIL_NOTIFICATION_TEMPLATE_PDF; 
    
    public static void sendEmailNotificationLead(List<Lead> leads, String emailTemplate) {
        System.debug('sendEmailNotificationLead');
        System.debug('emailTemplate => ' + emailTemplate);
        
        Messaging.SingleEmailMessage mail;
        Messaging.EmailFileAttachment attach;

        List<Messaging.SingleEmailMessage> emailsToSend = new List<Messaging.SingleEmailMessage>();
        List<Messaging.EmailFileAttachment> attachsToSend = new List<Messaging.EmailFileAttachment>();

        EmailTemplate template = [SELECT Id, Subject, Body, HtmlValue 
                                    FROM EmailTemplate 
                                   WHERE DeveloperName =: emailTemplate 
                                   LIMIT 1];
        
        for(Lead ld : leads) {

            mail = new Messaging.SingleEmailMessage();
            mail.setTemplateId(template.Id);
            mail.setTargetObjectId(ld.Id);

            attach = new Messaging.EmailFileAttachment();
            LEAD_WELCOME_EMAIL_TEMPLATE_PDF = String.format(LEAD_WELCOME_EMAIL_TEMPLATE_PDF, new List<String>{ld.Company, 'Bruna Girão', 'Bruna Girão'});
            attach.setFileName('Welcome ' + ld.FirstName + ' ' + ld.LastName + '.pdf');
            attach.Body = Blob.toPdf(LEAD_WELCOME_EMAIL_TEMPLATE_PDF);
            attachsToSend.add(attach);

            mail.setFileAttachments(attachsToSend);
            emailsToSend.add(mail);
        }


        if(!emailsToSend.isEmpty()) {
            Messaging.SendEmailResult[] results = Messaging.sendEmail(emailsToSend, false);
            System.debug('results => ' + results);
        }
    }
}