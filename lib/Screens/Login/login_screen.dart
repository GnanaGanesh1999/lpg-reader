import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_auth/Screens/Home/home_screen.dart';
import 'package:flutter_auth/Screens/Login/components/body.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  static const routeName = '/login';
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;

  void _submitAuthForm(
    String email,
    String password,
    BuildContext ctx,
  ) async {
    AuthResult authResult;

    try {
      setState(() {
        _isLoading = true;
      });
      {
        authResult = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
          builder: (context) {
            return HomeScreen();
          },
        ), (Route r) => false);

        setState(() {
          _isLoading = false;
        });
      }
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
