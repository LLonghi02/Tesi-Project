import 'package:mongo_dart/mongo_dart.dart';
import 'package:flutter/material.dart';

class MindfulnessDBService {
  final Db db = Db(
    'mongodb://Lara_tesi:Lara.2002@ac-uskqbkl-shard-00-00.8wbw9av.mongodb.net:27017,ac-uskqbkl-shard-00-01.8wbw9av.mongodb.net:27017,ac-uskqbkl-shard-00-02.8wbw9av.mongodb.net:27017/Tesi_MindEase?ssl=true&replicaSet=atlas-uskqbkl-shard-0&authSource=admin&retryWrites=true&w=majority',
  );

  Future<void> open() async {
    if (!db.isConnected) {
      try {
        await db.open();
      } catch (e) {
        print('Errore durante l\'apertura della connessione al database: $e');
        throw e; // Rilancia l'eccezione per la gestione a livello superiore
      }
    }
  }

  Future<void> close() async {
    if (db.isConnected) {
      try {
        await db.close();
      } catch (e) {
        print('Errore durante la chiusura della connessione al database: $e');
      }
    }
  }

  Future<void> recordLevel(
    String level,
    String nickname,
  ) async {
    await open(); // Assicurati che la connessione sia aperta

    try {
      var collection = db.collection('Mindufulness_DB');
      var currentDate = DateTime.now().toIso8601String().split('T')[0];

      await collection.insertOne({
        'Data': currentDate,
        'Livello': level,
        'Nickname': nickname,
      });
    } catch (e) {
      print('Errore durante l\'inserimento dei dati: $e');
    } finally {
      await close(); // Chiudi la connessione
    }
  }

  /*Future<void> updateDBByNickname(
    BuildContext context,
    String oldNickname,
    String newNickname,
  ) async {
    await open(); // Assicurati che la connessione sia aperta

    try {
      var collection = db.collection('Calendar_Emotions_DB');
      var result = await collection.update(
        where.eq('Nickname', oldNickname),
        modify.set('Nickname', newNickname),
      );

      if (result['nModified'] == 0) {
        print('Nessun documento aggiornato');
      }
    } catch (e) {
      print('Errore durante l\'aggiornamento dei dati: $e');
    } finally {
      await close(); // Chiudi la connessione
    }
  }*/
}
