import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Welcome/welcome_screen.dart';
import 'package:flutter_auth/Screens/Home/home_screen.dart';
import 'package:flutter_auth/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_auth/data/gas_level.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => GasLevel(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Safety App',
        theme: ThemeData(
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: Colors.white,
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.onAuthStateChanged,
          builder: (ctx, userSnapshot) {
            if (userSnapshot.hasData) {
              return HomeScreen();
            }
            return WelcomeScreen();
          },
        ),
      ),
    );
  }
}
