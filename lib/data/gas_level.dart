import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class GasData {
  final String gasLevel;
  final String gasStatus;
  GasData({
    this.gasLevel,
    this.gasStatus,
  });
}

class GasLevel extends ChangeNotifier {
  String gasLevel = '0';
  String gasStatus = '0';

  Future<GasData> getGasData() async {
    final response = await http.get(
        'https://lpg-gas-level-2969a-default-rtdb.firebaseio.com/LPG.json?');
    final gaslevel = json.decode(response.body)['load'];
    final gasstatus = json.decode(response.body)['gas'];
    final GasData gasdata = GasData(gasLevel: gaslevel, gasStatus: gasstatus);
    return gasdata;
  }

  Future<void> getGasStatus() async {
    GasData gasData = await getGasData();
    gasStatus = gasData.gasStatus;
    print(gasStatus + ' GasStatus');
    notifyListeners();
  }

  Future<void> getGasLevel() async {
    GasData gasData = await getGasData();
    gasLevel = gasData.gasLevel;
    print(gasLevel + ' GasLevel');
    notifyListeners();
  }
}
