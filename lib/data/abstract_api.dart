import 'package:fl_notes/repositories/authentication.dart';
import 'package:fl_notes/repositories/notes.dart';
import 'package:flutter_config/flutter_config.dart';

abstract class API with AuthenticationProvider, NotesProvider {
  final String dbURL = FlutterConfig.get('DB_URL').toString();
  final String notesPath = 'notes';
  final String userId = 'dev_user'; // only for dev purposes
}
