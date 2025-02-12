//
//  BLLaunchQueryIssuedModel.swift
//  bitlong
//

//

import UIKit

@objcMembers class BLLaunchQueryIssuedModel: BLBaseModel {
    var datas : [BLLaunchQueryIssuedItem]?
    
    override static func mj_replacedKeyFromPropertyName() -> [AnyHashable : Any]{
        return ["datas": "data"]
    }
    
    override static func mj_objectClassInArray() -> [AnyHashable : Any]{
        return ["datas": BLLaunchQueryIssuedItem.self]
    }
}



@objcMembers class BLLaunchQueryIssuedItem: BLBaseModel {
    var ID : String?
    var CreatedAt : String?//
    var UpdatedAt : String?//
    var DeletedAt : String?//
    var image_data : String?//
    var name : String?
    var asset_type : String?
    var amount : String?
    var reserved : String?
    var mint_quantity : String?
    var start_time : String?
    var end_time : String?
    var descriptions : String?
    var fee_rate : String?
    var set_time : String?
    var actual_reserved : String?
    var reserve_total : String?
    var mint_number : String?//mint_number
    var is_final_enough : String?
    var final_quantity : String?
    var mint_total : String?
    var actual_mint_total_percent : String?
    var calculation_expression : String?
    var batch_key : String?
    var batch_state : String?
    var batch_txid_anchor : String?
    var asset_id : String?
    var user_id : String?
    var pay_method : String?
    var paid_success_time : String?
    var issuance_fee_paid_id : String?
    var issuance_time : String?
    var reserved_could_mint : String?
    var is_reserved_sent : String?
    var minted_number : String?
    var is_mint_all : String?
    var status : String?
    var state : String?
}
