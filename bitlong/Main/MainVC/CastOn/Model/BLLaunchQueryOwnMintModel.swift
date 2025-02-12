//
//  BLLaunchQueryOwnMintModel.swift
//  bitlong
//

//

import UIKit

@objcMembers class BLLaunchQueryOwnMintModel: BLBaseModel {
    var success : String?
    var error : String?
    var datas : [BLLaunchQueryOwnMintItem]?

    override static func mj_replacedKeyFromPropertyName() -> [AnyHashable : Any]{
        return ["datas": "data"]
    }
    
    override static func mj_objectClassInArray() -> [AnyHashable : Any]{
        return ["datas": BLLaunchQueryOwnMintItem.self]
    }
}

@objcMembers class BLLaunchQueryOwnMintItem: BLBaseModel {
    var ID : String?
    var CreatedAt : String?
    var UpdatedAt : String?
    var DeletedAt : String?
    var fair_launch_info_id : String?
    var minted_number : String?
    var minted_fee_rate_sat_per_kw : String?
    var minted_gas_fee : String?
    var encoded_addr : String?
    var mint_fee_paid_id : String?
    var pay_method : String?
    var paid_success_time : String?
    var user_id : String?
    var asset_name : String?
    var asset_id : String?
    var asset_type : String?
    var amount_addr : String?
    var script_key : String?
    var internal_key : String?
    var taproot_output_key : String?
    var proof_courier_addr : String?
    var minted_set_time : String?
    var send_asset_time : String?
    var is_addr_sent : String?
    var outpoint_tx_hash : String?
    var outpoint : String?
    var address : String?
    var status : String?
    var state : String?
}


