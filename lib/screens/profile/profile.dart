import 'package:fl_notes/blocs/authentication.dart';
import 'package:fl_notes/components/avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:package_info/package_info.dart';

class Profile extends StatelessWidget {
  const Profile({Key key}) : super(key: key);

  Future<PackageInfo> _getPackageInfo() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        buildWhen: (previous, current) =>
            previous.authenticationStatus != current.authenticationStatus,
        builder: (BuildContext context, AuthenticationState state) {
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
                                  Text(
                                    state.credentials?.name != null &&
                                            state.credentials.name.isNotEmpty
                                        ? state.credentials.name
                                        : AppLocalizations.of(context)
                                            .anonymousUser
                                            .toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black54),
                                  ),
                                  if (state.credentials?.name != null &&
                                      state.credentials.name.isNotEmpty)
                                    Text(state.credentials.email)
                                  else
                                    Container(),
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
                        TextButton(
                            onPressed: () {
                              context.read<AuthenticationBloc>().add(
                                  const AuthenticationEvent(
                                      type: AuthenticationEventType.logout));
                            },
                            child: Text(
                              AppLocalizations.of(context).signOut.toString(),
                              style: TextStyle(color: Colors.red[700]),
                            ))
                      ],
                    ),
                  ),
                  Expanded(child: Container()),
                  Flexible(
                    flex: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FutureBuilder(
                            future: _getPackageInfo(),
                            builder: (BuildContext context,
                                    AsyncSnapshot<PackageInfo> snapshot) =>
                                snapshot.hasData && !snapshot.hasError
                                    ? Text(
                                        'Build Version: ${snapshot?.data?.version}-${snapshot?.data?.buildNumber}',
                                        style: TextStyle(color: Colors.grey),
                                      )
                                    : const Text('...'))
                      ],
                    ),
                  )
                ],
              ));
        });
  }
}
