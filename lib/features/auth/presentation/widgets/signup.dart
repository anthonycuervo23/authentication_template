import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//My imports
import 'package:authentication_template/core/providers.dart';
import 'package:authentication_template/features/auth/model/user_repository.dart';

class SignupForm extends StatefulWidget {
  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  TextStyle style = TextStyle(fontSize: 20.0);
  TextEditingController _email;
  TextEditingController _password;
  TextEditingController _confirmPassword;
  FocusNode _passwordField;
  FocusNode _confirmPasswordField;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _email = TextEditingController(text: "");
    _password = TextEditingController(text: "");
    _confirmPassword = TextEditingController(text: "");
    _passwordField = FocusNode();
    _confirmPasswordField = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, _) {
        final user = watch(userRepoProvider);
        return Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(0),
                child: TextFormField(
                  key: Key("email-field"),
                  controller: _email,
                  validator: (value) =>
                      (value.isEmpty) ? 'Please enter a valid email' : null,
                  decoration: InputDecoration(
                    labelText: 'Email',
                  ),
                  style: style,
                  textInputAction: TextInputAction.next,
                  onEditingComplete: () {
                    FocusScope.of(context).requestFocus(_passwordField);
                  },
                ),
              ),
              const SizedBox(height: 10.0),
              Container(
                padding: const EdgeInsets.all(0),
                child: TextFormField(
                  focusNode: _passwordField,
                  key: Key("password-field"),
                  controller: _password,
                  obscureText: true,
                  validator: (value) =>
                      (value.isEmpty) ? 'Please enter password' : null,
                  decoration: InputDecoration(
                    labelText: 'Password',
                  ),
                  style: style,
                  textInputAction: TextInputAction.next,
                  onEditingComplete: () {
                    FocusScope.of(context).requestFocus(_confirmPasswordField);
                  },
                ),
              ),
              const SizedBox(height: 10.0),
              Container(
                padding: const EdgeInsets.all(0),
                child: TextFormField(
                  key: Key("confirm-password-field"),
                  controller: _confirmPassword,
                  obscureText: true,
                  validator: (value) => (value.isEmpty)
                      ? 'Please confirm password'
                      : value.isNotEmpty &&
                              _password.text != _confirmPassword.text
                          ? 'Passwords do not match'
                          : null,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                  ),
                  style: style,
                  focusNode: _confirmPasswordField,
                  onEditingComplete: () => _signup(),
                ),
              ),
              SizedBox(height: 10.0),
              if (user.status == Status.Authenticating)
                Center(child: CircularProgressIndicator()),
              if (user.status != Status.Authenticating)
                Center(
                  child: ElevatedButton(
                    onPressed: _signup,
                    child: Text('Sign up'),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  _signup() async {
    if (_formKey.currentState.validate()) {
      //signup user
      if (!await context
          .read(userRepoProvider)
          .signup(_email.text, _password.text))
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(context.read(userRepoProvider).error),
        ));
    }
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }
}
