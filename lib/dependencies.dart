import 'package:app/data/sembast_reading_repository.dart';
import 'package:app/domain/reading_controller.dart';
import 'package:app/data/reading_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  WidgetsFlutterBinding.ensureInitialized();
  final getIt = GetIt.instance;
  final readingRepository = SembastReadingRepository();
  await readingRepository.init();
  getIt.registerSingleton<ReadingRepository>(readingRepository);

  final readingController = ReadingController();
  readingController.init();
  getIt.registerSingleton(
    readingController,
    dispose: (controller) => controller.dispose(),
  );
}
