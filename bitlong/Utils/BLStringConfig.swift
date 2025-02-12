//
//  BLStringConfig.swift
//  bitlong
//

//
 
import Foundation

/*
 key
 */

let APISECCUSS  = "SECCUSS"


let GenSeed = "GenSeed"

let WalletInfo         = "WalletInfo"
let WalletName         = "WalletName"
let PalletPassWorld    = "WalletPassWorld"
let PassWorldNotice    = "WassWorldNotice"
let WalletBalance      = "WalletBalance"
let TotalBalance       = "TotalBalance" 
let ConfirmedBalance   = "ConfirmedBalance" 
let UnconfirmedBalance = "UnconfirmedBalance" 
let LockedBalance      = "LockedBalance" 


let WalletAddress   = "WalletAddress"

let AssetsInfo      = "AssetsInfo"
let AssetsName      = "AssetsName"
let AssetsNum       = "AssetsNum"

let AssetsInvoiceCreatTime   = "AssetsInvoiceCreatTime"

//token
let Token  = "Token"

/*
 test
 */

let genSeedTitle               = "备份助记词"
let genSeedSubTitle            = "请按顺序抄写助记词，确保备份正确。"
let genSeedWarnTitle           = "妥善保管助记词至隔离网络的安全地方。"
let genSeedWarnSubTitle        = "请勿将助记词在联网环境下分享和存储，比如邮件、相册、社交应用等。"

let manualBackupTitle = "手动备份"
let cloudBackupTitle = "云备份"
let laterBackupTitle = "稍后备份"


/*
 file path
 */
let Key_Assets           = "key_Assets"

let Key_AssetsIcon       = "assetsIcon.plist"


/*
 error type
 */
//proof file
let Error_ProofPre       = "unable to make proof file path: proof file "
let Error_ProofLast      = " does not exist: unable to find proof"




let PhoneNumRegex        = "^1\\d{10}$"

let EmailRegex           = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"

let IDCardRegex        = "^(\\d{14}|\\d{17})(\\d|[xX])$"

let IPRegex              = "^(1\\d{2}|2[0-4]\\d|25[0-5]|[1-9]\\d|[1-9])(\\.(1\\d{2}|2[0-4]\\d|25[0-5]|[1-9]\\d|\\d)){3}$"

let PasswardRegex        = "^[a-zA-Z0-9]{8,12}$"

let NumRegex             = "^[0-9](\\.[0-9]{1,2}){0,1}$"
