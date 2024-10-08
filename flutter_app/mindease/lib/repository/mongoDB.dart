import 'package:mindease/provider/importer.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
      BuildContext context, String email, String nickname, String password) async {
    if (await isNicknameAvailable(nickname)) {
      var collection = db.collection('Utenti_registrati');
      await collection.insert({
        'email': email,
        'nickname': nickname,
        'password': password,
      });
      // Mostra uno Snackbar di successo
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Registrazione completata con successo!'),
          duration: Duration(seconds: 3), // Durata del messaggio
        ),
      );
    } else {
      // Mostra uno Snackbar con il messaggio di errore
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Il nickname "$nickname" è già stato utilizzato. Scegli un altro nickname.'),
          duration: const Duration(seconds: 3), // Durata del messaggio
        ),
      );
    }
  }

  Future<void> registerUserSocial(String email, String nickname) async {
    await open(); // Ensure the database is open
    var collection = db.collection('Utenti_registrati');
    await collection.insert({
      'email': email,
      'nickname': nickname,
      'password': '', // Password is not required for social login
    });
    await close(); // Ensure the database is closed
  }

  Future<void> updateNickname(String email, String newNickname) async {
    await open(); // Ensure the database is open
    var collection = db.collection('Utenti_registrati');
    await collection.update(
      where.eq('email', email),
      modify.set('nickname', newNickname),
    );
    await close(); // Ensure the database is closed
  }
  
  Future<bool> isNicknameAvailable(String nickname) async {
    final response = await http.post(
      Uri.parse('https://vvi51i7nf4.execute-api.us-east-1.amazonaws.com/default/verifica_nickname'),
      body: jsonEncode({'nickname': nickname}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // Check if the response contains any entries for the nickname
      return data.isEmpty;
    } else {
      throw Exception('Failed to check nickname availability');
    }
  }

  Future<bool> isUserExists(String email) async {
    await open(); // Ensure the database is open
    var collection = db.collection('Utenti_registrati');
    var result = await collection.findOne(where.eq('email', email));
    await close(); // Ensure the database is closed
    return result != null;
  }

  Future<String> getNicknameByEmail(String email) async {
    await open(); // Ensure the database is open
    var collection = db.collection('Utenti_registrati');
    var result = await collection.findOne(where.eq('email', email));
    await close(); // Ensure the database is closed
    return result?['nickname'] ?? '';
  }

  Future<void> updateUserNicknameByEmail(String email, String newNickname) async {
    await open(); // Ensure the database is open
    var collection = db.collection('Utenti_registrati');
    await collection.update(
      where.eq('email', email),
      modify.set('nickname', newNickname),
    );
    await close(); // Ensure the database is closed
  }

  Future<void> updateUserByNickname(BuildContext context, String oldNickname, String newNickname) async {
    print('Old Nickname: $oldNickname');
    print('New Nickname: $newNickname');

    // Verifica se il nuovo nickname è disponibile per l'aggiornamento
    bool isAvailable = await isNicknameAvailable(newNickname);

    if (!isAvailable) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Il nickname "$newNickname" è già stato utilizzato. Scegli un altro nickname.'),
          duration: const Duration(seconds: 3),
        ),
      );
    } else {
      var collection = db.collection('Utenti_registrati');
      var result = await collection.update(
        where.eq('nickname', oldNickname),
        modify.set('nickname', newNickname),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Nickname salvato con successo!'),
          duration: const Duration(seconds: 3),
        ),
      );
    }
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
