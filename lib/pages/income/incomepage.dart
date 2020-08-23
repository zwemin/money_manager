import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:money_manager/dao/noteDao.dart';
import 'package:money_manager/entity/note.dart';
class Incomepage extends StatefulWidget {
  NoteDao dao;
  Incomepage({this.dao});
  @override
  _IncomepageState createState() => _IncomepageState();
}

class _IncomepageState extends State<Incomepage> {
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
                Align(
                  alignment: Alignment.topLeft,
                  child: FlatButton(
                      child: Text(
                        '${dateFormat.format(DateTime.now())}',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      )),
                ),
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
    if (nameController.text.trim().isEmpty)
    {
     return Container();
    }
    else {
      widget.dao.insertNote(Note(
        null,
        nameController.text,
        int.parse(costController.text),
        '${DateTime.now()}',
        'income',
        '${DateTime.now().month.toString()}',
      ));
      nameController.clear();
      costController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<Note>>(
          stream: widget.dao.getAllNote(),
          initialData: null,
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              List<Note>    datalist = snapshot.data;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      children: datalist.map((e){
                        String month = DateTime.parse(e.time).month.toString();
                        if(month ==  e.month && e.type == 'income'){
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
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                Text('${e.name}',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                                                Text('${e.cost}',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                Text('${e.time}'),
                                              ],
                                            ),
                                          ],
                                        )),
                                  )),
                            ),
                            onDismissed: (direction) async{
                              await widget.dao.deleteNote(e);

                              Scaffold.of(context).hideCurrentSnackBar();
                              Scaffold.of(context).showSnackBar(
                                  const SnackBar(content: Text("Delete success")));
                            },
                          );
                        }else {
                          return Container();
                        }
                      }).toList(),
                    ) ,



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
}
