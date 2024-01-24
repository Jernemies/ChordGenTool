import 'chord.dart';

List<String> notesToPlay(List<Chord> chordList){
  List<String> notes = [];
  for (int i = 0; i < chordList.length; i++)
  {
    notes.add(chordList[i].name.toString());
  }
  return notes;
}