/************************************************************************************************
* Name      : EmailNotificationService
* Purpose   : Service class to send Email Notifications
* TestClass : EmailNotificationServiceTest
* Author    : Bruna Girão
* Date      : 12-07-2023
--------------------------------------------------------------------------------------------------
Date                Modified By             Description
--------------------------------------------------------------------------------------------------
12-07-2023         Bruna Girão             create class 
***************************************************************************************************/
public with sharing class EmailNotificationService {
    
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
            System.debug('ld => ' + ld.Id);
            mail = new Messaging.SingleEmailMessage();
            mail.setTemplateId(template.Id);
            mail.setToAddresses(new List<String>{ld.Email});
            mail.setSubject(template.Subject);
            mail.setHTMLBody(template.HtmlValue);
            mail.setTargetObjectId(ld.Id);

            attach = new Messaging.EmailFileAttachment();
            attach.setFileName(ld.FirstName + ' ' + ld.LastName + '.pdf');
            attach.Body = Blob.toPdf(template.HtmlValue);
            attachsToSend.add(attach);

            mail.setFileAttachments(attachsToSend);
            System.debug('mail => ' + mail.getTargetObjectId());
            emailsToSend.add(mail);
        }


        if(!emailsToSend.isEmpty()) {
            Messaging.SendEmailResult[] results = Messaging.sendEmail(emailsToSend, false);
            System.debug('results => ' + results);
        }
    }
}