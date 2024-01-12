import 'package:flutter/material.dart';

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
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class AboutPage extends StatelessWidget {
  const AboutPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('About Page'), backgroundColor: Colors.red,),
       body: Center(
          child: Container(
            child: Text('This tool generates random chord progressions. Without extensions you get 7th chords. With extensions you get 9th, 11th, and 13th chords. Chord voicings are not specified, so feel free to voice them however you like.'),
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(20),
            color: Colors.black,
            height: 100,
            width: 100,
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
          child: Container(
            child: Text('Hello World'),
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(20),
            color: Colors.black,
            height: 100,
            width: 100,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            print('Generated');
          },
          child: Text('Generate'),
          backgroundColor: Colors.red,
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
  // PageController _pageController;

  static const List<Widget> _pages = <Widget>[
    GeneratePage(),
    AboutPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      //asd
      _selectedIndex = index;
      // _pageController.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.easeOut);
    });
  }
  // @override
  // void initState() {
  //   _pageController = PageController();
  //   super.initState();
  // }
  // @override
  // void dispose() {
  //   _pageController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: _pages.elementAt(_selectedIndex),
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