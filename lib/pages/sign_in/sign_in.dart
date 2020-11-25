import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:brew_crew/widgets/brew_app_bar.dart';
import 'package:brew_crew/widgets/loading.dart';

import 'package:brew_crew/services/firebase_auth_service.dart';

class SignIn extends StatefulWidget {
  const SignIn({this.toggleGuestView});

  final Function toggleGuestView;

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _firebaseAuthService = FirebaseAuthService();
  final _signInFormKey = GlobalKey<FormState>();
  String email;
  String password;
  String error = '';
  bool loading = false;

  String _emailValidator(String value) {
    if (value.isEmpty || !value.contains('@')) {
      return 'Please, fill with some valid e-mail';
    }

    return null;
  }

  String _passwordValidator(String value) {
    if (value.isEmpty || value.length < 6) {
      return 'Please, fill a password with a 6 or more chars';
    }

    return null;
  }

  Future<void> _signInFormButtonPressed() async {
    if (_signInFormKey.currentState.validate()) {
      setState(() => loading = true);

      final cleanedEmail = email.trim();
      final cleanedPassword = password.trim();

      try {
        await _firebaseAuthService.signInWithEmailAndPassword(
          cleanedEmail,
          cleanedPassword,
        );
      } catch (e) {
        setState(() => error = e.toString());
      }

      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Loading();
    }

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Theme.of(context).primaryColor,
      appBar: BrewAppBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 80),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 60),
              child: Text(
                'Brew Crew',
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Form(
              key: _signInFormKey,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Container(
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 25,
                          offset: Offset(0, 10),
                        ),
                      ],
                    ),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: 'E-mail',
                        hintStyle: const TextStyle(fontSize: 20),
                        filled: true,
                        fillColor: Colors.brown[50],
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 20,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(26),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                      ),
                      validator: _emailValidator,
                      onChanged: (value) {
                        setState(() => email = value);
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 25,
                          offset: Offset(0, 10),
                        ),
                      ],
                    ),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        hintStyle: const TextStyle(fontSize: 20),
                        filled: true,
                        fillColor: Colors.brown[50],
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 20,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(26),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                      ),
                      validator: _passwordValidator,
                      onChanged: (value) {
                        setState(() => password = value);
                      },
                    ),
                  ),
                  const SizedBox(height: 32),
                  RaisedButton(
                    color: Colors.brown[400],
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 20,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(26),
                    ),
                    onPressed: () {
                      _signInFormButtonPressed();
                    },
                    child: const Text(
                      'Sign In',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    error,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Not registered yet?',
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontSize: 14,
                    ),
                  ),
                  TextSpan(
                    text: ' Sign up here',
                    style: TextStyle(
                      color: Colors.brown[500],
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        widget.toggleGuestView();
                      },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
