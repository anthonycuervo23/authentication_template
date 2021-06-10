import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//My imports
import 'package:authentication_template/core/analytics.dart';
import 'package:authentication_template/core/providers.dart';

class UserInfoPage extends StatelessWidget {
  final User user;

  const UserInfoPage({Key key, this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(user.email),
            ElevatedButton(
              child: Text('Log out'),
              onPressed: () {
                logEvent(context, AppAnalyticsEvents.logOut);
                context.read(userRepoProvider).signOut();
              },
            )
          ],
        ),
      ),
    );
  }
}
