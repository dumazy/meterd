import 'package:app/bottom_bar.dart';
import 'package:app/dependencies.dart';
import 'package:app/last_reading.dart';
import 'package:app/previous_readings.dart';
import 'package:app/domain/reading_controller.dart';
import 'package:app/reading_input.dart';
import 'package:app/settings/settings_screen.dart';
import 'package:flutter/material.dart';

import 'graph/reading_graph.dart';

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

const bottom_bar_height = 80.0;

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                pinned: true,
                floating: true,
                expandedHeight: 380,
                stretch: true,
                flexibleSpace: FlexibleSpaceBar(
                  stretchModes: [
                    StretchMode.blurBackground,
                    StretchMode.fadeTitle,
                  ],
                  background: SafeArea(child: ReadingGraph()),
                ),
              ),
              SliverPreviousReadings(),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: BottomBar(
              onPressed: () => _showAddDialog(context),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddDialog(BuildContext context) async {
    final reading = await AddReadingBottomSheet.show(context);
    if (reading != null) {
      getIt<ReadingController>().addReading(reading);
    }
  }
}
