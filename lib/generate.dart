import 'chord.dart';
import 'dart:math';

List<Chord> generate(
    int numChords, bool extend // List<int> scale, List<Chord> frozenChords
    ) {
  //numChords: Let user define the amount of chords to generate from 1 to 8.
  //extend: User can choose to include extensions past 7
  List<int> scale;
  List<Chord> frozenChords;
  numChords = numChords.clamp(1, 8);
  //Chord tones 1,3,5,7. This list stores the quality of the tones (flat, natural, sharp)
  List<int> baseChord = [1, 1, 1, 1];
  //Chord tones 9,11,13
  List<int> extensions = [1, 1, 1];
  List<Chord> chords = [];
  int root = 0;
  bool firstChord = true;

  /* Chord construction logic:
    -Root for the first chord is 0, so there's always a I chord. Chords get shuffled in the end
		-choose root (0-11), then choose from baseChord[] which chord tones to exclude(1,3,5 always included)
		-Pass each tone through alterations.Flat is lowered by 1, sharp is raised by 1, natural is unchanged
    -Add alterations to a list corresponding to indexes of chord tones
		-Flat is notated as b in front of the tone, sharp is notated as # in front of the tone
		-3 can be flat or natural. 5 can be flat, natural, or sharp. 7 can be flat or natural
		-9 can be flat, natural, or sharp. 11 can be natural or sharp. 13 can be flat or natural
		-5 can only be sharp if 3 is not flat, 9 can only be sharp if 3 is flat, 11 can only be sharp if 5 is not flat
		-Pass each tone through alteration functions alterFlat, alterFlatSharp, alterSharp
		-Add each altered tone to a list stored as an instance of the Chord class (root, tones, name) */
  for (int j = 0; j < numChords; j++) {
    //This bool is used is used to handle a special case for the diminished 7th chord
    bool chordComplete = false;
    //First chord is always I
    if (firstChord == false) {
      root = Random().nextInt(12);
    }
    firstChord = false;
    bool frozen = false;
    List<int> tones = [];
    //Used for generating diminished 7ths
    var rndBool = Random().nextInt(2) == 1;

    //Handle 1, 3, 5, 7
    for (int i = 0; i < baseChord.length; i++) {
      int tone = baseChord[i];
      int alteredTone = 0;
      // if (frozenChords[i] != null) {
      //   frozen = true;
      // }
      //Third
      if (i == 1) {
        alteredTone = alterFlat(tone);
      }
      //Fifth
      else if (i == 2) {
        //Check if 3 is flat. If yes, only flat is possible for 5
        if (tones[1] == 0) {
          alteredTone = alterFlat(tone);
        } else {
          alteredTone = alterFlatSharp(tone);
        }
      }
      //Seventh
      else if (i == 3) {
        //Check if 5 is flat. If yes, 7 can go double-flat. Double-flat is a special case that doesn't allow extensions
        if (tones[2] == 0) {
          //Double-flat if rndBool, then returns the special case. Otherwise, flat
          if (rndBool) {
            alteredTone = doubleFlat(tone);
            tones[1] = 0;
            chordComplete = true;
          } else {
            alteredTone = alterFlat(tone);
          }
        } else {
          alteredTone = alterFlat(tone);
        }
      } else {
        alteredTone = tone;
      }
      tones.add(alteredTone);
    }

    if (frozen == true) {
    }
    //Handle 9, 11, 13
    else if (extend == true && chordComplete == false) {
      for (int i = 0; i < extensions.length; i++) {
        int alteredTone;
        int tone = extensions[i];
        //Ninth
        if (i == 0) {
          //Check if 3 is flat. If yes, only flat is possible for 9
          if (tones[1] == 0) {
            alteredTone = alterFlat(tone);
          } else {
            alteredTone = alterFlatSharp(tone);
          }
        }
        //Eleventh
        else if (i == 1) {
          //Check if 5 is flat. If yes, no alteration is made to 11
          if (tones[2] == 0) {
            alteredTone = tone;
          } else {
            alteredTone = alterSharp(tone);
          }
        }
        //Thirteenth
        else if (i == 2) {
          alteredTone = alterFlat(tone);
        } else {
          alteredTone = tone;
        }
        tones.add(alteredTone);
      }
    }
    //Name chord, add to list

    // if (frozen == true) {
    //   chords.add(frozenChords[j]);
    // } else {
    List<String> alteredExtensions = nameExtensions(tones.sublist(4));
    String name = nameChord(root, tones, chordComplete);
    for (int i = 0; i < alteredExtensions.length; i++) {
      name += alteredExtensions[i];
    }
    Chord chord = Chord(root, tones, name, alteredExtensions);
    chords.add(chord);
    // }
  }
  chords.shuffle();
  return chords;
}

