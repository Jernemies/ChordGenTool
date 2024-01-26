import 'package:flutter/material.dart';
import 'package:flutter_spinbox/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'chord.dart';
import 'generate.dart';
import 'play.dart';
import 'dart:async';


/*
https://api.dart.dev/stable/3.2.4/dart-math/Random-class.html
https://pub.dev/packages/audioplayers
https://pub.dev/packages/midi_util */

void main() {
  runApp(const MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class AboutPage extends StatelessWidget {
  const AboutPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About Page'), backgroundColor: Colors.red,),
       body: Center(
          child: SizedBox.expand(
            child: Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(20),
              alignment: Alignment.center,
              child: const Text("This tool generates random chord progressions. Chords are expressed as 7th chords, with extensions specified separately should you want thme. \n\n Uppercase=major, lowercase=minor. \n Chord voicings are not specified, so feel free to voice them however you like. \n\n Keys are not specified at the moment, so you'll have to transpose them to any key you like.\n\n For now only altered extensions will be shown with the chord. Regular extensions are meant to be used as desired anyway, so feel free to do that :)")
            ),
          ),
        ),
    );
    
  }
}

class GeneratePage extends StatefulWidget {
  const GeneratePage({ Key? key }) : super(key: key);

  @override
  State<GeneratePage> createState() => _GeneratePageState();
}

class _GeneratePageState extends State<GeneratePage> {
  int chords = 4;
  String chordsText = 'chords';
  String extensionsText = '(9,11,13)';
  List<Chord> chordList = [];
  bool notPlaying = true;
  // List<AudioPlayer> audioPlayers = List.generate(
  //   4,
  //   (_) => AudioPlayer()..setReleaseMode(ReleaseMode.release),
  // );
  AudioPlayer audioPlayer = AudioPlayer();
  final Timer timer = Timer(const Duration(seconds: 2), () => null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Generate'),
          backgroundColor: Colors.red,
        ),
          body: Center(
          child: Column(
          children: [
            SizedBox(
              //Sointujen määrä
              height: 80,
              child: Container(
                alignment: Alignment.center,
                height: 80,
                child: SpinBox(
                min: 1,
                max: 8,
                step: 1,
                value: chords.toDouble(),
                onChanged: (value) => setState(() => chords = value.toInt()),
                decoration: const InputDecoration(labelText: 'Number of Chords'),),
              ),
            ),
            Expanded(
              //Soinnut
              child: FittedBox(
                alignment: Alignment.centerLeft,
                child: Text(chordsText.toString(), softWrap: false,),
              ),
            ),SizedBox(
              //Soitto
              height: 120,
              child: Container(
                alignment: Alignment.centerLeft,
                height: 120,
                margin: const EdgeInsets.only(left: 50),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.red,
                      width: 3,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    iconSize: 60,
                    icon: notPlaying
                    ? Icon(Icons.play_arrow)
                    : Icon(Icons.pause),
                    onPressed:() {
                      setState(() {
                        notPlaying = false;
                          for (int i = 0; i < chordList.length; i++) {
                            List<String> notes = notesToPlay(chordList[i]);
                            print(notes);
                            for (int j = 0; j < notes.length; j++) {
                              audioPlayer.play(AssetSource(notes[j]));
                              timer;
                              }
                          }
                        notPlaying = true;
                      });
                    },)),
              ),
            ),]
        ),),
        floatingActionButton: Container(
          height: 80,
          width: 150,
          child: FloatingActionButton(
            onPressed: () {
              chordList = generate(chords, true);
              chordsText = '';
              for (int i = 0; i < chords; i++) {
                  String chordName = chordList[i].name.toString();
                  chordsText += chordName + '\n';
                }
              setState(() {
                chordsText;
              });
            },
          backgroundColor: Colors.red,
          child: const Text('Generate'),
          ),
        ),
    );
    
  }
}

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  PageController _pageController = PageController();

  // static const List<Widget> _pages = <Widget>[
  //   GeneratePage(),
  //   AboutPage(),
  // ];


  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.easeOut);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          children: const <Widget>[
            GeneratePage(),
            AboutPage(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help),
            label: 'About',
            backgroundColor: Colors.red,
          ),
        ],
      )
      );
    
  }
}

Future<void> playChord(int chords, List<Chord> chordList) async {

}