import 'package:app/dependencies.dart';
import 'package:app/model.dart';
import 'package:app/domain/reading_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timeago/timeago.dart' as timeago;

class LastReading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _Title(),
            SizedBox(
              height: 10,
            ),
            _Body(),
          ],
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      "Last reading",
      style: TextStyle(
        fontSize: 18,
      ),
    );
  }
}

class _Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Reading>(
      stream: getIt<ReadingController>().lastReading,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return Center(
            child: CircularProgressIndicator(),
          );

        if (!snapshot.hasData) {
          return Center(
            child: Text("No entries yet"),
          );
        }
        final reading = snapshot.data;
        final dateString = timeago.format(reading.date);
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${reading.value}",
              style: GoogleFonts.comicNeue(
                fontSize: 32,
              ),
            ),
            Text(
              dateString,
              style: TextStyle(fontSize: 16),
            )
          ],
        );
      },
    );
  }
}
