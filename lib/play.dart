import 'chord.dart';

//Assemble chord from list of tones
List<String> notesToPlay(Chord chord){
  List<String> notes = [];
  List<int> baseChord = [1,5,8,12];
  for (int i = 0; i < chord.tones!.length; i++)
  {
    int note = baseChord[i] ;
    note += chord.tones![i] - 1;


    note += chord.root!;
    if (note > 12)
    {
      note -= 12;
    }
    print(note);
    notes.add("$note.wav");
  }
  return notes;
}