import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
	final Function toggleView;

	SignIn({ this.toggleView });

	@override
	_SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
	final AuthService _authService = AuthService();
	String _email;
	String _password;

	void _whenToggleViewIsPressed() => widget.toggleView();

	void _whenFormButtonIsPressed() async {

	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: Colors.brown[100],
			appBar: AppBar(
				backgroundColor: Colors.brown[300],
				elevation: 0.0,
				title: Text('Sign in'),
				actions: <Widget>[
					FlatButton.icon(
						icon: Icon(Icons.person, color: Colors.white),
						label: Text('Sign up', style: TextStyle(color: Colors.white)),
						onPressed: _whenToggleViewIsPressed,
					)
				],
			),
			body: Container(
				padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
				child: Form(
					child: Column(
						children: <Widget>[
							SizedBox(height: 20),
							TextFormField(
								onChanged: (String value) => setState(() => _email = value),
							),
							SizedBox(height: 20),
							TextFormField(
								obscureText: true,
								onChanged: (String value) => setState(() => _password = value),
							),
							SizedBox(height: 20),
							RaisedButton(
								color: Colors.brown[600],
								child: Text(
									'Sign in',
									style: TextStyle(color: Colors.white)
								),
								onPressed: _whenFormButtonIsPressed,
							)
						],
					),
				),
			),
		);
	}
}
