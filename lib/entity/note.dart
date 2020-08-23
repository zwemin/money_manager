import 'package:floor/floor.dart';

@entity
class Note{
  @PrimaryKey(autoGenerate: true)
  final int id ;
  final String name;
  final int cost;
  final String time;
  final String month;
  final String type;


  Note(this.id,this.name,this.cost,this.time,this.month,this.type);

}