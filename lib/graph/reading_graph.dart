import 'package:app/dependencies.dart';
import 'package:app/domain/reading_controller.dart';
import 'package:app/model.dart';
import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';

class ReadingGraph extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Reading>>(
        stream: getIt<ReadingController>().previousReadings,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Container();
          final readings = snapshot.data;
          return TimeSeriesChart(
            mapToSeries(readings),
            // Optionally pass in a [DateTimeFactory] used by the chart. The factory
            // should create the same type of [DateTime] as the data provided. If none
            // specified, the default creates local date time.
            dateTimeFactory: const LocalDateTimeFactory(),
          );
        });
  }
}

List<Series<Reading, DateTime>> mapToSeries(List<Reading> readings) {
  return [
    Series(
      id: 'readings',
      data: readings,
      colorFn: (_, __) => MaterialPalette.red.shadeDefault,
      domainFn: (reading, _) => reading.date,
      measureFn: (reading, _) => reading.value,
    ),
  ];
}
