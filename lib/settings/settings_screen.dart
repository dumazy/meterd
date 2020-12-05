import 'package:app/data/reading_repository.dart';
import 'package:app/dependencies.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  static Route<dynamic> route() => MaterialPageRoute(
        builder: (_) => SettingsScreen(),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _ClearDatabase(),
          ],
        ),
      ),
    );
  }
}

class _ClearDatabase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(
        child: Text("Clear database"),
        onPressed: () => _clearDatabase(context),
      ),
    );
  }

  void _clearDatabase(BuildContext context) async {
    final confirmed = (await showDialog(
          context: context,
          builder: (_) => _ClearDatabaseConfirmDialog(),
        )) ??
        false;
    if (confirmed) {
      final deletedRecords = await getIt<ReadingRepository>().clearDatabase();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Deleted $deletedRecords records"),
        ),
      );
    }
  }
}

class _ClearDatabaseConfirmDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Clear database"),
      content: Text("Are you sure you want to clear the database?"),
      actions: [
        FlatButton(
          child: Text("Cancel"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text("Clear"),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
      ],
    );
  }
}
