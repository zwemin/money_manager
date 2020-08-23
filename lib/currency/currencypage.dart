import 'package:flutter/material.dart';
import 'package:money_manager/apiprovider/apicurrency.dart';
import 'package:money_manager/bloc/themebloc.dart';
import 'package:money_manager/dao/noteDao.dart';
import 'package:money_manager/localization/app_translation.dart';
import 'package:money_manager/localization/application.dart';
import 'package:money_manager/models/currency.dart';
import 'package:money_manager/sharepreference/sharepre.dart';
import 'package:provider/provider.dart';

class Currencypage extends StatefulWidget {
  NoteDao dao;
  Currencypage({this.dao});
  @override
  _CurrencypageState createState() => _CurrencypageState();
}

class _CurrencypageState extends State<Currencypage> {

  static final List<String> languagesList = application.supportedLanguages;
  static final List<String> languageCodesList =
      application.supportedLanguagesCodes;
  final Map<dynamic, dynamic> languagesMap = {
    languagesList[0]: languageCodesList[0],
    languagesList[1]: languageCodesList[1],
  };

  @override
  Widget build(BuildContext context) {
  ThemeProvider themeChanger = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          PopupMenuButton<int>(
            onSelected: (val) {
              if (val == 1) {
                PreUtil.setData(PreUtil.langauge,"en")
                    .then((b) {
                  application.onLocaleChanged(Locale(languagesMap["English"]));
                });
//                themeChanger.setThemeData = true;
                setState(() {});
              } else if (val == 2) {
                PreUtil.setData(PreUtil.langauge,"mm")
                    .then((b) {
                  application.onLocaleChanged(Locale(languagesMap["ျမန္မာ"]));
                });

//                themeChanger.setThemeData = false;
                setState(() {});
              }
            },
            icon: Icon(Icons.language),
            itemBuilder: (context) => [
              PopupMenuItem(
                  value: 1,
                  child: Row(
                    children: <Widget>[
                      IconButton(
                          icon: Icon(Icons.language,color: Colors.blue,),
                          onPressed: () async {
                            await PreUtil.setData(
                                PreUtil.langauge,  "en")
                                .then((b) {
                              application.onLocaleChanged(
                                  Locale(languagesMap["English"]));
                            });
                          }),
                      Text("English")
                    ],
                  )),
              PopupMenuItem(
                  value: 2,
                  child: Row(
                    children: <Widget>[
                      IconButton(
                          icon: Icon(Icons.language,color: Colors.blue,),
                          onPressed: () async {
                            await PreUtil.setData(
                                PreUtil.langauge,"mm")
                                .then((b) {
                              application.onLocaleChanged(
                                  Locale(languagesMap["ျမန္မာ"]));
                            });
                          }),
                      Text("ျမန္မာ")
                    ],
                  )),
            ],
          )
        ],
        title: Text(
          AppTranslations.of(context).trans('currency'),
          style: Theme.of(context).textTheme.title,
        ),
      ),
      body: FutureBuilder<Currency>(
          future: ApiProvider().currencydata(),
          builder: (BuildContext context, AsyncSnapshot<Currency> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data != null) {
                print('====>$snapshot');
                return apicurrency(snapshot.data);
              } else {
                return Container();
              }
            } else {
              return CircularProgressIndicator();
            }
          }),
    );
  }
  apicurrency(Currency currency) {
    return Stack(children: <Widget>[
      ListView(
        children: <Widget>[
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://ak5.picdn.net/shutterstock/videos/19332715/thumb/1.jpg'),
            ),
            title: Text("USD"),
            trailing: Text('${currency.rates.USD}MMK'),
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://www.tnmc.or.th/images/Flag_of_Thailand.png'),
            ),
            title: Text("THB"),
            trailing: Text('${currency.rates.THB} MMK'),
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://pluspng.com/img-png/pak-flag-png-png-pakistan-flag-icon-free-download-250.png'),
            ),
            title: Text("PKR"),
            trailing: Text('${currency.rates.PKR}MMK'),
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQYmH1T_Xb3tc2fBzyh6ZEkn0IR_XjwUq-I_BtZSXiA9osdLTPg'),
            ),
            title: Text("KES"),
            trailing: Text('${currency.rates.KES}MMK'),
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRs_F2HBHgAPYt79itcSs4vHT59GYLcZz-VLyBXUJheaLXelgPA'),
            ),
            title: Text("BDT"),
            trailing: Text('${currency.rates.BDT}MMK'),
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://previews.123rf.com/images/dvarg/dvarg1406/dvarg140600594/29069011-%EA%B4%91%ED%83%9D-%EC%95%84%EC%9D%B4%EC%BD%98-%EB%9D%BC%EC%9A%B4%EB%93%9C%EB%A1%9C-%EC%9D%B4%EC%A7%91%ED%8A%B8%EC%9D%98-%EA%B5%AD%EA%B8%B0%EC%9E%85%EB%8B%88%EB%8B%A4-%EC%9D%B4%EC%A7%91%ED%8A%B8-%ED%94%8C%EB%9E%98%EA%B7%B8-%EB%8B%A8%EC%B6%94.jpg'),
            ),
            title: Text("EGP"),
            trailing: Text('${currency.rates.EGP}MMK'),
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://images-na.ssl-images-amazon.com/images/I/41OnQRxgJvL._SX466_.jpg'),
            ),
            title: Text("SAR"),
            trailing: Text('${currency.rates.SAR}MMK'),
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSA2QSA3nEE8AzTHfYYV25tdGLqaugU45xuS5vlY3vLEN0N_39o'),
            ),
            title: Text("LAK"),
            trailing: Text('${currency.rates.LAK}MMK'),
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTiSC9FnDytlnl2eMW2FI6QoVOY09aroQSsSiw2exwJ74OTC4O1'),
            ),
            title: Text("IDR"),
            trailing: Text('${currency.rates.IDR}MMK'),
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://lh3.googleusercontent.com/proxy/Exkzi1gjtf_mK8TLGoczGLd66C-q5HeXuijbbsNeq8QFpyX3ENTL0LRIuL-1hyzqKugvn6O5_JRE2fs8QIwU0aTHV2N5RkdatQZiN4lZaOYnoCTOKJC8fnR9W4h2J2ZmDE0_NilMVQYsL8u7I7iNi-24-pwu'),
            ),
            title: Text("KHR"),
            trailing: Text('${currency.rates.KHR}MMK'),
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://cdn1.vectorstock.com/i/thumb-large/28/25/round-glossy-icon-of-singapore-vector-7602825.jpg'),
            ),
            title: Text("SGD"),
            trailing: Text('${currency.rates.SGD}MMK'),
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://lh3.googleusercontent.com/proxy/MrWFXNVnhxX64RrNyhyNB8c7xBY_p0WSdENkmWX8AaIUwbWbVuHeqXrPfqWgveTmTfnadvwF0SiWHKCfpf0S0RJErQ73hqr_YDmN-S_vulP-xj4D7n_eQ7k-8WySoqGYkJldLAGfB9BhVQNbj5oh'),
            ),
            title: Text("NZD"),
            trailing: Text('${currency.rates.NZD}MMK'),
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://xn--i-7iq.ws/emoji-image/%F0%9F%87%B1%F0%9F%87%B0.png?format=emojione&ar=1x1'),
            ),
            title: Text("LKR"),
            trailing: Text('${currency.rates.LKR}MMK'),
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcREDIhbLY3HyHCM6vAhsPnGhwYskrYJuLnH7r7KZwdWOwG5knGb'),
            ),
            title: Text("CZK"),
            trailing: Text('${currency.rates.CZK}MMK'),
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://previews.123rf.com/images/cobalt/cobalt1002/cobalt100200130/6425748-national-flag-of-japan-glossy-button.jpg'),
            ),
            title: Text("JPY"),
            trailing: Text('${currency.rates.JPY}MMK'),
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://media.istockphoto.com/vectors/vietnam-flag-round-bright-icon-on-a-white-background-vector-id1131656097?k=6&m=1131656097&s=170667a&w=0&h=_umxqO_h8QdGLTi6g6UKYV-pa_Y7fO1kLKcP10_x5zA='),
            ),
            title: Text("VND"),
            trailing: Text('${currency.rates.VND}MMK'),
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://previews.123rf.com/images/stringerphotography/stringerphotography1702/stringerphotography170200579/72234455-%E3%83%95%E3%82%A3%E3%83%AA%E3%83%94%E3%83%B3%E3%81%AE%E3%82%A4%E3%83%A9%E3%82%B9%E3%83%88%E5%85%A5%E3%82%8A%E3%81%AE%E5%9B%BD%E6%97%97.jpg'),
            ),
            title: Text("PHP"),
            trailing: Text('${currency.rates.PHP}MMK'),
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://previews.123rf.com/images/itana/itana1710/itana171000221/88693831-flag-of-south-korea-in-the-form-of-a-round-button-with-a-light-glare-and-a-shadow-the-symbol-of-inde.jpg'),
            ),
            title: Text("KRW"),
            trailing: Text('${currency.rates.KRW}MMK'),
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQDULK2-TIRGw61UKqMfK65mZ9aui4h_QV6FWI8CuQ6SY6-qYCY'),
            ),
            title: Text("HKD"),
            trailing: Text('${currency.rates.HKD}MMK'),
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://previews.123rf.com/images/aldorado10/aldorado101209/aldorado10120900022/15161214-%E7%99%BD%E3%81%A7%E9%9A%94%E9%9B%A2%E3%81%95%E3%82%8C%E3%82%8B%E3%83%96%E3%83%A9%E3%82%B8%E3%83%AB%E5%9B%BD%E6%97%97%E3%83%9C%E3%82%BF%E3%83%B3.jpg'),
            ),
            title: Text("BRL"),
            trailing: Text('${currency.rates.BRL}MMK'),
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTAwYf-6WFVmttooCxhIdLuLJ2NUNGOirvmuw8QtAbLqIZE5JS3'),
            ),
            title: Text("RSD"),
            trailing: Text('${currency.rates.RSD}MMK'),
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://cdn2.iconfinder.com/data/icons/world-flag-icons/256/Flag_of_Burma_Myanmar.png'),
            ),
            title: Text("MYR"),
            trailing: Text('${currency.rates.MYR}MMK'),
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://currency.morgrowe.com/images/flag-icons-256/cad.png'),
            ),
            title: Text("CAD"),
            trailing: Text('${currency.rates.CAD}MMK'),
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://currency.morgrowe.com/images/flag-icons-256/gbp.png'),
            ),
            title: Text("GBP"),
            trailing: Text('${currency.rates.GBP}MMK'),
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSwOSHvs4LeC2V8CDzyHBrIB6shD-V0pT3dbGD8cJyEhyiR7JGX'),
            ),
            title: Text("SEK"),
            trailing: Text('${currency.rates.SEK}MMK'),
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRgLSZTa90_TbQRAZ2OqJMbm58-zZRMOW2I_y1cmbJM6Bo3GabW'),
            ),
            title: Text("NOK"),
            trailing: Text('${currency.rates.NOK}MMK'),
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQ6FctasJ17_cLHE3cxtKIN3ykHdUwW6xIqO4YKx67xbswCv2Rt'),
            ),
            title: Text("ILS"),
            trailing: Text('${currency.rates.ILS}MMK'),
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQm_uUkOFi5XciFA-9Q-ogD5Oq9-zR639DoK-iKZY_ClJUmUvIV'),
            ),
            title: Text("DKK"),
            trailing: Text('${currency.rates.DKK}MMK'),
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQz-xzzw3MrQPofpFB584qFu4AwsUdSgCKGbH6oVVyg6c9Ex2wB'),
            ),
            title: Text("AUD"),
            trailing: Text('${currency.rates.AUD}MMK'),
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQ2KUEzZIEjFoq2M7DVEpiupFrjFmRGihvg1j87iIgl0u29Nhux'),
            ),
            title: Text("RUB"),
            trailing: Text('${currency.rates.RUB}MMK'),
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQe8qf-xQqZuO5t2mYxk2jEDlls6H7mLsT3hgNPK4AczqtQ8F3_'),
            ),
            title: Text("KWD"),
            trailing: Text('${currency.rates.KWD}MMK'),
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://currency.morgrowe.com/images/flag-icons-256/inr.png'),
            ),
            title: Text("INR"),
            trailing: Text('${currency.rates.INR}MMK'),
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSBkILCfpW0vN8STNIan6kd9gwCvy2hlSIHFXHo5rYSu1yvnaF-'),
            ),
            title: Text("BND"),
            trailing: Text('${currency.rates.BND}MMK'),
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://cdn1.vectorstock.com/i/1000x1000/68/20/round-icon-with-flag-of-the-european-union-vector-4286820.jpg'),
            ),
            title: Text("EUR"),
            trailing: Text('${currency.rates.EUR}MMK'),
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://cdn3.vectorstock.com/i/1000x1000/48/77/nepal-flag-in-glossy-round-button-of-icon-nepal-vector-22994877.jpg'),
            ),
            title: Text("NPR"),
            trailing: Text('${currency.rates.NPR}MMK'),
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://currency.morgrowe.com/images/flag-icons-256/zar.png'),
            ),
            title: Text("ZAR"),
            trailing: Text('${currency.rates.ZAR}MMK'),
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://img.favpng.com/15/2/8/flag-of-china-national-flag-png-favpng-PaSDAMkdpXfQDZWjD0aNf3paV.jpg'),
            ),
            title: Text("CNY"),
            trailing: Text('${currency.rates.CNY}MMK'),
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://currency.morgrowe.com/images/flag-icons-256/chf.png'),
            ),
            title: Text("CHF"),
            trailing: Text('${currency.rates.CHF}MMK'),
          ),
        ],
      ),
    ]);
  }
}
