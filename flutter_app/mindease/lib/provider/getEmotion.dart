// emotion_utils.dart

String getEmotionImage(String emotion) {
  switch (emotion.toLowerCase()) {
    case 'felice':
      return 'assets/images/emotion/felice.png';
    case 'triste':
      return 'assets/images/emotion/triste.png';
    case 'arrabbiato':
      return 'assets/images/emotion/arabbiato.png';
    case 'annoiato':
      return 'assets/images/emotion/annoiato.png';
    case 'calmo':
      return 'assets/images/emotion/calmo.png';
    case 'eccitato':
      return 'assets/images/emotion/eccitato.png';
    case 'preoccupato':
      return 'assets/images/emotion/preoccupato.png';
    case 'rilassato':
      return 'assets/images/emotion/rilassato.png';
    case 'stanco':
      return 'assets/images/emotion/stanco.png';
    case 'stressato':
      return 'assets/images/emotion/stressed.png';
    case 'ansia':
      return 'assets/images/emotion/ansia.png';
    // Aggiungi altri casi per le diverse emozioni e i relativi percorsi delle immagini
    default:
      return 'assets/images/emotion/felice.png'; // Immagine predefinita per emozioni non specificate
  }
}
