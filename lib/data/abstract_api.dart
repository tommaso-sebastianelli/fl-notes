import 'package:fl_notes/repositories/authentication.dart';
import 'package:fl_notes/repositories/notes.dart';

abstract class API with AuthenticationProvider, NotesProvider {}
