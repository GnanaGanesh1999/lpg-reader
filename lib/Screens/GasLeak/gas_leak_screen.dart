import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/GasLeak/components/body.dart';
import 'package:flutter_auth/constants.dart';

class GasLeakScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: purple,
        title: Text('Leakage Details',
            style: TextStyle(fontFamily: 'FiraSansCondensed')),
      ),
      body: Body(),
      backgroundColor: kPrimaryLightColor.withOpacity(1),
    );
  }
}
