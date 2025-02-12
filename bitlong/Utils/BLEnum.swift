//
//  BLEnum.swift
//  bitlong
//

//

import Foundation


enum LitStatus : String{
    case WAITING_TO_START = "WAITING_TO_START" 
    case NON_EXISTING = "NON_EXISTING"         
    case LOCKED = "LOCKED"                     
    case UNLOCKED = "UNLOCKED"                 
    case RPC_ACTIVE = "RPC_ACTIVE"             
    case SERVER_ACTIVE = "SERVER_ACTIVE"       
    case NO_START_LND = "NO_START_LND"         
    case UNKNOW = "UNKNOW"                     
}


enum CreatWalletCellType : NSInteger {
    case walletName = 0            
    case walletPassWorld           
    case walletPassWorldAgain      
    case walletPassWorldNoti       
}

enum GenSeedPageType : NSInteger{
    case backupsGenSeed     = 0   
    case exportGenSeed            
    case inportGenSeed            
    case verifyGenSeed            
}



enum CreatAssetsCellType : NSInteger {
    case assetsLogo = 0            
    case assetsName                
    case assetsType                
    case assetsNum                 
    case assetsReserve             
    case assetsMintNum             
    case assetsBegainDate          
    case assetsEndDate             
    case assetsLockoutTime         
    case assetsDescription         
    case assetsID                  
    case assetsHadCastOn           
    case assetsHolder              
    case assetsCopies              
    
}


enum AssetsDetailType : NSInteger {
    case BTCType = 0            //BTC
    case assetsType             
    case channelBTCType         
}


enum CategoryPageType : String {
    //TransactionDetail
    case detailMarket   = "市场"           
    case detailList     = "交易"           
    case detailPool     = "池子"           
    case detailMyOrder  = "我的挂单"        
}


enum ChartTimeType : NSInteger {
    case chartOneMin      = 0     
    case chartFiveMin             
    case chartThirtyMin           
    case chartOneHour             
    case chartFourHour            
    case chartOneDay              
    case chartOneWeek             
    case chartMore                
    case chartIndex               
}


enum AddressType : NSInteger {
    case addresNone          = 0   
    case addressBTC                //BTC
    case addressAssets             //Assets
    case addressInvoice            
}
