import 'package:flutter/material.dart';
import 'chord.dart';
import 'generate.dart';

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
              child: const Text('This tool generates random chord progressions. Without extensions you get 7th chords. With extensions you get 9th, 11th, and 13th chords. Chord voicings are not specified, so feel free to voice them however you like.')
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Generate'),
          backgroundColor: Colors.red,
        ),
        body: Center(
          child: SizedBox.expand(
            child: Container(
              alignment: Alignment.center,
              child: Text('Hello World'),
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(20),
            ),
          ),
        ),
        floatingActionButton: Container(
          height: 80,
          width: 150,
          child: FloatingActionButton(
            onPressed: () {
              print('Generated');
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