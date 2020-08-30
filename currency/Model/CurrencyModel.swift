//
//  File.swift
//  Currency
//
//  Created by 小牛 on 2020/08/29.
//  Copyright © 2020 小牛. All rights reserved.
//

struct CurrencyInfo: Codable {
    var quotes: CurrencyDetailModel
}

struct CurrencyDetailModel: Codable {
    var USDAED: Float
    var USDAFN: Float
    var USDALL: Float
    var USDAMD: Float
    var USDANG: Float
    var USDAOA: Float
    var USDARS: Float
    var USDAUD: Float
    var USDAWG: Float
    var USDAZN: Float
    var USDBAM: Float
    var USDBBD: Float
    var USDBDT: Float
    var USDBGN: Float
    var USDBHD: Float
    var USDBIF: Float
    var USDBMD: Float
    var USDBND: Float
    var USDBOB: Float
    var USDBRL: Float
    var USDBSD: Float
    var USDBTC: Float
    var USDBTN: Float
    var USDBWP: Float
    var USDBYN: Float
    var USDBYR: Float
    var USDBZD: Float
    var USDCAD: Float
    var USDCDF: Float
    var USDCHF: Float
    var USDCLF: Float
    var USDCLP: Float
    var USDCNY: Float
    var USDCOP: Float
    var USDCRC: Float
    var USDCUC: Float
    var USDCUP: Float
    var USDCVE: Float
    var USDCZK: Float
    var USDDJF: Float
    var USDDKK: Float
    var USDDOP: Float
    var USDDZD: Float
    var USDEGP: Float
    var USDERN: Float
    var USDETB: Float
    var USDEUR: Float
    var USDFJD: Float
    var USDFKP: Float
    var USDGBP: Float
    var USDGEL: Float
    var USDGGP: Float
    var USDGHS: Float
    var USDGIP: Float
    var USDGMD: Float
    var USDGNF: Float
    var USDGTQ: Float
    var USDGYD: Float
    var USDHKD: Float
    var USDHNL: Float
    var USDHRK: Float
    var USDHTG: Float
    var USDHUF: Float
    var USDIDR: Float
    var USDILS: Float
    var USDIMP: Float
    var USDINR: Float
    var USDIQD: Float
    var USDIRR: Float
    var USDISK: Float
    var USDJEP: Float
    var USDJMD: Float
    var USDJOD: Float
    var USDJPY: Float
    var USDKES: Float
    var USDKGS: Float
    var USDKHR: Float
    var USDKMF: Float
    var USDKPW: Float
    var USDKRW: Float
    var USDKWD: Float
    var USDKYD: Float
    var USDKZT: Float
    var USDLAK: Float
    var USDLBP: Float
    var USDLKR: Float
    var USDLRD: Float
    var USDLSL: Float
    var USDLTL: Float
    var USDLVL: Float
    var USDLYD: Float
    var USDMAD: Float
    var USDMDL: Float
    var USDMGA: Float
    var USDMKD: Float
    var USDMMK: Float
    var USDMNT: Float
    var USDMOP: Float
    var USDMRO: Float
    var USDMUR: Float
    var USDMVR: Float
    var USDMWK: Float
    var USDMXN: Float
    var USDMYR: Float
    var USDMZN: Float
    var USDNAD: Float
    var USDNGN: Float
    var USDNIO: Float
    var USDNOK: Float
    var USDNPR: Float
    var USDNZD: Float
    var USDOMR: Float
    var USDPAB: Float
    var USDPEN: Float
    var USDPGK: Float
    var USDPHP: Float
    var USDPKR: Float
    var USDPLN: Float
    var USDPYG: Float
    var USDQAR: Float
    var USDRON: Float
    var USDRSD: Float
    var USDRUB: Float
    var USDRWF: Float
    var USDSAR: Float
    var USDSBD: Float
    var USDSCR: Float
    var USDSDG: Float
    var USDSEK: Float
    var USDSGD: Float
    var USDSHP: Float
    var USDSLL: Float
    var USDSOS: Float
    var USDSRD: Float
    var USDSTD: Float
    var USDSVC: Float
    var USDSYP: Float
    var USDSZL: Float
    var USDTHB: Float
    var USDTJS: Float
    var USDTMT: Float
    var USDTND: Float
    var USDTOP: Float
    var USDTRY: Float
    var USDTTD: Float
    var USDTWD: Float
    var USDTZS: Float
    var USDUAH: Float
    var USDUGX: Float
    var USDUSD: Float
    var USDUYU: Float
    var USDUZS: Float
    var USDVEF: Float
    var USDVND: Float
    var USDVUV: Float
    var USDWST: Float
    var USDXAF: Float
    var USDXAG: Float
    var USDXAU: Float
    var USDXCD: Float
    var USDXDR: Float
    var USDXOF: Float
    var USDXPF: Float
    var USDYER: Float
    var USDZAR: Float
    var USDZMK: Float
    var USDZMW: Float
    var USDZWL: Float
    
    var asDictionary : [String:Any] {
      let mirror = Mirror(reflecting: self)
      let dict = Dictionary(uniqueKeysWithValues: mirror.children.lazy.map({ (label:String?, value:Any) -> (String, Any)? in
        guard let label = label else { return nil }
        return (label, value)
      }).compactMap { $0 })
      return dict
    }
}
