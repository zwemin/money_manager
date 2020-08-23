import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datepicker_single/flutter_datepicker_single.dart';
import 'package:intl/intl.dart';
import 'package:money_manager/dao/noteDao.dart';
import 'package:money_manager/entity/note.dart';

class Outcomepage extends StatefulWidget {
  NoteDao dao;
  Outcomepage({this.dao});
  @override
  _OutcomepageState createState() => _OutcomepageState();
}

class _OutcomepageState extends State<Outcomepage> {
  DateTime selectedData;
  TimeOfDay timeOfDay = TimeOfDay.now();
  bool onfloatclick = false;
  TextEditingController nameController;
  TextEditingController costController;
  TextEditingController _dateController;
  DateFormat dateFormat = new DateFormat('yyyy-MM-dd');
  DateFormat timeFormat = new DateFormat().add_jm();
  final GlobalKey<AnimatedListState> _key = GlobalKey();

  FlutterDatePickerMode _mode;
  int _result;

  @override
  void initState() {
    costController = new TextEditingController();
    nameController = new TextEditingController();
    _dateController = new TextEditingController();
    // TODO: implement initState
    selectedData = DateTime.now();
    _dateController.text = dateFormat.format(DateTime.now());
    _result = 0;
    super.initState();
  }

  Future<DateTime> selectDateWithDatePicker(BuildContext context) async {
    return await showDatePicker(
      context: context,
      initialDate: selectedData,
      initialDatePickerMode: DatePickerMode.day,
      firstDate: DateTime(0),
      lastDate: DateTime(9999),
    );
  }

  _showInputDialog() {
    return AlertDialog(
      backgroundColor: Colors.blue,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))),
      contentPadding: EdgeInsets.only(left: 5, right: 5),
      content: Container(
        height: 350,
        width: 400,
        decoration:
            BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(30))),
        child: Stack(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Align(
                  child: IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  alignment: Alignment.topRight,
                ),
                InkWell(
                    onTap: () async {
                      final DateTime picked = await showDatePicker(
                        context: context,
                        initialDate: selectedData,
                        firstDate: DateTime(2015, 8),
                        lastDate: DateTime(2101),
                      );
                      if (picked != null && picked != selectedData) {
                        setState(() {
                          _dateController.clear();
                          selectedData = picked;
                          final f = new DateFormat('yyyy-MM-dd');
                          _dateController.text =
                              f.format(selectedData).toString();
                        });
                      }
                    },
                    child: AbsorbPointer(
                      child: TextField(
                        controller: _dateController,
                        decoration: new InputDecoration(
                          border: InputBorder.none,
                          hintText: 'YYYY-MM-DD',
                          hintStyle: TextStyle(color: Colors.green),
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 10, bottom: 4, top: 4, right: 10),
                        ),
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    decoration: new InputDecoration(
                        hintText: ' Enter name',
                        border: new OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black))),
                    controller: nameController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      WhitelistingTextInputFormatter.digitsOnly
                    ], // Only numbers can be entered
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    decoration: new InputDecoration(
                        hintText: ' Enter Cost',
                        border: new OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black))),
                    controller: costController,
                  ),
                ),
                Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: RaisedButton(
                          color: Colors.grey,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'ADD',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                          onPressed: () {
                            addNote();
                            Navigator.pop(context);
                          }),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }

  addNote() {
    if (nameController.text.trim().isEmpty) {
    } else {
      widget.dao.insertNote(Note(
        null,
        nameController.text,
        int.parse(costController.text),
        '${_dateController.text}',
        'outcome',
        '${DateTime.parse(_dateController.text).month.toString()}',
      ));
      nameController.clear();
      costController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: StreamBuilder<List<Note>>(
          stream: widget.dao.getAllNote(),
          initialData: null,
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              List<Note> datalist = snapshot.data;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      children: datalist.map((e) {
                        String month = DateTime.parse(e.time).month.toString();
                        if (month == e.month && e.type == 'outcome') {
                          return Dismissible(
                            direction: DismissDirection.endToStart,
                            key: Key(datalist.toString()),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Card(
                                  color: Colors.blue,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                        width: 150,
                                        height: 60,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Text(
                                                  '${e.name}',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  '${e.cost}',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Text('${e.time}'),
                                              ],
                                            ),
                                          ],
                                        )),
                                  )),
                            ),
                            onDismissed: (direction) async {
                              await widget.dao.deleteNote(e);

                              Scaffold.of(context).hideCurrentSnackBar();
                              Scaffold.of(context).showSnackBar(const SnackBar(
                                  content: Text("Delete success")));
                            },
                          );
                        } else {
                          return Container();
                        }
                      }).toList(),
                    ),
                  ),
                ],
              );
            } else {
              return CircularProgressIndicator();
            }
          }),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            showDialog(
                context: context,
                builder: (_) {
                  return Center(
                    child: _showInputDialog(),
                  );
                });
            onfloatclick = !onfloatclick;
          },
          label: Icon(Icons.add),
          backgroundColor: Colors.blue),
    );
  }

// Widget datalistiteam(Note data,Animation animation,int index){
//   return GestureDetector(
//     child: Card(
//              child: Padding(
//                padding: const EdgeInsets.all(8.0),
//                child: Container(
//                    width: 150,
//                    height: 60,
//                    child: Column(
//                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                      children: <Widget>[
//                        Row(
//                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                          children: <Widget>[
//                            Text('${data.name}',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
//                            Text('${data.cost}',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
//                          ],
//                        ),
//                        Row(
//                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                          children: <Widget>[
//                            Text('${data.time}'),
//                          ],
//                        ),
//                      ],
//                    )),
//              )
//     ),
//     onTap: (){
//       widget.dao.deleteNote(data);
//     },
//   );
//  }
}

class ShowDate extends StatefulWidget {
  @override
  _ShowDateState createState() => _ShowDateState();
}

class _ShowDateState extends State<ShowDate> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
