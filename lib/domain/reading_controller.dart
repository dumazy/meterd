import 'dart:async';

import 'package:app/dependencies.dart';
import 'package:app/model.dart';
import 'package:app/data/reading_repository.dart';

class ReadingController {
  final _repository = getIt<ReadingRepository>();

  Stream<List<Reading>> _readings;
  Stream<Reading> get lastReading => _readings?.map((list) => list.first);
  Stream<List<Reading>> get previousReadings => _readings;

  Future<void> init() async {
    _readings = _repository.getReadings();
  }

  void addReading(Reading reading) {
    _repository.storeReading(reading);
  }

  void dispose() {}
}
