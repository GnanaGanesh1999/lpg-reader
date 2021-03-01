import 'package:flutter/material.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/data/gas_level.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:intl/intl.dart';

class CalendarPage extends StatefulWidget {
  @override
  CalendarPageState createState() => CalendarPageState();
}

class CalendarPageState extends State<CalendarPage> {
  CalendarController _calendarController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _calendarController = CalendarController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Map<CalendarFormat, String> availableCalendarFormats = const {
      CalendarFormat.month: 'Month',
      CalendarFormat.twoWeeks: '2 weeks',
      CalendarFormat.week: 'Week'
    };
    return Container(
      child: Stack(
        children: [
          Container(
            color: purple,
            child: Column(
              children: [
                TableCalendar(
                  calendarController: _calendarController,
                  initialCalendarFormat: CalendarFormat.week,
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  formatAnimation: FormatAnimation.slide,
                  availableCalendarFormats: availableCalendarFormats,
                  headerStyle: HeaderStyle(
                    centerHeaderTitle: true,
                    formatButtonVisible: false,
                    titleTextStyle:
                        TextStyle(color: Colors.white, fontSize: 16),
                    leftChevronIcon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                      size: 15,
                    ),
                    rightChevronIcon: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                      size: 15,
                    ),
                    leftChevronMargin: EdgeInsets.only(left: 70),
                    rightChevronMargin: EdgeInsets.only(right: 70),
                  ),
                  calendarStyle: CalendarStyle(
                      weekendStyle: TextStyle(color: Colors.white),
                      weekdayStyle: TextStyle(color: Colors.white)),
                  daysOfWeekStyle: DaysOfWeekStyle(
                      weekendStyle: TextStyle(color: Colors.white),
                      weekdayStyle: TextStyle(color: Colors.white)),
                ),
                SizedBox(
                  height: 5,
                ),
                Expanded(
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    child: Container(
                      padding: EdgeInsets.all(20),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "18 April 2020",
                                  style: TextStyle(
                                      color: Colors.grey, fontFamily: 'Ubuntu'),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Column(
                              children: [
                                dayTask("10 am", "Michael Hamilton"),
                                dayTask("11 am", "Alexandra Johnson"),
                                dayTask("2 pm", "Michael Hamilton"),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Positioned(
            bottom: size.height * 0.01,
            left: size.width * 0.01,
            child: Card(
              elevation: 10,
              child: Container(
                color: purple,
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                width: size.width * 0.96,
                height: size.height * 0.06,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Leakage Status ',
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Ubuntu',
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      Container(
                        child: TimerBuilder.periodic(Duration(seconds: 1),
                            builder: (context) {
                          print("${getSystemTime()}");
                          return Text(
                            "${getSystemTime()}",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 18,
                              fontFamily: 'FiraSansCondensed',
                              fontWeight: FontWeight.w400,
                            ),
                          );
                        }),
                      ),
                      Consumer<GasLevel>(
                          builder: (context, gasStatusProvider, _) {
                        gasStatusProvider.getGasStatus();
                        String gasStatus = gasStatusProvider.gasStatus;
                        print(gasStatus);
                        return Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          elevation: 10,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              width: size.width * 0.09,
                              height: size.width * 0.09,
                              color:
                                  gasStatus == '0' ? Colors.green : Colors.red,
                            ),
                          ),
                        );
                      }),
                    ]),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String getSystemTime() {
    var now = new DateTime.now();
    return new DateFormat("HH:mm:ss").format(now);
  }

  Row dayTask(String time, String name) {
    final Size size = MediaQuery.of(context).size;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(size.width * 0.05),
          width: size.width * 0.23,
          child: Text(
            time,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.right,
          ),
        ),
        Expanded(
          child: Card(
            elevation: 6,
            margin: EdgeInsets.only(bottom: 20, right: 20),
            child: Container(
              padding: EdgeInsets.all(20),
              color: purple,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Leackage Found!',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // Text(
                  //   'Slight',
                  //   style: TextStyle(
                  //       color: Colors.grey, fontWeight: FontWeight.w500),
                  // ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "for 2 min",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.timer,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  // Row(
                  //   children: [
                  // Text(
                  //   "Risk",
                  //   style: TextStyle(
                  //       color: purple, fontWeight: FontWeight.w500),
                  // ),
                  //     SizedBox(
                  //       width: 5,
                  //     ),
                  //     Icon(Icons.star),
                  //     Icon(Icons.star),
                  //     Icon(Icons.star),
                  //   ],
                  // ),
                  // SizedBox(
                  //   height: 5,
                  // ),
                  // Container(
                  //   height: 0.5,
                  //   color: Colors.grey,
                  // ),
                  // SizedBox(
                  //   height: 15,
                  // ),
                  // Row(
                  //   children: [
                  //     Text(
                  //       "Risk",
                  //       style: TextStyle(
                  //           color: Colors.white, fontWeight: FontWeight.w500),
                  //     ),
                  //     Expanded(
                  //       child: Container(),
                  //     ),
                  //     Icon(Icons.star),
                  //     Icon(Icons.star),
                  //     Icon(Icons.star),
                  //   ],
                  // )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
