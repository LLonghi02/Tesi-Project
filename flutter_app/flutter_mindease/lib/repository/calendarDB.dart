import 'package:mongo_dart/mongo_dart.dart';

class CalendarDBService {
  final Db db = Db('mongodb://Lara_tesi:Lara.2002@ac-uskqbkl-shard-00-00.8wbw9av.mongodb.net:27017,ac-uskqbkl-shard-00-01.8wbw9av.mongodb.net:27017,ac-uskqbkl-shard-00-02.8wbw9av.mongodb.net:27017/Tesi_MindEase?ssl=true&replicaSet=atlas-uskqbkl-shard-0&authSource=admin&retryWrites=true&w=majority');

  Future<void> open() async {
    await db.open();
  }

  Future<void> close() async {
    await db.close();
  }

  Future<void> recordEmotion(String emotion, String cause, List<String> symptoms) async {
    var collection = db.collection('Calendar_Emotions');
    await collection.insert({
      'Data': DateTime.now(),
      'Emozione': emotion,
      'Causa': cause,
      'Sintomi': symptoms,
    });
  }
}
