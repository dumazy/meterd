import 'package:app/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AddReadingBottomSheet extends StatefulWidget {
  static Future<Reading> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => AddReadingBottomSheet(),
    );
  }

  @override
  _AddReadingBottomSheetState createState() => _AddReadingBottomSheetState();
}

class _AddReadingBottomSheetState extends State<AddReadingBottomSheet> {
  DateTime _selectedDate;
  TimeOfDay _selectedTime;
  double _value;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _selectedTime = TimeOfDay.now();
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      backgroundColor: Colors.transparent,
      onClosing: () {
        print("Closing bottom sheet");
      },
      builder: (_) {
        return Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20.0),
            ),
          ),
          child: Column(
            children: [
              Text(
                "Add new reading",
                style: GoogleFonts.ubuntu(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              ValueInput(
                value: _value,
                onChanged: (value) => setState(() {
                  _value = value;
                }),
              ),
              SizedBox(
                height: 20.0,
              ),
              _DateTimeSelector(
                date: _selectedDate,
                time: _selectedTime,
                onDateChanged: (date) => setState(() {
                  _selectedDate = date;
                }),
                onTimeChanged: (time) => setState(() {
                  _selectedTime = time;
                }),
              ),
              SizedBox(
                height: 10.0,
              ),
              FlatButton(
                onPressed: _addReading,
                child: Text("Add"),
              ),
            ],
          ),
        );
      },
    );
  }

  void _addReading() {
    try {
      if (_value == null) return;
      final date = DateTime(
        _selectedDate.year,
        _selectedDate.month,
        _selectedDate.day,
        _selectedTime.hour,
        _selectedTime.minute,
      );
      final reading = Reading(value: _value, date: date);
      Navigator.of(context).pop(reading);
    } catch (e) {
      print("Error updating reading: $e");
      rethrow;
    }
  }
}

class _DateTimeSelector extends StatelessWidget {
  final DateTime date;
  final TimeOfDay time;
  final ValueChanged<DateTime> onDateChanged;
  final ValueChanged<TimeOfDay> onTimeChanged;

  const _DateTimeSelector({
    Key key,
    @required this.date,
    @required this.time,
    @required this.onDateChanged,
    @required this.onTimeChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedDateString = DateFormat.yMd().format(date);
    final selectedTimeString = time.format(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        DateTimeButton(
          icon: Icon(Icons.calendar_today),
          label: Text("$selectedDateString"),
          onPressed: () => _showDatePicker(context),
        ),
        DateTimeButton(
          icon: Icon(Icons.access_time),
          label: Text("$selectedTimeString"),
          onPressed: () => _showTimePicker(context),
        ),
      ],
    );
  }

  void _showDatePicker(BuildContext context) async {
    final result = await showDatePicker(
      context: context,
      firstDate: DateTime.now().subtract(Duration(days: 30)),
      lastDate: DateTime.now(),
      initialDate: date,
    );
    if (result != null) {
      onDateChanged(result);
    }
  }

  void _showTimePicker(BuildContext context) async {
    final result = await showTimePicker(
      context: context,
      initialTime: time,
    );
    if (result != null) {
      onTimeChanged(result);
    }
  }
}

class ValueInput extends StatefulWidget {
  final double value;
  final ValueChanged<double> onChanged;

  const ValueInput({Key key, this.value, this.onChanged}) : super(key: key);

  @override
  _ValueInputState createState() => _ValueInputState();
}

class _ValueInputState extends State<ValueInput> {
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value?.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(),
      ),
      child: Row(
        children: [
          Icon(Icons.show_chart),
          SizedBox(
            width: 8.0,
          ),
          Flexible(
            child: TextField(
              controller: _controller,
              onChanged: _onChanged,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*')),
              ],
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onChanged(String input) {
    final value = double.tryParse(input);
    if (value != null) {
      widget.onChanged(value);
    }
  }
}

class DateTimeButton extends StatelessWidget {
  final Widget icon;
  final Widget label;
  final VoidCallback onPressed;

  const DateTimeButton({
    Key key,
    this.icon,
    this.label,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlineButton.icon(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      // borderSide: BorderSide(
      //   color: Theme.of(context).accentColor,
      // ),
      // color: Theme.of(context).accentColor,
      icon: icon,
      label: label,
      onPressed: onPressed,
    );
  }
}
