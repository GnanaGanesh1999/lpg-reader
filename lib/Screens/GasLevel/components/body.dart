import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/GasLevel/components/gas_gauge_chart.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/data/gas_level.dart';
import 'package:provider/provider.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Consumer<GasLevel>(
      builder: (_, gasLevelProvvider, child) {
        gasLevelProvvider.getGasLevel();
        var gasLevel = double.parse(
            (5 - double.parse(gasLevelProvvider.gasLevel) / 1000)
                .toStringAsPrecision(4));

        return Container(
          height: size.height,
          child: Column(
            children: <Widget>[
              Card(
                child: Container(
                  height: size.height * 0.4,
                  width: size.width * 0.96,
                  child: GasGauge(
                    size: size,
                    gasLevel: gasLevel,
                  ),
                ),
              ),
              Card(
                child: Container(
                  margin: EdgeInsets.all(size.height * 0.01),
                  height: size.height * 0.12,
                  width: size.width * 0.96,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      DisplayCard(
                          size: size,
                          title: 'GAS USED',
                          kg: gasLevel,
                          titleColor: Colors.red),
                      DisplayCard(
                          size: size,
                          title: 'REMAINING',
                          kg: double.parse(
                              (5.0 - gasLevel).toStringAsPrecision(4)),
                          titleColor: Colors.green),
                    ],
                  ),
                ),
              ),
              Card(
                child: DaysToRefill(
                  size: size,
                  gasLevel: 5 - gasLevel,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class DaysToRefill extends StatelessWidget {
  final double gasLevel;
  const DaysToRefill({
    Key key,
    @required this.gasLevel,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.31,
      width: size.width * 0.96,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(size.width * 0.05),
            width: size.width * 0.35,
            child: Image.asset(
              'assets/images/gas-clipart-lpg-6-transparent.png',
              filterQuality: FilterQuality.high,
              colorBlendMode: BlendMode.plus,
            ),
          ),
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            elevation: 10.0,
            child: Container(
              height: size.height * 0.26,
              padding: EdgeInsets.fromLTRB(size.width * 0.05, size.width * 0.05,
                  size.width * 0.05, size.width * 0.05),
              child: Column(
                children: [
                  Text(
                    (gasLevel * 3).ceil().toString(),
                    style: TextStyle(
                        fontSize: 89,
                        fontWeight: FontWeight.w600,
                        color: kPrimaryColor,
                        fontFamily: 'Ubuntu'),
                  ),
                  Text(
                    '# DAYS TO REFILL',
                    style: TextStyle(
                        fontWeight: FontWeight.w600, fontFamily: 'Ubuntu'),
                  ),
                  Text(
                    '(Estimated)',
                    style: TextStyle(fontFamily: 'Lobster', fontSize: 12.0),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DisplayCard extends StatelessWidget {
  final String title;
  final double kg;
  final Color titleColor;
  const DisplayCard({
    Key key,
    @required this.size,
    @required this.title,
    @required this.kg,
    this.titleColor,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 9,
      child: Container(
        width: size.width * 0.41,
        padding: EdgeInsets.all(size.height * 0.015),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              kg.toString() + ' KG',
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                  fontFamily: 'Lemonada'),
            ),
            SizedBox(
              height: size.height * 0.0002,
            ),
            Text(
              title,
              style: TextStyle(
                  color: titleColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  fontFamily: 'Ubuntu'),
            ),
          ],
        ),
      ),
    );
  }
}

// Positioned(
//                 bottom: size.height * 0.01,
//                 child: Card(
//                   elevation: 10,
//                   margin: EdgeInsets.all(size.width * 0.04),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                   child: Container(
//                     width: size.width * 0.92,
//                     padding: EdgeInsets.all(size.height * 0.02),
//                     child: Row(
//                       children: [
//                         Text(
//                           'USED : 8 kg',
//                           style: TextStyle(
//                             color: Colors.red,
//                             fontSize: 21,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                         SizedBox(
//                           width: size.width * 0.05,
//                         ),
//                         Text(
//                           'REMAINING : 6',
//                           style: TextStyle(
//                             color: Colors.greenAccent,
//                             fontSize: 21,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 )),
