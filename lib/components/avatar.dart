import 'package:fl_notes/blocs/authentication.dart';
import 'package:fl_notes/blocs/notes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Avatar extends StatefulWidget {
  Avatar({this.onTap}) : super();

  void Function() onTap;

  @override
  _AvatarState createState() => _AvatarState();
}

class _AvatarState extends State<Avatar> {
  bool imageError;

  @override
  void initState() {
    super.initState();
    imageError = false;
  }

  String _getInitials(String name) {
    return name.characters.first.toUpperCase() ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        buildWhen: (previous, current) =>
            previous.authenticationStatus != current.authenticationStatus,
        builder: (BuildContext context, AuthenticationState state) {
          return GestureDetector(
              onTap: widget.onTap,
              child: CircleAvatar(
                backgroundColor: Colors.black26,
                foregroundColor: Colors.white,
                backgroundImage: NetworkImage(
                  state.credentials.photoUrl,
                ),
                onBackgroundImageError: (_, __) {
                  setState(() {
                    imageError = true;
                  });
                },
                child: imageError
                    ? ((state.credentials?.name == null ||
                            state.credentials.name.isEmpty)
                        ? const Icon(Icons.person)
                        : Text(_getInitials(state.credentials.name)))
                    : null,
              ));
        });
  }
}
