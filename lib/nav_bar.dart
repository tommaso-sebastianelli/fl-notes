import 'package:fl_notes/screens/board/board.dart';
import 'package:fl_notes/screens/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key key, this.navigator}) : super(key: key);
  final NavigatorState navigator;

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (index) {
        case 0:
          widget.navigator.popAndPushNamed(Board.routeName);
          break;
        case 1:
          widget.navigator.popAndPushNamed(Profile.routeName);
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: const Icon(Icons.note_outlined),
          label: AppLocalizations.of(context).notes.toString(),
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.person_outline_sharp),
          label: AppLocalizations.of(context).profile.toString(),
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.amber[800],
      onTap: _onItemTapped,
    );
  }
}