List<int> generateScale(int amount, List<int> scale) {
  //Generates a scale based on amount of notes and specified notes, if applicable
  //Root is always 0
  //Amount is between 5 and 8. I choose 8 because any more than that is basically chromatic
  //Start by generating the 3 and the 7. This will create a 7th chord without a 5th
  //Past this point, generate extensions in random order (5, 9, 11, 13). 5 counts as an extension
  //Fill in the rest of the notes randomly
  List<int> naturals = [4, 11, 2, 5, 7, 9];
  List<int> notesPool = List<int>.generate(12, (int index) => index);
  List<int> scaleNotes = [0];

  for (int i = 1; i < amount; i++) {
    int alteredNote = 0;
    List<int> usedIndexes;
    var indexList = List<int>.generate(amount, (int index) => index);
    indexList.remove(0);
    if (i == 1) {
      //3rd
      alteredNote = alterFlat(naturals[0]);
      indexList.remove(1);
    } else if (i == 2) {
      //7th
      alteredNote = alterFlatSharp(naturals[1]);
      indexList.remove(2);
    } else {
      //Choose a random index from the list, handle the note, then remove the index from the list
      int index = Random().nextInt(indexList.length);
      switch (indexList[index]) {
        case 3:
          alteredNote = alterFlat(naturals[2]);
          notesPool.remove(alteredNote);
          break;
        case 4:
          alteredNote = alterSharp(naturals[3]);
          notesPool.remove(alteredNote);
          break;
        case 5:
          alteredNote = alterFlat(naturals[4]);
          notesPool.remove(alteredNote);
          break;
        case 6:
          alteredNote = alterFlatSharp(naturals[5]);
          notesPool.remove(alteredNote);
          break;
        case 7:
          alteredNote = notesPool[Random().nextInt(notesPool.length)];
          break;
      }
    }
    scaleNotes.add(alteredNote);
  }
  return scaleNotes;
}

int alterFlat(int tone) {
  //returns tone that is flat or natural (decreased by random integer 0 or 1)
  int i = Random().nextInt(2);
  return tone - i;
}

int alterFlatSharp(int tone) {
  //returns tone that is flat, natural, or sharp (decreased by 1, increased by 1, or not changed)
  tone += 1;
  int i = Random().nextInt(3);
  return tone - i;
}

int alterSharp(int tone) {
  //returns tone that is sharp or natural (increased by random integer 0 or 1)
  int i = Random().nextInt(2);
  return tone + i;
}

int doubleFlat(int tone) {
  //returns tone that is sharp or natural (increased by random integer 0 or 1)
  return tone - 2;
}

String nameChord(int root, List<int> tones, bool specialCase) {
  /* Name the chord based on on the root and the quality of 3 and 5(major, minor, diminished, augmented)
  Returns chord name based on root and quality of 3 and 5.
  Major: 1,3,5.Minor: 1,b3,5.Diminished: 1,b3,b5.Augmented: 1,3,#5
  In this program the chord is notated as roman numerals(name in chord class). Lowercase for b3, uppercase for natural 3.
  Major: I, Minor: i, Diminished: i°, Augmented: I+
  If 3 is natural, 5 is natural, the chord is major. 
  If 3 is flat, 5 is natural, the chord is minor.
  If 3 is flat, 5 is flat, the chord is diminished.
  If 3 is natural, 5 is sharp, the chord is augmented. */
  String name = "";
  List<int> naturals = [0, 2, 4, 5, 7, 9, 11];
  List<int> flats = [1, 3, 8, 10];
  List<int> sharps = [6];
  //Adds flat or sharp prefix to the root
  if (flats.contains(root)) {
    name = "♭";
  } else if (sharps.contains(root)) {
    name = "#";
  }
  //Determines the roman numeral of the chord
  //Roman numeral math
  print("root: $root");
  switch (root) {
    case 0:
      root = 1;
    case 1:
      root = 2;
    case 2:
      root = 2;
    case 3:
      root = 3;
    case 4:
      root = 3;
    case 5:
      root = 4;
    case 6:
      root = 4;
    case 7:
      root = 5;
    case 8:
      root = 6;
    case 9:
      root = 6;
    case 10:
      root = 7;
    case 11:
      root = 7;
  }
  List<String> romanNumerals = ["I", "II", "III", "IV", "V", "VI", "VII"];
  name += romanNumerals[root - 1];

  //Check for dim7 special case
  if (specialCase == true) {
    name = name.toLowerCase();
    name += "°";
    name += "7";
    return name;
  }
  //Determines the base triad quality
  // if (tones[1] == 0 && tones[2] == 0)
  // {
  //   //diminished, only if triad
  //   if (tones.length == 3)
  //   {
  //     name = name.toLowerCase();
  //     name += "°";
  //   }

  // }
  else if (tones[1] == 0) {
    //minor
    name = name.toLowerCase();
  }
  // else if (tones[1] == 1 && tones[2] == 2)
  // {
  //   //augmented, only done if chord is a triad
  //   if (tones.length == 3)
  //   {
  //     name += "+";
  //   }
  // }
  /* Add extensions to the chord based on the altered tones 7, 9, 11, 13.
  Add the highest unaltered extension number to the chord name.
  If the highest extension is altered, add the next highest unaltered extension number to the chord name.
  Names the 7th. Flat 7 adds 7, while natural 7 adds "maj7" to the end */
  switch (tones[3]) {
    case 1:
      name += "Maj7";
      //Handles altered 5ths
      if (tones[2] == 2) {
        name += "#5";
      }
    case 0:
      name += "7";
      //Handles altered 5ths
      if (tones[2] == 2) {
        name += "#5";
      } else if (tones[2] == 0) {
        name += "♭5";
      }
    default:
  }

  return name;
}

List<String> nameExtensions(List extensions) {
  List<String> names = [];
  if (extensions == [1, 1, 1]) {
    return names;
  }
  for (int i = 0; i < extensions.length; i++) {
    switch (i) {
      //ninth
      case 0:
        switch (extensions[i]) {
          case 0:
            names.add(" (♭9 ");
          case 1:
            names.add(" (");
          case 2:
            names.add(" (#9 ");
        }
      //eleventh
      case 1:
        switch (extensions[i]) {
          case 1:
            names.add("");
          case 2:
            names.add("#11 ");
        }
      //thirteenth
      case 2:
        switch (extensions[i]) {
          case 0:
            names.add("♭13)");
          case 1:
            names.add(")");
        }
    }
  }
  return names;
}
