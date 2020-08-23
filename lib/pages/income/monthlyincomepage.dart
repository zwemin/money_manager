import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_manager/dao/noteDao.dart';
import 'package:money_manager/entity/note.dart';
import 'package:money_manager/pages/income/monthpage.dart';

class MonthlyIncomepage extends StatefulWidget {
  NoteDao dao;
  MonthlyIncomepage({this.dao});
  @override
  _MonthlyIncomepageState createState() => _MonthlyIncomepageState();
}

class _MonthlyIncomepageState extends State<MonthlyIncomepage> {
  DateTime selectedData = DateTime.now();
  TimeOfDay timeOfDay = TimeOfDay.now();
  bool onfloatclick = false;
  TextEditingController nameController;
  TextEditingController costController;
  DateFormat dateFormat = new DateFormat('MMM.dd.yyyy');
  DateFormat timeFormat = new DateFormat().add_jm();
  @override
  void initState() {
    costController = new TextEditingController();
    nameController = new TextEditingController();
    // TODO: implement initState
    super.initState();
  }

  List<Note> jan = [];
  List<Note> feb = [];
  List<Note> mar = [];
  List<Note> apr = [];
  List<Note> may = [];
  List<Note> jun = [];
  List<Note> jul = [];
  List<Note> aug = [];
  List<Note> set = [];
  List<Note> oct = [];
  List<Note> nov = [];
  List<Note> dec = [];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 12,
      initialIndex: DateTime.now().month - 1,
      child: Scaffold(
        appBar: TabBar(labelColor: Colors.black, isScrollable: true, tabs: <Widget>[
          Text(
            'Jan',
            style: TextStyle(fontSize: 16),
          ),
          Text(
            'Feb',
            style: TextStyle(fontSize: 16),
          ),
          Text(
            'Mar',
            style: TextStyle(fontSize: 16),
          ),
          Text(
            'Apr',
            style: TextStyle(fontSize: 16),
          ),
          Text(
            'May',
            style: TextStyle(fontSize: 16),
          ),
          Text(
            'Jun',
            style: TextStyle(fontSize: 16),
          ),
          Text(
            'Jul',
            style: TextStyle(fontSize: 16),
          ),
          Text(
            'Aug',
            style: TextStyle(fontSize: 16),
          ),
          Text(
            'Sep',
            style: TextStyle(fontSize: 16),
          ),
          Text(
            'Oct',
            style: TextStyle(fontSize: 16),
          ),
          Text(
            'Nov',
            style: TextStyle(fontSize: 16),
          ),
          Text(
            'Dec',
            style: TextStyle(fontSize: 16),
          ),
        ]),
        body: StreamBuilder<List<Note>>(
            stream: widget.dao.getAllNote(),
            initialData: null,
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                List<Note> datalist = snapshot.data;
                datalist.map((e) {
                  // show type
                  String month = DateTime.parse(e.time).month.toString();
                  print('===...$month');
                  print('====> ${e.type}');
                  if (month == "1" && e.type == 'income') {
                    print('true');
                    jan.add(e);
                  } else if (month == "2") {
                    feb.add(e);
                  } else if (month == "3") {
                    mar.add(e);
                  } else if (month == "4") {
                    apr.add(e);
                  } else if (month == "5") {
                    may.add(e);
                  } else if (month == "6") {
                    jun.add(e);
                  } else if (month == "7") {
                    jul.add(e);
                  } else if (month == "8") {
                    aug.add(e);
                  } else if (month == "9") {
                    set.add(e);
                  } else if (month == "10") {
                    oct.add(e);
                  } else if (month == "11") {
                    nov.add(e);
                  } else if (month == "12") {
                    dec.add(e);
                  }
                }).toList();

                print('===jan list ${jan}');
                print('===fab list ${feb}');
              }

              return TabBarView(
                  children: <Widget>[
                Monthpage(
                  dao: widget.dao,
                  month: '1' ,
                ),
                Monthpage(
                  dao: widget.dao,
                  month: '2' ,
                ),
                Monthpage(
                  dao: widget.dao,
                  month: '3' ,
                ),
                Monthpage(
                  dao: widget.dao,
                  month: '4' ,
                ),
                Monthpage(
                  dao: widget.dao,
                  month: '5' ,
                ),
                Monthpage(
                  dao: widget.dao,
                  month: '6' ,
                ),
                Monthpage(
                  dao: widget.dao,
                  month: '7' ,
                ),
                Monthpage(
                  dao: widget.dao,
                  month: '8' ,
                ),
                Monthpage(
                  dao: widget.dao,
                  month: '9' ,
                ),
                Monthpage(
                  dao: widget.dao,
                  month: '10' ,
                ),
                Monthpage(
                  dao: widget.dao,
                  month: '11' ,
                ),
                Monthpage(
                  dao: widget.dao,
                  month: '12' ,
                ),
              ]);
            }),
      ),
    );
  }
}
