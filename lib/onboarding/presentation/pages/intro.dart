import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//My imports
import 'package:authentication_template/core/providers.dart';
import 'package:authentication_template/features/auth/model/user_field.dart';
import 'package:authentication_template/features/auth/service/user_db_service.dart';

class IntroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          //implement intro screen
          Spacer(),
          ElevatedButton(
            onPressed: () {
              _finishIntroScreen(context);
            },
            child: Text('Get Started'),
          )
        ],
      ),
    );
  }

  _finishIntroScreen(BuildContext context) async {
    await userDBS.updateData(context.read(userRepoProvider).user.id, {
      UserFields.introSeen: true,
    });
  }
}
