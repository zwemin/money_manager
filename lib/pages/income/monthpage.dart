import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_manager/dao/noteDao.dart';
import 'package:money_manager/entity/note.dart';
class Monthpage extends StatefulWidget {
  NoteDao dao;
  String month;
  Monthpage({this.dao,this.month});

  @override
  _MonthpageState createState() => _MonthpageState();
}

class _MonthpageState extends State<Monthpage> {

  int totalcost = 0;
  DateFormat dateFormat = new DateFormat('MMM.dd.yyyy');
  DateFormat timeFormat = new DateFormat().add_jm();
   List<Note> datalist = [ ];

   @override
  void initState() {
    // TODO: implement initState
     widget.dao.getAllNote().listen((e) {

     });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Note>>(
        stream: widget.dao.getAllNote(),
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child:ListView(
                          shrinkWrap: true,
                          children: datalist.map((e){
                            String month = DateTime.parse(e.time).month.toString();
                            if(month ==  widget.month && e.type == 'income'){
                              totalcost += (e.cost);
                              return Card(
                                color: Colors.blue,
                                elevation: 0,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 50,
                                    width: double.infinity,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text('${e.name}',style:  TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                          Text('${e.cost}',style:  TextStyle(fontSize: 16, fontWeight: FontWeight.bold))
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }
                            return Container();
                          }).toList(),
                        ) ,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          child: Center(
                              child: Text('${getMonthName()}${totalcost.toString()}',style: TextStyle(color: Colors.black,fontSize: 20),)
                          ),
                        ),
                      ),
                    ],
                  )
              ),
            );
          }
          else {
            return Container();
          }
        });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    totalcost = 0;
    super.dispose();
  }

  getMonthName() {
    String mothname;
    if(widget.month == '1' ) {
      mothname = 'January';
    }
    else if(widget.month == '2'){
      mothname = 'February';
    }
    else if(widget.month == '3'){
      mothname = 'March';
    }
    else if(widget.month == '4'){
      mothname = 'April';
    }
    else if(widget.month == '5'){
      mothname = 'May';
    }
    else if(widget.month == '6'){
      mothname = 'June';
    }
    else if(widget.month == '7'){
      mothname = 'July';
    }
    else if(widget.month == '8'){
      mothname = 'Auguest';
    }
    else if(widget.month == '9'){
      mothname = 'September';
    }
    else if(widget.month == '10'){
      mothname = 'October';
    }
    else if(widget.month == '11'){
      mothname = 'November';
    }
    else if(widget.month == '12'){
      mothname = 'December';
    }

    return mothname;

  }



}
