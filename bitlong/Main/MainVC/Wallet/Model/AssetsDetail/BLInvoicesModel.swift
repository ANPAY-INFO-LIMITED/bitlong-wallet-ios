//
//  BLInvoicesModel.swift
//  bitlong
//

//

import UIKit

@objcMembers class BLInvoicesModel: BLBaseModel {
    var invoices : [BLInvoicesHisItem]?
    
    override static func mj_objectClassInArray() -> [AnyHashable : Any]{
        return ["invoices": BLInvoicesHisItem.self]
    }
}

@objcMembers class BLInvoicesHisItem: BLBaseModel {
    var invoice : String?      
    var asset_id : String?
    var amount : String?
    var status : String?
}


@objcMembers class BLInvoicesPaymentModel: BLBaseModel {
    var payments : [BLInvoicesPaymentItem]?
    var paymentsIn : NSMutableArray?
    var paymentsOut : NSMutableArray?
    
    override static func mj_objectClassInArray() -> [AnyHashable : Any]{
        return ["payments": BLInvoicesPaymentItem.self]
    }
}

@objcMembers class BLInvoicesPaymentItem: BLBaseModel {
    var timestamp : String?
    var bill_type : String?   
    var away : String?        
    var invoice : String?     
    var amount : String?      
    var asset_id : String?    
    var state : String?       
}
