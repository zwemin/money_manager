import 'package:flutter/material.dart';
import 'package:money_manager/bloc/themebloc.dart';
import 'package:money_manager/currency/currencypage.dart';
import 'package:money_manager/dao/noteDao.dart';
import 'package:money_manager/entity/note.dart';
import 'package:money_manager/localization/app_translation_delegate.dart';
import 'package:money_manager/localization/application.dart';
import 'package:money_manager/sharepreference/sharepre.dart';
import 'package:provider/provider.dart';
class Calculationpage extends StatefulWidget {
  NoteDao dao;
  Calculationpage({this.dao});
  @override
  _CalculationpageState createState() => _CalculationpageState();
}

class _CalculationpageState extends State<Calculationpage> {
  int totalincome = 0;
  int totaloutcome = 0;


  List<String> listmonth = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    'July',
    "Auguest",
    'September',
    'October',
    'November',
    'December',
  ];

  String selectedMonth;
  String monthname;


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
    return  Scaffold(
        body: StreamBuilder<List<Note>>(
            stream: widget.dao.getAllNote(),
            initialData: null,
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                List<Note> datalist = snapshot.data;

                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 400,
                      width: 300,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(90),topRight: Radius.circular(50) ,topLeft: Radius.circular(50) ,bottomRight: Radius.circular(50) )
                      ),
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 40,right: 30),
                              child: DropdownButton<String>(
                                hint:  Text("Select Month"),
                                value: selectedMonth,
                                onChanged: (String Value) {
                                  setState(() {
                                    selectedMonth = Value;
                                    totalincome = 0;
                                    totaloutcome = 0;
                                  });
                                  datalist.map((e){
                                    if(DateTime.parse(e.time).month == 1){
                                      setState(() {
                                        monthname = 'January';
                                      });
                                    }
                                    else if(DateTime.parse(e.time).month == 2){
                                      setState(() {
                                        monthname = 'February';
                                      });
                                    }
                                    else if(DateTime.parse(e.time).month == 3){
                                      setState(() {
                                        monthname = 'March';
                                      });
                                    }
                                    else if(DateTime.parse(e.time).month == 4){
                                      setState(() {
                                        monthname = 'April';
                                      });
                                    }
                                    else if(DateTime.parse(e.time).month == 5){
                                      setState(() {
                                        monthname = 'May';
                                      });
                                    }
                                    else if(DateTime.parse(e.time).month == 6){
                                      setState(() {
                                        monthname = 'June';
                                      });
                                    }
                                    else if(DateTime.parse(e.time).month == 7){
                                      setState(() {
                                        monthname = 'July';
                                      });
                                    }
                                    else if(DateTime.parse(e.time).month == 8){
                                      setState(() {
                                        monthname = "Auguest";
                                      });
                                    }
                                    else if(DateTime.parse(e.time).month == 9){
                                      setState(() {
                                        monthname = 'September';
                                      });
                                    }
                                    else if(DateTime.parse(e.time).month == 10){
                                      setState(() {
                                        monthname = 'October';
                                      });
                                    }
                                    else if(DateTime.parse(e.time).month == 11){
                                      setState(() {
                                        monthname = 'November';
                                      });
                                    }
                                    else if(DateTime.parse(e.time).month == 12){
                                      setState(() {
                                        monthname = 'December';
                                      });
                                    }

                                    if(monthname == selectedMonth){

                                      if(e.type == "income"){
                                        totalincome += (e.cost);
                                      }
                                      if(e.type == "outcome"){
                                        totaloutcome += (e.cost);
                                      }
                                    }
                                  }).toList();
                                  print('totalincome  $totalincome');
                                  print('totaloutcome $totaloutcome');

                                },
                                items: listmonth.map((String month) {
                                  return  DropdownMenuItem<String>(
                                    value: month,
                                    child:
                                    Text(
                                      month,
                                      style:  TextStyle(color: Colors.black),
                                    ),

                                  );
                                }).toList(),
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('Total Income ',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('${totalincome.toString()}',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                                ),

                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('Total Outcome ',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(' ${totaloutcome.toString()}',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                                ),

                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('Your Balance',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('${totalincome - totaloutcome}',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                                ),

                              ],
                            ),
                          )

                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return CircularProgressIndicator();
              }
            }),

//      bottomNavigationBar: BottomAppBar(
//          elevation: 0,
//          child: Padding(
//            padding: const EdgeInsets.only(left: 300,bottom: 20),
//            child: Container(
//              decoration: BoxDecoration(
//                color: Colors.blue,
//                borderRadius: BorderRadius.only(topLeft: Radius.circular(30),bottomLeft: Radius.circular(30))
//              ),
//              height: 70,
//              child: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                children: <Widget>[
//                  CircleAvatar(
//                    backgroundColor: Colors.green,
//                    radius: 30,
//                    child: IconButton(
//                        icon: Icon(Icons.attach_money),
//                        onPressed: (){
//                        Navigator.push(context, MaterialPageRoute(builder: (context) {
//                            return Currencypage(dao: widget.dao);
//                          }));
//                    }),
//                  ),
//                ],
//              ),
//            ),
//          )
//      ),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Currencypage(dao: widget.dao);
              }));
            },
            label: Icon(Icons.monetization_on),
            backgroundColor: Colors.blue
        ),
      );

  }
}
