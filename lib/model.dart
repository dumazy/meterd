class Reading {
  final double value;
  final DateTime date;

  Reading({
    this.value,
    this.date,
  });

  Reading.fromJson(Map<String, dynamic> json)
      : value = json['value'],
        date = DateTime.parse(json['date']);

  Map<String, dynamic> toJson() {
    return {
      'value': value,
      'date': date.toIso8601String(),
    };
  }
}
