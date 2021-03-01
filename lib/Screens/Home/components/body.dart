import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/GasLeak/gas_leak_screen.dart';
import 'package:flutter_auth/Screens/GasLevel/gas_level_screen.dart';
import 'package:flutter_auth/Screens/Home/components/background.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/data/gas_level.dart';
import 'package:provider/provider.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: FutureBuilder(
          future: Provider.of<GasLevel>(context).getGasLevel(),
          builder: (context, snapshot) {
            return Container(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RoundedButton(
                  text: "Leakage Status Details",
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return GasLeakScreen();
                        },
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                RoundedButton(
                  text: "Gas Level",
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return GasLevelScreen();
                        },
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                RoundedButton(
                  text: "Gas Booking",
                  press: () {},
                ),
              ],
            ));
          }),
    );
  }
}
