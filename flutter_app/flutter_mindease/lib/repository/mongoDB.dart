import 'package:mongo_dart/mongo_dart.dart';

class MongoDBService {
  final Db db = Db(
      'mongodb://Lara_tesi:Lara.2002@ac-uskqbkl-shard-00-00.8wbw9av.mongodb.net:27017,ac-uskqbkl-shard-00-01.8wbw9av.mongodb.net:27017,ac-uskqbkl-shard-00-02.8wbw9av.mongodb.net:27017/Tesi_MindEase?ssl=true&replicaSet=atlas-uskqbkl-shard-0&authSource=admin&retryWrites=true&w=majority');

  Future<void> open() async {
    await db.open();
  }

  Future<void> close() async {
    await db.close();
  }

  Future<void> registerUser(
      String email, String nickname, String password) async {
    var collection = db.collection('Utenti_registrati');
    await collection.insert({
      'email': email,
      'nickname': nickname,
      'password': password,
    });
  }

 Future<void> updateUserByNickname(String oldNickname, String newNickname) async {
  print('Old Nickname: $oldNickname');
  print('New Nickname: $newNickname');

  var collection = db.collection('Utenti_registrati');
  var result = await collection.update(
    where.eq('nickname', oldNickname),
    modify.set('nickname', newNickname),
  );


}
Future<void> updateUserByPassword(String oldPassword, String newPassword) async {
  print('Old Password: $oldPassword');
  print('New Password: $newPassword');

  var collection = db.collection('Utenti_registrati');
  var result = await collection.update(
    where.eq('password', oldPassword),
    modify.set('password', newPassword),
  );


}

}

final mongoDBService = MongoDBService();
