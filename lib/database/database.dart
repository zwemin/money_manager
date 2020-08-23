import 'package:floor/floor.dart';
import 'package:money_manager/entity/note.dart';
import 'package:money_manager/dao/noteDao.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'dart:async';
part 'database.g.dart';

@Database(version: 1,entities: [Note])
abstract class AppDatabase extends FloorDatabase{
  NoteDao get noteDao;
}