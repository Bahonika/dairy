import 'package:dairy/entities/abstract/basic.dart';
import 'package:dairy/entities/get_enitites/note.dart';

class NoteRepository extends BasicRepository<Note> {
  @override
  final String apiEndpoint = "api/note";

  @override
  Note fromJson(json) {
    return Note.fromJson(json);
  }
}
