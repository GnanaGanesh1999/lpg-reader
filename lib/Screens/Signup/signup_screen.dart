import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_auth/Screens/Home/home_screen.dart';
import 'package:flutter_auth/Screens/Signup/components/body.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/signup';
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;

  void _submitAuthForm(
    String email,
    String password,
    String username,
    BuildContext ctx,
  ) async {
    AuthResult authResult;

    try {
      setState(() {
        _isLoading = true;
      });
      // if (isLogin) {
      //   authResult = await _auth.signInWithEmailAndPassword(
      //     email: email,
      //     password: password,
      //   );
      // } else
      {
        authResult = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        await Firestore.instance
            .collection('users')
            .document(authResult.user.uid)
            .setData({
          'username': username,
          'email': email,
        });
      }
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
        builder: (context) {
          return HomeScreen();
        },
      ), (Route r) => false);
    } on PlatformException catch (err) {
      var message = 'An error occurred, pelase check your credentials!';

      if (err.message != null) {
        message = err.message;
      }

      Scaffold.of(ctx).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );
      setState(() {
        _isLoading = false;
      });
    } catch (err) {
      print(err);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(
        isLoading: _isLoading,
        submitFunction: _submitAuthForm,
      ),
    );
  }
}
