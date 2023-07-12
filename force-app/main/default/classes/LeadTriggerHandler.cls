/************************************************************************************************
* Name      : LeadTriggerHandler
* Purpose   : Hanbler to LeadTrigger
* TestClass : LeadTriggerTest
* Author    : Bruna Girão
* Date      : 12-07-2023
--------------------------------------------------------------------------------------------------
Date                Modified By             Description
--------------------------------------------------------------------------------------------------
12-07-2023         Bruna Girão             create class 
***************************************************************************************************/
public with sharing class LeadTriggerHandler extends TriggerHandler {

    public override void afterInsert() {
        System.debug('========== AFTER INSERT =========');
    }

    /*  
    
    *** COMMENTED AS I'LL ONLY USE THE AFTER INSERT CONTEXT ***

    public override void beforeInsert() {
        System.debug('========== BEFORE INSERT =========');
    }
    public override void beforeUpdate() {
        System.debug('========== BEFORE UPDATE =========');
    }
    public override void afterUpdate() {
        System.debug('========== AFTER UPDATE =========');
    }
    public override void beforeDelete() {
        System.debug('========== BEFORE DELETE =========');
    }
    public override void afterDelete() {
        System.debug('========== AFTER DELETE =========');
    } 

    */
}