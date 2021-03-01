/// Horizontal bar chart example
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class HorizontalBarChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // For horizontal bar charts, set the [vertical] flag to false.
    return charts.BarChart(
      _createSampleData(),
      animate: true,
      vertical: false,
      barGroupingType: charts.BarGroupingType.stacked,
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<GasUsage, String>> _createSampleData() {
    final data = [
      new GasUsage('Used', 53),
      new GasUsage('Available', 47),
    ];

    return [
      new charts.Series<GasUsage, String>(
        id: 'gasUsage',
        domainFn: (GasUsage gasUsage, _) => gasUsage.status,
        measureFn: (GasUsage gasUsage, _) => gasUsage.size,
        data: data,
      )
    ];
  }
}

/// Sample ordinal data type.
class GasUsage {
  final String status;
  final int size;

  GasUsage(this.status, this.size);
}
