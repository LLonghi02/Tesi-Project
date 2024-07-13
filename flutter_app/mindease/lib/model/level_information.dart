class LevelInformation {
  final String title;
  final String description;

  LevelInformation(this.title, this.description);

  static LevelInformation getLevel(int level) {
    switch (level) {
      case 1:
        return LevelInformation(
          'Giorno 1: Respirazione consapevole',
          'Focalizza la tua attenzione sul respiro per almeno 5 minuti, osservando ogni inspirazione e espirazione senza giudizio.',
        );
      case 2:
        return LevelInformation(
          'Giorno 2: Scansione corporea',
          'Pratica la scansione corporea: dedica 10 minuti a percepire le sensazioni del tuo corpo da testa a piedi.',
        );
      case 3:
        return LevelInformation(
          'Giorno 3: Gratitudine quotidiana',
          'Identifica tre cose per cui sei grato oggi e rifletti su come ti fanno sentire.',
        );
      case 4:
        return LevelInformation(
          'Giorno 4: Momento di silenzio',
          'Trova un momento per sederti in silenzio per 15 minuti, senza fare nulla e semplicemente essendo presente.',
        );
      case 5:
        return LevelInformation(
          'Giorno 5: Camminata consapevole',
          'Fai una breve camminata consapevole, concentrandoti sul movimento dei piedi e delle sensazioni corporee durante il cammino.',
        );
      case 6:
        return LevelInformation(
          'Giorno 6: Ascolto attento',
          'Durante una conversazione, ascolta attentamente senza interrompere o pensare alla tua risposta. Concentrati solo su ciò che l\'altra persona sta dicendo.',
        );
      case 7:
        return LevelInformation(
          'Giorno 7: Pratica della gentilezza',
          'Pratica un atto di gentilezza senza aspettarti nulla in cambio, semplicemente per portare gioia o conforto a qualcuno.',
        );
      case 8:
        return LevelInformation(
          'Giorno 8: Osservazione dei pensieri',
          'Osserva i tuoi pensieri come se fossero nuvole che passano nel cielo, senza identificarti con essi o giudicarli.',
        );
      case 9:
        return LevelInformation(
          'Giorno 9: Yoga o stretching',
          'Dedica del tempo a praticare yoga o stretching, concentrandoti sul movimento e sulla connessione con il tuo respiro.',
        );
      case 10:
        return LevelInformation(
          'Giorno 10: Mindful eating',
          'Durante un pasto, mangia lentamente e prenditi il tempo per apprezzare i sapori, le texture e l\'esperienza del cibo.',
        );
      case 11:
        return LevelInformation(
          'Giorno 11: Visualizzazione positiva',
          'Visualizza un obiettivo o un desiderio positivo per il tuo futuro con dettagli vividi, immergendoti nelle emozioni che suscita.',
        );
      case 12:
        return LevelInformation(
          'Giorno 12: Riposo consapevole',
          'Pratica il riposo consapevole dedicando 15 minuti a un\'attività che ti rilassa completamente, come la lettura o la meditazione.',
        );
      case 13:
        return LevelInformation(
          'Giorno 13: Connettiti con la natura',
          'Passa del tempo all\'aperto, osservando e connettendoti consapevolmente con la natura che ti circonda.',
        );
      case 14:
        return LevelInformation(
          'Giorno 14: Mindful listening',
          'Oggi, pratica l\'ascolto consapevole in una conversazione. Sii presente e ascolta veramente ciò che l\'altra persona sta comunicando.',
        );
      case 15:
        return LevelInformation(
          'Giorno 15: Momento di gratitudine serale',
          'Prima di dormire, rifletti su tre cose belle che sono accadute durante la giornata e senti la gratitudine per esse.',
        );
      case 16:
        return LevelInformation(
          'Giorno 16: Esplorazione sensoriale',
          'Esplora consapevolmente i tuoi cinque sensi oggi, notando i suoni, i profumi, i sapori, le sensazioni tattili e le immagini intorno a te.',
        );
      case 17:
        return LevelInformation(
          'Giorno 17: Pratica della compassione',
          'Porta gentilezza e compassione verso te stesso e gli altri oggi, sostituendo i giudizi con parole di accettazione e comprensione.',
        );
      case 18:
        return LevelInformation(
          'Giorno 18: Mindful technology use',
          'Utilizza la tecnologia con consapevolezza oggi, limitando le distrazioni e prendendoti il tempo per essere pienamente presente durante l\'uso.',
        );
      case 19:
        return LevelInformation(
          'Giorno 19: Esplorazione della mente',
          'Oggi, osserva i tuoi stati mentali e le emozioni senza cercare di cambiarli, semplicemente permettendo loro di essere presenti.',
        );
      case 20:
        return LevelInformation(
          'Giorno 20: Mindful reading',
          'Leggi un libro o un articolo con attenzione e consapevolezza, immergendoti completamente nelle parole e nelle idee che vengono trasmesse.',
        );
      case 21:
        return LevelInformation(
          'Giorno 21: Danza o movimento consapevole',
          'Esplora il movimento del tuo corpo attraverso la danza o il movimento libero, prestando attenzione alle sensazioni e al ritmo.',
        );
      case 22:
        return LevelInformation(
          'Giorno 22: Mindful driving',
          'Guida oggi con consapevolezza e attenzione al momento presente, notando i dettagli del percorso e le sensazioni fisiche durante la guida.',
        );
      case 23:
        return LevelInformation(
          'Giorno 23: Pratica del perdono',
          'Pratica il perdono verso te stesso o verso qualcun altro, lasciando andare le risentimenti e aprendo spazio per la compassione.',
        );
      case 24:
        return LevelInformation(
          'Giorno 24: Mindful communication',
          'Comunica oggi con consapevolezza e gentilezza, scegliendo le parole con attenzione e ascoltando veramente chi ti sta parlando.',
        );
      case 25:
        return LevelInformation(
          'Giorno 25: Mindful art',
          'Crea oggi qualcosa con consapevolezza, che sia disegno, pittura o qualsiasi forma di arte che ti permetta di esprimere te stesso.',
        );
      case 26:
        return LevelInformation(
          'Giorno 26: Pratica della presenza',
          'Porta consapevolezza alla tua giornata, cercando di essere presente in ogni momento e in ogni azione che svolgi.',
        );
      case 27:
        return LevelInformation(
          'Giorno 27: Mindful decision making',
          'Prendi una decisione importante oggi con consapevolezza, riflettendo sulle conseguenze e sulle tue intenzioni prima di agire.',
        );
      case 28:
        return LevelInformation(
          'Giorno 28: Mindful rest',
          'Dedica del tempo oggi a riposare e rigenerarti, permettendo al tuo corpo e alla tua mente di rilassarsi completamente.',
        );
      case 29:
        return LevelInformation(
          'Giorno 29: Mindful reflection',
          'Rifletti sulla tua settimana con consapevolezza, osservando i momenti di gioia, di sfida e di crescita con gentilezza verso te stesso.',
        );
      case 30:
        return LevelInformation(
          'Giorno 30: Celebrazione della pratica',
          'Celebra il tuo impegno nella pratica della mindfulness oggi, riconoscendo gli sforzi fatti e l\'effetto positivo che ha avuto nella tua vita.',
        );
      default:
        return LevelInformation(
          'Challenge',
          'Description for this level.',
        );
    }
  }
}
