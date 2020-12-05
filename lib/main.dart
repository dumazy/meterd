import 'package:app/dependencies.dart';
import 'package:app/last_reading.dart';
import 'package:app/previous_readings.dart';
import 'package:app/domain/reading_controller.dart';
import 'package:app/reading_input.dart';
import 'package:app/settings/settings_screen.dart';
import 'package:flutter/material.dart';

void main() async {
  await initDependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meter readings"),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => _openSettings(context),
          ),
        ],
      ),
      body: Column(
        children: [
          LastReading(),
          Expanded(
            child: PreviousReadings(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _showAddDialog(context),
      ),
    );
  }

  void _openSettings(BuildContext context) {
    Navigator.of(context).push(SettingsScreen.route());
  }

  void _showAddDialog(BuildContext context) async {
    final reading = await AddReadingBottomSheet.show(context);
    if (reading != null) {
      getIt<ReadingController>().addReading(reading);
    }
  }
}
