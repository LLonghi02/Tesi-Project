class CalendarModel {
  final String id;
  final String data;
  final String emozione;
  final String causa;

  CalendarModel({
    required this.id,
    required this.data,
    required this.emozione,
    required this.causa,
  });

  factory CalendarModel.fromJson(Map<String, dynamic> json) {
    return CalendarModel(
      id: json['_id'],
      data: json['Data'],
      emozione: json['Emozione'],
      causa: json['Causa'],
    );
  }
}
