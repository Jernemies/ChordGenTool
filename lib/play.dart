import 'chord.dart';

//Return filename
String notesToPlay(Chord chord) {
  List<String> notes = [];
  int note = chord.root! + 1;
  String file = "$note.wav";
  // List<int> baseChord = [1,5,8,12];
  // for (int i = 0; i < chord.tones!.length; i++)
  // {
  //   note += chord.tones![i] - 1;

  //   note += chord.root!;
  //   if (note > 12)
  //   {
  //     note -= 12;
  //   }
  //   print(note);
  //   notes.add("$note.wav");
  // }
  return file;
}

String scaleNotesToPlay(int index) {
  List<String> notes = [];
  int note = index + 1;
  String file = "$note.wav";
  // List<int> baseChord = [1,5,8,12];
  // for (int i = 0; i < chord.tones!.length; i++)
  // {
  //   note += chord.tones![i] - 1;

  //   note += chord.root!;
  //   if (note > 12)
  //   {
  //     note -= 12;
  //   }
  //   print(note);
  //   notes.add("$note.wav");
  // }
  return file;
}
