import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Login/login_screen.dart';
import 'package:flutter_auth/Screens/Signup/components/background.dart';
import 'package:flutter_auth/components/already_have_an_account_acheck.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/components/rounded_input_field.dart';
import 'package:flutter_auth/components/text_field_container.dart';
// import 'package:flutter_auth/components/rounded_password_field.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_svg/svg.dart';

class Body extends StatefulWidget {
  final bool isLoading;
  final void Function(
    String email,
    String password,
    String userName,
    BuildContext context,
  ) submitFunction;

  Body({
    this.isLoading,
    this.submitFunction,
  });

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _formKey = GlobalKey<FormState>();
  var _userEmail = '';
  var _userName = '';
  var _userPassword = '';
  var _repassword = '';
  var passwordObscureText = true;
  var re_passwordObscureText = true;

  Widget _showSnackBar<Snackbar>(String message) {
    return SnackBar(
      content: Text(message),
      backgroundColor: Theme.of(context).errorColor,
    );
  }

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (_repassword.trim() != _userPassword.trim()) {
      Scaffold.of(context).hideCurrentSnackBar();
      Scaffold.of(context).removeCurrentSnackBar();
      Scaffold.of(context).showSnackBar(
        _showSnackBar(
          'Your Password doesn\'t match',
        ),
      );
      return;
    }

    if (isValid) {
      _formKey.currentState.save();
      widget.submitFunction(
        _userEmail.trim(),
        _userPassword.trim(),
        _userName.trim(),
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Background(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "SIGNUP",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'FiraSansCondensed'),
                ),
                SizedBox(height: size.height * 0.025),
                SvgPicture.asset(
                  "assets/icons/signup.svg",
                  height: size.height * 0.3,
                ),
                RoundedInputField(
                  hintText: "Enter Username",
                  onSaved: (value) {
                    _userName = value;
                  },
                  validator: (value) {
                    if (value.isEmpty || value.length < 8) {
                      return 'Please enter a valid username.';
                    }
                    return null;
                  },
                ),
                RoundedInputField(
                  icon: Icons.email,
                  hintText: "Enter Email ID",
                  onSaved: (value) {
                    _userEmail = value;
                  },
                  validator: (value) {
                    if (value.isEmpty || !value.contains('@')) {
                      return 'Please enter a valid email address.';
                    }
                    return null;
                  },
                ),
                TextFieldContainer(
                  child: TextFormField(
                    obscureText: passwordObscureText,
                    onSaved: (value) {
                      setState(() {
                        _userPassword = value;
                      });
                    },
                    onChanged: (value) {
                      setState(() {
                        _userPassword = value;
                      });
                    },
                    cursorColor: kPrimaryColor,
                    decoration: InputDecoration(
                      hintText: 'Enter Password',
                      icon: Icon(
                        Icons.lock,
                        color: kPrimaryColor,
                      ),
                      suffixIcon: _userPassword.length > 0
                          ? IconButton(
                              icon: Icon(
                                Icons.visibility,
                                color: kPrimaryColor,
                              ),
                              onPressed: () {
                                setState(() {
                                  passwordObscureText = !passwordObscureText;
                                });
                              },
                            )
                          : null,
                      border: InputBorder.none,
                    ),
                  ),
                ),
                TextFieldContainer(
                  child: TextFormField(
                    obscureText: re_passwordObscureText,
                    onSaved: (value) {
                      setState(() {
                        _repassword = value;
                      });
                    },
                    onChanged: (value) {
                      setState(() {
                        _repassword = value;
                      });
                    },
                    cursorColor: kPrimaryColor,
                    decoration: InputDecoration(
                      hintText: 'Re- Enter Password',
                      icon: Icon(
                        Icons.lock,
                        color: kPrimaryColor,
                      ),
                      suffixIcon: _repassword.length > 0
                          ? IconButton(
                              icon: Icon(
                                Icons.visibility,
                                color: kPrimaryColor,
                              ),
                              onPressed: () {
                                setState(() {
                                  re_passwordObscureText =
                                      !re_passwordObscureText;
                                });
                              },
                            )
                          : null,
                      border: InputBorder.none,
                    ),
                  ),
                ),
                // RoundedPasswordField(
                //   hintText: 'Re-Enter Password',
                //   onSaved: (value) {
                //     _repassword = value;
                //   },
                // ),
                widget.isLoading
                    ? CircularProgressIndicator()
                    : RoundedButton(
                        text: "SIGNUP",
                        press: _trySubmit,
                      ),
                SizedBox(height: size.height * 0.025),
                AlreadyHaveAnAccountCheck(
                  login: false,
                  press: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return LoginScreen();
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
