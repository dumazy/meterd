import 'package:app/dependencies.dart';
import 'package:app/main.dart';
import 'package:app/model.dart';
import 'package:app/domain/reading_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timeago/timeago.dart' as timeago;

class PreviousReadings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Reading>>(
      stream: getIt<ReadingController>().previousReadings,
      builder: (_, snapshot) {
        if (!snapshot.hasData)
          return Center(
            child: CircularProgressIndicator(),
          );
        final readings = snapshot.data;
        return ListView.separated(
          padding: const EdgeInsets.only(bottom: bottom_bar_height),
          itemCount: readings.length,
          itemBuilder: (_, index) {
            final reading = readings[index];
            return _ReadingListItem(reading: reading);
          },
          separatorBuilder: (_, index) => Divider(),
        );
      },
    );
  }
}

class SliverPreviousReadings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Reading>>(
      stream: getIt<ReadingController>().previousReadings,
      builder: (_, snapshot) {
        if (!snapshot.hasData)
          return SliverToBoxAdapter(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        final readings = snapshot.data;
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (_, index) {
              if (index == readings.length)
                return SizedBox(height: bottom_bar_height);
              final reading = readings[index];

              return _ReadingListItem(reading: reading);
            },
            childCount: readings.length + 1,
            // padding: const EdgeInsets.only(bottom: bottom_bar_height),
            // itemCount: readings.length,
            // itemBuilder: (_, index) {
            //   final reading = readings[index];
            //   return _ReadingListItem(reading: reading);
            // },
            // separatorBuilder: (_, index) => Divider(),
            // ),
          ),
        );
      },
    );
  }
}

class _ReadingListItem extends StatelessWidget {
  final Reading reading;

  const _ReadingListItem({Key key, this.reading}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final dateString = timeago.format(reading.date);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "${reading.value}",
            style: GoogleFonts.comicNeue(
              fontSize: 24,
            ),
          ),
          Text(dateString),
        ],
      ),
    );
  }
}
