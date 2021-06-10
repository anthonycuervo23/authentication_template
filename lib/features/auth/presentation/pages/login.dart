import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//My imports
import 'package:authentication_template/core/providers.dart';
import 'package:authentication_template/features/auth/presentation/widgets/auth_dialog.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final GlobalKey<ScaffoldMessengerState> _key =
      GlobalKey<ScaffoldMessengerState>();
  bool _authVisible;
  int _selectedTab;

  @override
  void initState() {
    super.initState();
    _authVisible = false;
    _selectedTab = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade800,
            ),
            width: double.infinity,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: kToolbarHeight),
              Text(
                'Welcome',
                style: Theme.of(context).textTheme.headline3.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontFamily: "Frank"),
              ),
              Text(
                'Our awesome login app',
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
              const SizedBox(height: 40.0),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: ElevatedButton(
                        child: Text('Login'),
                        onPressed: () => setState(() {
                          _authVisible = true;
                          _selectedTab = 0;
                        }),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: OutlinedButton(
                        child: Text('Sign up'),
                        onPressed: () => setState(() {
                          _authVisible = true;
                          _selectedTab = 1;
                        }),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50.0),
              ElevatedButton(
                child: Text('Continue with Google'),
                onPressed: () async {
                  if (!await context.read(userRepoProvider).signInWithGoogle())
                    _key.currentState.showSnackBar(SnackBar(
                      content: Text("Something is wrong"),
                    ));
                },
              ),
              const SizedBox(height: 10.0),
            ],
          ),
          AnimatedSwitcher(
            duration: Duration(milliseconds: 500),
            child: _authVisible
                ? Container(
                    color: Colors.black54,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: AuthDialog(
                        selectedTab: _selectedTab,
                        onClose: () {
                          setState(() {
                            _authVisible = false;
                          });
                        },
                      ),
                    ),
                  )
                : null,
          )
        ],
      ),
    );
  }
}
