import 'package:flutter/material.dart';
// import 'package:flutter_auth/Screens/GasLeak/components/CalendarPage.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/data/gas_level.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:timer_builder/timer_builder.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        children: <Widget>[
          DataTable(size: size),
          Expanded(
            child: Card(
              margin: EdgeInsets.fromLTRB(
                size.width * 0.018,
                size.width * 0.005,
                size.width * 0.018,
                size.width * 0.018,
              ),
              child: Container(
                margin: EdgeInsets.all(size.height * 0.01),
                height: size.height * 0.12,
                width: size.width * 0.96,
                child: Card(
                  color: kPrimaryColor.withOpacity(0.67),
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      SizedBox(
                        height: size.width * 0.03,
                      ),
                      Container(
                        // margin: EdgeInsets.only(top: size.height * 0.06),
                        child: Text(
                          'Leakage Status',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontFamily: 'FiraSansCondensed',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Container(
                        // margin: EdgeInsets.only(top: size.height * 0.03),
                        child: TimerBuilder.periodic(Duration(seconds: 1),
                            builder: (context) {
                          print("${getSystemTime()}");
                          return Text(
                            "${getSystemTime()}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 21,
                              fontFamily: 'FiraSansCondensed',
                              fontWeight: FontWeight.w400,
                            ),
                          );
                        }),
                      ),
                      Card(
                        margin: EdgeInsets.only(
                          // top: size.height * 0.03,
                          left: size.height * 0.09,
                          right: size.height * 0.09,
                        ),
                        child: Consumer<GasLevel>(
                          builder: (context, gasStatusProvider, _) {
                            gasStatusProvider.getGasStatus();
                            String gasStatus = gasStatusProvider.gasStatus;
                            return Container(
                              color:
                                  gasStatus == '0' ? Colors.green : Colors.red,
                              padding: EdgeInsets.all(size.width * 0.021),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    gasStatus == '0'
                                        ? Icons.shield
                                        : Icons.dangerous,
                                  ),
                                  // Card(
                                  //   shape: RoundedRectangleBorder(
                                  //       borderRadius: BorderRadius.circular(20)),
                                  //   elevation: 10,
                                  //   child: ClipRRect(
                                  //     borderRadius: BorderRadius.circular(20),
                                  //     child: Container(
                                  //       width: size.width * 0.09,
                                  //       height: size.width * 0.09,
                                  //       color: Colors.green,
                                  //     ),
                                  //   ),
                                  // ),
                                  SizedBox(
                                    width: size.width * 0.03,
                                  ),
                                  Text(
                                    gasStatus == '0'
                                        ? 'No Leakage'
                                        : 'Leakage Found!',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      // fontFamily: 'Ubuntu',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: size.width * 0.03,
                      ),
                    ],
                  ),
                ),
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
}

class DataTable extends StatelessWidget {
  final Size size;
  DataTable({this.size});
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(0),
      child: PaginatedDataTable(
        header: Text('Records'),
        horizontalMargin: size.width * 0.03,
        rowsPerPage: 4,
        columnSpacing: size.width * 0.057,
        showCheckboxColumn: false,
        columns: [
          DataColumn(label: Text('Date')),
          DataColumn(label: Text('Time')),
          DataColumn(label: Text('Leakage')),
          DataColumn(label: Text('On/ Off')),
        ],
        source: _DataSource(context),
      ),
    );
  }
}

class _Row {
  _Row(
    this.valueA,
    this.valueB,
    this.valueC,
    this.valueD,
  );

  final String valueA;
  final String valueB;
  final String valueC;
  final String valueD;

  bool selected = false;
}

class _DataSource extends DataTableSource {
  _DataSource(this.context) {
    _rows = <_Row>[
      _Row('12/ 02/ 2021', '10:00 AM', 'Yes', 'On'),
      _Row('17/ 02/ 2021', '12:01 PM', 'Yes', 'Off'),
      _Row('21/ 02/ 2021', '06:00 AM', 'No', 'Off'),
      _Row('25/ 02/ 2021', '01:00 PM', 'Yes', 'On'),
    ];
  }

  final BuildContext context;
  List<_Row> _rows;

  int _selectedCount = 0;

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= _rows.length) return null;
    final row = _rows[index];
    return DataRow.byIndex(
      index: index,
      selected: row.selected,
      onSelectChanged: (value) {
        if (row.selected != value) {
          _selectedCount += value ? 1 : -1;
          assert(_selectedCount >= 0);
          row.selected = value;
          notifyListeners();
        }
      },
      cells: [
        DataCell(
          Text(row.valueA),
        ),
        DataCell(Text(row.valueB)),
        DataCell(Text(row.valueC)),
        DataCell(Text(row.valueD.toString())),
      ],
    );
  }

  @override
  int get rowCount => _rows.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}
