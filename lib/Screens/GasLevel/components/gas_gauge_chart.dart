import 'package:flutter/material.dart';
import 'package:flutter_auth/constants.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class GasGauge extends StatelessWidget {
  final double gasLevel;
  const GasGauge({
    Key key,
    @required this.gasLevel,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(size.width * 0.04),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),

      // color: kPrimaryColor.withOpacity(0.67),
      elevation: 10,
      child: Container(
        width: size.width * 0.92,
        child: SfRadialGauge(
          axes: <RadialAxis>[
            RadialAxis(
              minimum: 0,
              maximum: 5,
              canScaleToFit: true,
              ranges: <GaugeRange>[
                GaugeRange(
                  startValue: 3,
                  endValue: 5,
                  color: Colors.green,
                  startWidth: size.width * 0.05,
                  endWidth: size.width * 0.05,
                ),
                GaugeRange(
                  startValue: 1,
                  endValue: 3,
                  color: Colors.orange,
                  startWidth: size.width * 0.05,
                  endWidth: size.width * 0.05,
                ),
                GaugeRange(
                  startValue: 0,
                  endValue: 1,
                  color: Colors.red,
                  startWidth: size.width * 0.05,
                  endWidth: size.width * 0.05,
                )
              ],
              pointers: <GaugePointer>[
                NeedlePointer(
                  value: double.parse(
                    (5.0 - gasLevel).toStringAsPrecision(4),
                  ),
                ),
              ],
              annotations: <GaugeAnnotation>[
                GaugeAnnotation(
                  widget: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          (5.0 - gasLevel).toStringAsPrecision(4) + ' KG',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Orbitron',
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.analytics_rounded,
                              color: Colors.green,
                            ),
                            SizedBox(
                              width: size.width * 0.02,
                            ),
                            Text(
                              'Available',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Ubuntu',
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                      ],
                    ),
                  ),
                  angle: 90,
                  positionFactor: 0.7,
                )
              ],
            ),
          ],
          enableLoadingAnimation: true,
          // title: GaugeTitle(text: 'LPG Usage'),
        ),
      ),
    );
  }
}
