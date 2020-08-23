import 'package:floor/floor.dart';
import 'package:money_manager/entity/note.dart';


@dao
abstract class NoteDao {

  @Query('SELECT * FROM Note')
  Stream<List<Note>> getAllNote();

  @insert
  Future<void> insertNote(Note note);

  @delete
  Future<void> deleteNote(Note note);

  @update
  Future<void> updateNote(Note note);

  @Query('SELECT * FROM Note WHERE month = :month')
  Stream<List<Note>> getEachMonthData(String month);






}