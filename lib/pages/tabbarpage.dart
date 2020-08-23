import 'package:flutter/material.dart';
import 'package:money_manager/dao/noteDao.dart';
import 'package:money_manager/localization/app_translation.dart';
import 'package:money_manager/pages/calculation/calculationpage.dart';
import 'package:money_manager/pages/income/incomepage.dart';
import 'package:money_manager/pages/income/monthlyincomepage.dart';
import 'package:money_manager/pages/outcome/monthlyoutcomepage.dart';
import 'package:money_manager/pages/outcome/outcomepage.dart';
class Tabbarpage extends StatefulWidget {
  NoteDao dao;
  Tabbarpage({this.dao});
  @override
  _TabbarpageState createState() => _TabbarpageState();
}

class _TabbarpageState extends State<Tabbarpage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 500,
        width: 500,
        child: DefaultTabController(
            length: 5,
            initialIndex: 0,
            child: Container(
              child: Scaffold(
                backgroundColor: Colors.blue,
                appBar: TabBar(
                    indicatorWeight: 2,
                    indicatorColor: Colors.black12,
                    labelPadding: const EdgeInsets.only(top: 10,left: 20,right: 20),
                    labelColor: Colors.black,
                    isScrollable: true,
                    tabs: <Widget>[
                      Container(
                          height: 90,
                          child: Text(AppTranslations.of(context).trans("outcome"),style: TextStyle(color: Colors.black,fontSize: 17),)),
                      Container(
                          height: 90,
                          child: Text('Income',style: TextStyle(color: Colors.black,fontSize: 17),)),
                      Container(
                          height: 90,
                          child: Text('Monthoutcome',style: TextStyle(color: Colors.black,fontSize: 17),)),
                      Container(
                          height: 90,
                          child: Text('Monthincome',style: TextStyle(color: Colors.black,fontSize: 17),)),
                      Container(
                          height: 90,
                          child: Text('Calculation',style: TextStyle(color: Colors.black,fontSize: 17),)),
                    ]),
                body: TabBarView(
                    children: <Widget>[
                      Tab(
                        child: Outcomepage(dao: widget.dao),
                      ),
                      Tab(
                        child: Incomepage(dao: widget.dao,),
                      ),
                      Tab(
                        child: MonthlyOutcomepage(dao: widget.dao,),
                      ),
                      Tab(
                        child: MonthlyIncomepage(dao: widget.dao,),
                      ),
                      Tab(
                        child: Calculationpage(dao: widget.dao,),
                      ),
                    ]),
              ),
            )),
      ),
    );
  }
}
