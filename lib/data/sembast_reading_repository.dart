import 'package:app/data/reading_repository.dart';
import 'package:app/model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

const _db_file_name = "readings.db";
const _db_version = 1;
const _store_name = "readings";

class SembastReadingRepository implements ReadingRepository {
  Database db;
  final _store = StoreRef(_store_name);

  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    await dir.create(recursive: true);
    final dbPath = join(dir.path, _db_file_name);
    db = await databaseFactoryIo.openDatabase(
      dbPath,
      version: _db_version,
    );
  }

  @override
  Stream<List<Reading>> getReadings() {
    final query = _store.query(
      finder: Finder(
        sortOrders: [
          SortOrder(
            "date",
            false,
          )
        ],
      ),
    );
    return query
        .onSnapshots(db)
        .map((snapshot) => snapshot
            .map((snapshot) => Reading.fromJson(snapshot.value))
            .toList())
        .asBroadcastStream();
  }

  @override
  Future<void> storeReading(Reading reading) async {
    await _store.add(db, reading.toJson());
  }

  @override
  Future<int> clearDatabase() async {
    return _store.delete(db);
  }

  void dispose() {
    db?.close();
  }
}
