import 'package:app/model.dart';

abstract class ReadingRepository {
  /// Gets reading sorted by date, last one first
  Stream<List<Reading>> getReadings();
  Future<void> storeReading(Reading reading);
  Future<int> clearDatabase();
}

class FakeReadingRepository implements ReadingRepository {
  @override
  Stream<List<Reading>> getReadings() {
    return Stream.periodic(
      Duration(milliseconds: 100),
      (_) => [
        Reading(date: DateTime.now(), value: 123.4),
        Reading(date: DateTime.now().subtract(Duration(days: 1)), value: 115.4),
        Reading(date: DateTime.now().subtract(Duration(days: 2)), value: 100.4),
        Reading(date: DateTime.now().subtract(Duration(days: 3)), value: 80.4),
      ],
    );
  }

  @override
  Future<void> storeReading(Reading reading) {
    print("Storing reading: $reading");
    return Future.delayed(
      Duration(milliseconds: 100),
    );
  }

  @override
  Future<int> clearDatabase() async {}
}
