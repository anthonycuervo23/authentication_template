import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//My imports
import 'package:authentication_template/core/analytics.dart';
import 'package:authentication_template/core/providers.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Authentication Template'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await logEvent(context, AppAnalyticsEvents.logOut);
              await context.read(userRepoProvider).signOut();
              Navigator.pop(context);
            },
          )
        ],
      ),
      body: Center(
        child: Text('HELLO WORLD'),
      ),
    );
  }
}
