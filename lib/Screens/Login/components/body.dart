import 'package:flutter/material.dart';

import 'package:flutter_auth/Screens/Home/home_screen.dart';
import 'package:flutter_auth/Screens/Login/components/background.dart';
import 'package:flutter_auth/Screens/Signup/signup_screen.dart';

import 'package:flutter_auth/components/already_have_an_account_acheck.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/components/rounded_input_field.dart';
// import 'package:flutter_auth/components/rounded_password_field.dart';
import 'package:flutter_auth/components/text_field_container.dart';
import 'package:flutter_auth/constants.dart';

import 'package:flutter_svg/svg.dart';

class Body extends StatefulWidget {
  final bool isLoading;
  final void Function(
    String email,
    String password,
    BuildContext context,
  ) submitFunction;

  const Body({
    this.isLoading,
    this.submitFunction,
    Key key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _formKey = GlobalKey<FormState>();
  var passwordObscureText = true;
  var _password = '';
  var _email = '';

  void _tryLogin() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState.save();
      widget.submitFunction(
        _email.trim(),
        _password.trim(),
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "LOGIN",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'FiraSansCondensed'),
              ),
              SizedBox(height: size.height * 0.03),
              SvgPicture.asset(
                "assets/icons/login.svg",
                height: size.height * 0.35,
              ),
              SizedBox(height: size.height * 0.03),
              RoundedInputField(
                icon: Icons.email,
                hintText: "Enter Email ID",
                validator: (value) {
                  if (value.isEmpty || !value.contains('@')) {
                    return 'Please enter a valid email address.';
                  }
                  return null;
                },
                onSaved: (value) {
                  setState(() {
                    _email = value;
                  });
                },
              ),
              TextFieldContainer(
                child: TextFormField(
                  obscureText: passwordObscureText,
                  onSaved: (value) {
                    setState(() {
                      _password = value;
                    });
                  },
                  onChanged: (value) {
                    setState(() {
                      _password = value;
                    });
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter your password.';
                    }
                    return null;
                  },
                  cursorColor: kPrimaryColor,
                  decoration: InputDecoration(
                    hintText: 'Enter Password',
                    icon: Icon(
                      Icons.lock,
                      color: kPrimaryColor,
                    ),
                    suffixIcon: _password.length > 0
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
              // RoundedPasswordField(
              //   hintText: 'Enter Password',
              //   onSaved: (value) {},
              // ),
              !widget.isLoading
                  ? RoundedButton(
                      text: "LOGIN",
                      press: _tryLogin,

                      // () {
                      //   Navigator.pushReplacement(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) {
                      //         return HomeScreen();
                      //       },
                      //     ),
                      //   );
                      // },
                    )
                  : CircularProgressIndicator(),
              SizedBox(height: size.height * 0.03),
              AlreadyHaveAnAccountCheck(
                press: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return SignUpScreen();
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
