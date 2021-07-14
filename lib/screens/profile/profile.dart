import 'package:fl_notes/components/avatar.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        child: Flex(
          direction: Axis.vertical,
          children: [
            Flexible(
              flex: 0,
              child: DecoratedBox(
                decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                  color: Colors.black12,
                ))),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Avatar(),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Tommaso Sebastianelli'),
                            Text('tommasosebastianelli@gmail.com'),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(onPressed: () => {}, child: Text('Disconnect'))
                ],
              ),
            ),
            Expanded(child: Container()),
            Flexible(
              flex: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Ver. 0.9.0+1',
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
