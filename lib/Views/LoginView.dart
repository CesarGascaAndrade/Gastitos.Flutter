import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text('Login screen'),
              onPressed: () {
                // Navigate to second screen when tapped!
              },
            ),
          ],
        ),
      ),
    );
  }
}