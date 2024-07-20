import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindease/provider/userProvider.dart';
import 'package:mongo_dart/mongo_dart.dart';

class CalendarDBService {
  final Db db = Db(
      'mongodb://Lara_tesi:Lara.2002@ac-uskqbkl-shard-00-00.8wbw9av.mongodb.net:27017,ac-uskqbkl-shard-00-01.8wbw9av.mongodb.net:27017,ac-uskqbkl-shard-00-02.8wbw9av.mongodb.net:27017/Tesi_MindEase?ssl=true&replicaSet=atlas-uskqbkl-shard-0&authSource=admin&retryWrites=true&w=majority');
      
  Future<void> open() async {
    await db.open();
  }

  Future<void> close() async {
    await db.close();
  }
Future<void> recordEmotion(
  String emotion,
  String cause,
  List<String> symptoms,
  String nickname,

) async {
  var collection = db.collection('Calendar_Emotions_DB');
  var currentDate = DateTime.now().toIso8601String().split('T')[0];

  await collection.insertOne({
    'Data': currentDate,
    'Emozione': emotion,
    'Causa': cause,
    'Sintomi': symptoms,
    'Nickname': nickname,
  });
}

Future<void> updateDBByNickname(BuildContext context,String oldNickname, String newNickname) async {
    var collection = db.collection('Calendar_Emotions_DB');
    var result = await collection.update(
      where.eq('Nickname', oldNickname),
      modify.set('Nickname', newNickname),
    );

  }


}
