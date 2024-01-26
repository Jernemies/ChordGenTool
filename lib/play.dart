import 'chord.dart';

//Return filename
List<String> notesToPlay(Chord chord){
  List<String> notes = [];
  int note = chord.root! + 1;
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

  notes.add("$note.wav");
  return notes;
}