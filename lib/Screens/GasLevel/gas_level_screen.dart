import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/GasLevel/components/body.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/data/gas_level.dart';

class GasLevelScreen extends StatelessWidget {
  static const routeName = '/gaslevel';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: purple,
        title: Text('Gas Level',
            style: TextStyle(fontFamily: 'FiraSansCondensed')),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              GasLevel gasLevel = GasLevel();
              gasLevel.getGasLevel();
            },
          )
        ],
      ),
      body: FutureBuilder<Object>(
          future: null,
          builder: (context, snapshot) {
            return Body();
          }),
      backgroundColor: kPrimaryLightColor.withOpacity(1),
    );
  }
}
