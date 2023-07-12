/************************************************************************************************
* Name      : LeadTrigger
* Purpose   : Trigger to Lead Object
* TestClass : LeadTriggerTest
* Author    : Bruna Girão
* Date      : 12-07-2023
--------------------------------------------------------------------------------------------------
Date                Modified By             Description
--------------------------------------------------------------------------------------------------
12-07-2023         Bruna Girão             create trigger 
***************************************************************************************************/
trigger LeadTrigger on Lead (after insert) {
    System.debug('======= LeadTrigger ========');
    new LeadTriggerHandler().run();
}