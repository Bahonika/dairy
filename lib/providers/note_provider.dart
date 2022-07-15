import 'package:flutter/material.dart';
import 'package:dairy/entities/get_enitites/note.dart';
import 'package:dairy/entities/get_enitites/user.dart';
import 'package:dairy/entities/get_repositories/note_repository.dart';
import 'package:dairy/entities/post_entities/note_post.dart';
import 'package:dairy/entities/post_repositories/note_post_repository.dart';

class NoteProvider with ChangeNotifier {
  List<Note> _notes = <Note>[];
  List<Note> get notes => _notes;

  NoteRepository noteRepository = NoteRepository();
  NotePostRepository notePostRepository = NotePostRepository();

  deleteNote(String id, User user) {
    notePostRepository
        .delete(id, user as AuthorizedUser)
        .then((value) => getData(user));
  }

  updateNote(NotePost notePost, int noteId, User user) {
    notePostRepository
        .update(notePost, noteId.toString(), user as AuthorizedUser)
        .then((value) => getData(user));
  }

  create(NotePost notePost, User user) {
    notePostRepository
        .create(notePost, user as AuthorizedUser)
        .then((value) => getData(user));
  }

  Future<void> getData(User user) async {
    _notes = await noteRepository.getAll(user: user as AuthorizedUser);
    notifyListeners();
  }
}
