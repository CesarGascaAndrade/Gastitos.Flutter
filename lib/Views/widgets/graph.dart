import 'dart:math';

/// Example of timeseries chart with gridlines that have a dash pattern.
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

/// Example of a combo time series chart with two series rendered as lines, and
/// a third rendered as points along the top line with a different color.
///
/// This example demonstrates a method for drawing points along a line using a
/// different color from the main series color. The line renderer supports
/// drawing points with the "includePoints" option, but those points will share
/// the same color as the line.

class DateTimeComboLinePointChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  DateTimeComboLinePointChart(this.seriesList, {this.animate});

  /// Creates a [TimeSeriesChart] with sample data and no transition.
  factory DateTimeComboLinePointChart.withSampleData() {
    return new DateTimeComboLinePointChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  static List<charts.Series<TimeSeriesSales, DateTime>> _fromList(
      List<Map<String, dynamic>> movimientos) {
    final List<TimeSeriesSales> data = [];
    if (movimientos != null) {
      movimientos.forEach((movimiento) {
        if (movimiento['importe'] != null) {
          double importe = movimiento['importe'];
          data.add(new TimeSeriesSales(
              DateTime.parse(movimiento['fechaRegistro']), importe.round()));
        }
      });
    }

    return [
      new charts.Series<TimeSeriesSales, DateTime>(
        id: 'Cost',
        domainFn: (TimeSeriesSales row, _) => row.time,
        measureFn: (TimeSeriesSales row, _) => row.sales,
        data: data,
      )
    ];
  }

  factory DateTimeComboLinePointChart.withListData(
      List<Map<String, dynamic>> data) {
    return new DateTimeComboLinePointChart(_fromList(data), animate: true);
  }

  @override
  Widget build(BuildContext context) {
    return new charts.TimeSeriesChart(
      seriesList,
      animate: animate,
      // Configure the default renderer as a line renderer. This will be used
      // for any series that does not define a rendererIdKey.
      //
      // This is the default configuration, but is shown here for  illustration.
      defaultRenderer: new charts.LineRendererConfig(),
      // Optionally pass in a [DateTimeFactory] used by the chart. The factory
      // should create the same type of [DateTime] as the data provided. If none
      // specified, the default creates local date time.
      dateTimeFactory: const charts.LocalDateTimeFactory(),
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<TimeSeriesSales, DateTime>> _createSampleData() {
    var rng = new Random();
    final desktopSalesData = [
      new TimeSeriesSales(new DateTime(2017, 1), rng.nextInt(100)),
      new TimeSeriesSales(new DateTime(2017, 2), rng.nextInt(100)),
      new TimeSeriesSales(new DateTime(2017, 3), rng.nextInt(100)),
      new TimeSeriesSales(new DateTime(2017, 4), rng.nextInt(100)),
      new TimeSeriesSales(new DateTime(2017, 5), rng.nextInt(100)),
      new TimeSeriesSales(new DateTime(2017, 6), rng.nextInt(100)),
      new TimeSeriesSales(new DateTime(2017, 7), rng.nextInt(100)),
      new TimeSeriesSales(new DateTime(2017, 8), rng.nextInt(100)),
      new TimeSeriesSales(new DateTime(2017, 9), rng.nextInt(100)),
      new TimeSeriesSales(new DateTime(2017, 10), rng.nextInt(100)),
      new TimeSeriesSales(new DateTime(2017, 11), rng.nextInt(100)),
      new TimeSeriesSales(new DateTime(2017, 12), rng.nextInt(100)),
    ];

    final tableSalesData = [
      new TimeSeriesSales(new DateTime(2017, 1), rng.nextInt(100)),
      new TimeSeriesSales(new DateTime(2017, 2), rng.nextInt(100)),
      new TimeSeriesSales(new DateTime(2017, 3), rng.nextInt(100)),
      new TimeSeriesSales(new DateTime(2017, 4), rng.nextInt(100)),
      new TimeSeriesSales(new DateTime(2017, 5), rng.nextInt(100)),
      new TimeSeriesSales(new DateTime(2017, 6), rng.nextInt(100)),
      new TimeSeriesSales(new DateTime(2017, 7), rng.nextInt(100)),
      new TimeSeriesSales(new DateTime(2017, 8), rng.nextInt(100)),
      new TimeSeriesSales(new DateTime(2017, 9), rng.nextInt(100)),
      new TimeSeriesSales(new DateTime(2017, 10), rng.nextInt(100)),
      new TimeSeriesSales(new DateTime(2017, 11), rng.nextInt(100)),
      new TimeSeriesSales(new DateTime(2017, 12), rng.nextInt(100)),
    ];

    return [
      new charts.Series<TimeSeriesSales, DateTime>(
        id: 'Desktop',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TimeSeriesSales sales, _) => sales.time,
        measureFn: (TimeSeriesSales sales, _) => sales.sales,
        data: desktopSalesData,
      ),
      new charts.Series<TimeSeriesSales, DateTime>(
        id: 'Tablet',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (TimeSeriesSales sales, _) => sales.time,
        measureFn: (TimeSeriesSales sales, _) => sales.sales,
        data: tableSalesData,
      ),
    ];
  }
}

/// Sample time series data type.
class TimeSeriesSales {
  final DateTime time;
  final int sales;

  TimeSeriesSales(this.time, this.sales);
}
