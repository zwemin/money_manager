import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:money_manager/bloc/themebloc.dart';
import 'package:money_manager/dao/noteDao.dart';
import 'package:money_manager/database/database.dart';
import 'package:money_manager/localization/application.dart';
import 'package:money_manager/pages/tabbarpage.dart';
import 'package:money_manager/sharepreference/sharepre.dart';
import 'package:pattern_lock/pattern_lock.dart';
import 'package:provider/provider.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

import 'localization/app_translation_delegate.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database =
      await $FloorAppDatabase.databaseBuilder('money_manager').build();
  final dao = database.noteDao;
  runApp(ChangeNotifierProvider(
      builder: (_) => ThemeProvider(isLightTheme: true),
      child: MyApp(dao)));
}

class MyApp extends StatefulWidget {
  NoteDao dao;
  MyApp(this.dao);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AppTranslationsDelegate _newLocaleDelegate;

  @override
  void initState() {
    super.initState();
    _newLocaleDelegate = AppTranslationsDelegate(newLocale: null);
    application.onLocaleChanged = onLocaleChange;
  }

  void onLocaleChange(Locale locale) {
    setState(() {
      _newLocaleDelegate = AppTranslationsDelegate(newLocale: locale);
    });
  }


  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'Money Manager',
        theme: themeProvider.getThemeData,
        supportedLocales: [const Locale('en', 'US'), const Locale('mm', 'MM')],
        localizationsDelegates: [
          _newLocaleDelegate,
          const AppTranslationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
      home: MyHomePage(
        dao: widget.dao,
      )
    );
  }
}

class MyHomePage extends StatefulWidget {
  NoteDao dao;
  MyHomePage({this.dao});
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<int> innerdata = [];
  List<int> firstlockdata=[];


  String fld;
  getLockNumber()  async{
    String ans = await PreUtil.getData(PreUtil.lockkey);
    setState(() {
      fld = jsonEncode(firstlockdata);
      fld = ans;
      print('fld fld $fld');

    });
  }

  @override
  void initState() {
    getLockNumber();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PatternLock(
        // color of selected points.
        selectedColor: Colors.blue,
        // radius of points.
        pointRadius: 8,
        // whether show user's input and highlight selected points.
        showInput: true,
        // count of points horizontally and vertically.
        dimension: 3,
        // padding of points area relative to distance between points.
        relativePadding: 0.7,
        // needed distance from input to point to select point.
        selectThreshold: 25,
        // whether fill points.
        fillPoints: true,
        // callback that called when user's input complete. Called if user selected one or more points.
        onInputComplete: (List<int> input) async {
          innerdata = input;
          print('first lock data${fld}');
          print('---input $input}');

          if(fld == input.toString()){
            bool res =  await PreUtil.setData(PreUtil.lockkey, innerdata.toString());
            print('%%%%$res');

            res == true ? Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
              return Tabbarpage(dao: widget.dao);
            })) : Navigator.pop(context);
          }else{
            print('not success!');
          }


        },
      ),
      floatingActionButton: fld == null  || fld.isEmpty ?FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: (){
          fld = innerdata.toString();
          print('$firstlockdata');
          innerdata = [];
          print('--${fld}');
        },
      )  : null,
    );
  }
}
