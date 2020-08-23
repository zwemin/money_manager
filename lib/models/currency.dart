class Currency{
  String info;
  String description;
  String timestamp;
  Rates rates;

  Currency({this.info,this.description,this.timestamp,this.rates});

  factory  Currency.fromJson(Map<String,dynamic> json )=> Currency(
    info: json["info"],
    description: json["description"],
    timestamp: json["timestamp"],
    rates: Rates.fromJson(json["rates"]),
  );

  Map<String,dynamic> tojson()=> {
    "info":info,
    "description":description,
    "timestamp":timestamp,
    "rates":rates.tojson(),
  };
}

class Rates{
  String USD;
  String RSD;
  String MYR;
  String CAD;
  String GBP;
  String ILS;
  String SEK;
  String NOK;
  String DKK;
  String AUD;
  String RUB;
  String KWD;
  String EUR;
  String INR;
  String BND;
  String ZAR;
  String NPR;
  String CNY;
  String CHF;
  String PKR;
  String KES;
  String THB;
  String EGP;
  String BDT;
  String SAR;
  String LAK;
  String KHR;
  String SGD;
  String IDR;
  String LKR;
  String NZD;
  String CZK;
  String JPY;
  String VND;
  String PHP;
  String KRW;
  String HKD;
  String BRL;

  Rates({
    this.USD,
    this.PHP,
    this.HKD,
    this.VND,
    this.KRW,
    this.AUD,
    this.BDT,
    this.BND,
    this.BRL,
    this.CAD,
    this.CHF,
    this.CNY,
    this.CZK,
    this.DKK,
    this.EGP,
    this.EUR,
    this.GBP,
    this.IDR,
    this.ILS,
    this.INR,
    this.JPY,
    this.KES,
    this.KHR,
    this.KWD,
    this.LAK,
    this.LKR,
    this.MYR,
    this.NOK,
    this.NPR,
    this.NZD,
    this.PKR,
    this.RSD,
    this.RUB,
    this.SAR,
    this.SEK,
    this.SGD,
    this.THB,
    this.ZAR});

  factory Rates.fromJson(Map<String,dynamic> json)=> Rates(
    USD: json["USD"],
    SAR: json["SAR"],
    RSD: json["RSD"],
    THB: json["THB"],
    BDT: json["BDT"],
    RUB: json["RUB"],
    PHP: json["PHP"],
    KRW: json["KRW"],
    BRL: json["BRL"],
    EUR: json["EUR"],
    KWD: json["KWD"],
    IDR: json["IDR"],
    CNY: json["CNY"],
    NOK: json["NOK"],
    ILS: json["ILS"],
    AUD: json["AUD"],
    PKR: json["PKR"],
    INR: json["INR"],
    EGP: json["EGP"],
    GBP: json["GBP"],
    JPY: json["JPY"],
    MYR: json["MYR"],
    KHR: json["KHR"],
    LKR: json["LKR"],
    LAK: json["LAK"],
    KES: json["KES"],
    SEK: json["SEK"],
    SGD: json["SGD"],
    NPR: json["NPR" ],
    NZD: json["NZD"],
    VND: json["VND"],
    BND: json["BND"],
    ZAR: json['ZAR'],
    CHF: json["CHF"],
    CAD: json["CAD"],
    CZK: json["CZK"],
    DKK: json["DKK"],
    HKD: json["HKD"],
  );

  Map<String,dynamic> tojson()=>{
    "USD": USD,
    "RSD": RSD,
    "MYR": MYR,
    "CAD": CAD,
    "GBP": GBP,
    "ILS": ILS,
    "SEK": SEK,
    "NOK": NOK,
    "DKK": DKK,
    "AUD": AUD,
    "RUB": RUB,
    "KWD": KWD,
    "EUR": EUR,
    "INR": INR,
    "BND": BND,
    "ZAR": ZAR,
    "NPR": NPR,
    "CNY": CNY,
    "CHF": CHF,
    "PKR": PKR,
    "KES": KES,
    "THB": THB,
    "EGP": EGP,
    "BDT": BDT,
    "SAR": SAR,
    "LAK": LAK,
    "KHR": KHR,
    "SGD": SGD,
    "IDR": IDR,
    "LKR": LKR,
    "NZD": NZD,
    "CZK": CZK,
    "JPY": JPY,
    "VND": VND,
    "PHP": PHP,
    "KRW": KRW,
    "HKD": HKD,
    "BRL": BRL,
  };


}