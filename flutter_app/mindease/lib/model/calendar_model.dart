class CalendarModel {
  final String id;
  final String data;
  final String emozione;
  final String causa;
  final List<String> sintomi; // Aggiunto campo per i sintomi

  CalendarModel({
    required this.id,
    required this.data,
    required this.emozione,
    required this.causa,
    required this.sintomi, // Aggiunto al costruttore
  });

  factory CalendarModel.fromJson(Map<String, dynamic> json) {
    // Conversione della lista di sintomi da JSON a List<String>
    List<String> sintomiList = [];
    if (json['Sintomi'] != null) {
      sintomiList = List<String>.from(json['Sintomi']);
    }

    return CalendarModel(
      id: json['_id'],
      data: json['Data'],
      emozione: json['Emozione'],
      causa: json['Causa'],
      sintomi: sintomiList, // Assegnamento dei sintomi
    );
  }
}
