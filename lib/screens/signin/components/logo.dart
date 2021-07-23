import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Logo extends StatelessWidget {
  const Logo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(100, 0, 100, 150),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 0,
                child: Padding(
                  padding: EdgeInsets.all(0),
                  child: Image.asset(
                    'assets/images/icon_flat.png',
                    cacheHeight: 75,
                    cacheWidth: 75,
                  ),
                ),
              ),
              Flex(
                direction: Axis.vertical,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                      flex: 0,
                      child: Text(
                        FlutterConfig.get('LABEL')
                            .toString()
                            .split(' ')
                            .elementAt(0),
                        style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w600,
                            fontFamily: GoogleFonts.karla().fontFamily,
                            color: Colors.black87),
                      )),
                  Flexible(
                      flex: 0,
                      child: Text(
                        FlutterConfig.get('LABEL')
                            .toString()
                            .split(' ')
                            .elementAt(1),
                        style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w600,
                            fontFamily: GoogleFonts.karla().fontFamily,
                            color: Colors.black87),
                      )),
                ],
              ),
            ],
          ),
          // Icon(Icons.login),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
            child: Text(AppLocalizations.of(context).signInAppDesc,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.black54,
                    fontFamily: GoogleFonts.karla().fontFamily)),
          ),
        ],
      ),
    );
  }
}
