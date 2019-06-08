import 'package:flutter/material.dart';
import 'package:carrabas_app/routes_spec.dart';

void main() => runApp(MyApp());

const String _appBarTitle = "Carabas Scoring";

const double _meepleImageHeight = 80.0;

final RouteObserver<Route> routeObserver = RouteObserver<Route>();

List _crewImages = [ "nonocrew.png", "redcrew.png", "yellowcrew.png", "greencrew.png" , "bluecrew.png", "purplecrew.png" ];
List _gemImages = [ "nonogem.png", "purplegem.png", "redgem.png", "greengem.png" ]; //, "cleargem.png" ];
List _gemValues = [ 0, 100, 50, 10, 1 ];

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _appBarTitle,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: MyHomePage(title: _appBarTitle),
      routes: {
        homePage: (context) => MyHomePage(),
//        studyPage: (context) => StudyPage(_radioChoice, _services[_radioChoice]),

      },
      navigatorObservers: [ routeObserver ],

    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int _crew1Index = 1;
  int _crew2Index = 0;
  int _crew3Index = 0;
  int _crew4Index = 0;
  int _gem11Index = 1;
  int _gem12Index = 0;
  int _gem13Index = 0;
  int _gem14Index = 0;
  int _gem21Index = 2;
  int _gem22Index = 0;
  int _gem23Index = 0;
  int _gem24Index = 0;
  String _row1scoreStr = "";
  String _row2scoreStr = "";
  String _row3scoreStr = "";
  String _row4scoreStr = "";

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  int evalCrewCount(int crewIndex) {
    if (crewIndex > 0) return 1;
    return 0;
  }

  void _updateScores() {
    if (_crew2Index == 0) {
      _gem12Index = 0;
      _gem22Index = 0;
    }
    if (_crew3Index == 0) {
      _gem13Index = 0;
      _gem23Index = 0;
    }
    if (_crew4Index == 0) {
      _gem14Index = 0;
      _gem24Index = 0;
    }
    int totalscore =
        _gemValues[_gem11Index] + _gemValues[_gem12Index] + _gemValues[_gem13Index] + _gemValues[_gem14Index] +
            _gemValues[_gem21Index] + _gemValues[_gem22Index] + _gemValues[_gem23Index] + _gemValues[_gem24Index];
    // number of shares. assume captain gets double share
    int crewCount = 2 + evalCrewCount(_crew2Index) + evalCrewCount(_crew3Index) + evalCrewCount(_crew4Index);
    int payout = (totalscore / crewCount).floor();
    int captainExtra = totalscore - (payout * crewCount);
    _row1scoreStr = (captainExtra + (2 * payout)).toString();
    if (_crew2Index > 0) {
      _row2scoreStr = payout.toString();
    } else {
      _row2scoreStr = "";
    }
    if (_crew3Index > 0) {
      _row3scoreStr = payout.toString();
    } else {
      _row3scoreStr = "";
    }
    if (_crew4Index > 0) {
      _row4scoreStr = payout.toString();
    } else {
      _row4scoreStr = "";
    }
  }

  @override
  Widget build(BuildContext context) {

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        children: <Widget>[
          Column (
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  'Crew Members',
                ),
                RaisedButton (
                  child: Container(
                    child: Image.asset(_crewImages[_crew1Index], height: _meepleImageHeight,),

                  ),
                  onPressed: () {
                    setState(() {
                      _crew1Index = ++_crew1Index % _crewImages.length;
                      if (_crew1Index == 0) _crew1Index++;
                      _updateScores();
                    });
                  }),
                RaisedButton (
                    child: Container(
                      child: Image.asset(_crewImages[_crew2Index], height: _meepleImageHeight,),

                    ),
                    onPressed: () {
                      setState(() {
                        _crew2Index = ++_crew2Index % _crewImages.length;
                        _updateScores();
                      });
                    }),
                RaisedButton (
                    child: Container(
                      child: Image.asset(_crewImages[_crew3Index], height: _meepleImageHeight,),

                    ),
                    onPressed: () {
                      setState(() {
                        _crew3Index = ++_crew3Index % _crewImages.length;
                        _updateScores();
                      });
                    }),
                RaisedButton (
                    child: Container(
                      child: Image.asset(_crewImages[_crew4Index], height: _meepleImageHeight,),

                    ),
                    onPressed: () {
                      setState(() {
                        _crew4Index = ++_crew4Index % _crewImages.length;
                        _updateScores();
                      });
                    }),
              ]
          ),
          Column (
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  'Gems',
                ),
                RaisedButton (
                    child: Container(
                      child: Image.asset(_gemImages[_gem11Index], height: _meepleImageHeight,),

                    ),
                    onPressed: () {
                      setState(() {
                        _gem11Index = ++_gem11Index % _gemImages.length;
                        _updateScores();
                      });
                    }),
                RaisedButton (
                    child: Container(
                      child: Image.asset(_gemImages[_gem12Index], height: _meepleImageHeight,),

                    ),
                    onPressed: () {
                      setState(() {
                        _gem12Index = ++_gem12Index % _gemImages.length;
                        _updateScores();
                      });
                    }),
                RaisedButton (
                    child: Container(
                      child: Image.asset(_gemImages[_gem13Index], height: _meepleImageHeight,),

                    ),
                    onPressed: () {
                      setState(() {
                        _gem13Index = ++_gem13Index % _gemImages.length;
                        _updateScores();
                      });
                    }),
                RaisedButton (
                    child: Container(
                      child: Image.asset(_gemImages[_gem14Index], height: _meepleImageHeight,),

                    ),
                    onPressed: () {
                      setState(() {
                        _gem14Index = ++_gem14Index % _gemImages.length;
                        _updateScores();
                      });
                    }),
              ]
          ),
          Column (
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  'More Gems',
                ),
                RaisedButton (
                    child: Container(
                      child: Image.asset(_gemImages[_gem21Index], height: _meepleImageHeight,),

                    ),
                    onPressed: () {
                      setState(() {
                        _gem21Index = ++_gem21Index % _gemImages.length;
                        _updateScores();
                      });
                    }),
                RaisedButton (
                    child: Container(
                      child: Image.asset(_gemImages[_gem22Index], height: _meepleImageHeight,),

                    ),
                    onPressed: () {
                      setState(() {
                        _gem22Index = ++_gem22Index % _gemImages.length;
                        _updateScores();
                      });
                    }),
                RaisedButton (
                    child: Container(
                      child: Image.asset(_gemImages[_gem23Index], height: _meepleImageHeight,),

                    ),
                    onPressed: () {
                      setState(() {
                        _gem23Index = ++_gem23Index % _gemImages.length;
                        _updateScores();
                      });
                    }),
                RaisedButton (
                    child: Container(
                      child: Image.asset(_gemImages[_gem24Index], height: _meepleImageHeight,),

                    ),
                    onPressed: () {
                      setState(() {
                        _gem24Index = ++_gem24Index % _gemImages.length;
                        _updateScores();
                      });
                    }),
              ]
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                'Score',
              ),
              Text(
                '$_row1scoreStr',
                style: Theme.of(context).textTheme.display1,
              ),
              Text(
                '$_row2scoreStr',
                style: Theme.of(context).textTheme.display1,
              ),
              Text(
                '$_row3scoreStr',
                style: Theme.of(context).textTheme.display1,
              ),
              Text(
                '$_row4scoreStr',
                style: Theme.of(context).textTheme.display1,
              ),
            ],
        ),
      ]),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
