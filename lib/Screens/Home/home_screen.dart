import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Home/components/body.dart';
import 'package:flutter_auth/constants.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: purple,
        title: Text(
          'LPG Reader',
          style: TextStyle(
            fontFamily: 'FiraSansCondensed',
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          FlatButton(
            child: Row(
              children: [
                Text(
                  'Logout',
                  style: TextStyle(color: Colors.white70),
                ),
                Icon(
                  Icons.exit_to_app_outlined,
                  color: Colors.white70,
                ),
              ],
            ),
            onPressed: () => showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: Text('Are you sure'),
                content: Text('Do you want to logout from your account  ?'),
                actions: [
                  ButtonBar(
                    children: [
                      FlatButton(
                        child: Text('Yes'),
                        onPressed: () {
                          FirebaseAuth.instance.signOut();
                          Navigator.of(context).pop();
                        },
                      ),
                      MaterialButton(
                        child: Text('No'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Body(),
    );
  }
}
