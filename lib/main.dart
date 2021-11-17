import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:rpi_center/layoutItems/home_header.dart';
import 'package:rpi_center/layoutItems/miror_effect.dart';
import 'package:rpi_center/layoutItems/roomsLine.dart';
import 'package:rpi_center/styles/font_style.dart';
import 'package:ssh/ssh.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('de');
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // supportedLocales: [const Locale('en'), const Locale('de')],
      title: 'Flutter Demo',
      theme: ThemeData(
        // Define the default brightness and colors.
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primaryColor: Colors.red,
        accentColor: Colors.white,

        // Define the default font family.
        fontFamily: 'Prompt',

        // Define the default TextTheme. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      ),
      routes: {
        '/mirrorEffect': (_) => MirrorEffect(),
      },
      home: MyHomePage(title: 'M59 WIllkommen zuhause'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isSwitchedGreen = false;
  bool isSwitchedRed = false;
  int statusRed = 0;
  int statusGreen = 0;
  int _counter = 0;

  var client = new SSHClient(
    host: "192.168.178.25",
    port: 22,
    username: "pi",
    passwordOrKey: "jues7928",
  );

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();

    (() async {
      await client.connect();
      this.statusRed = int.parse(await client.execute("gpio -g read 23"));
      this.statusGreen = int.parse(await client.execute("gpio -g read 17"));
    })();
    super.initState();
  }

  void _testLed(int pinNumber, bool state) async {
    await client.connect();
    await client.execute('gpio export ${pinNumber} out');
    await client.execute("gpio -g write ${pinNumber} ${state ? 1 : 0}");
    //await client.execute("gpio -g write ${pinNumber} ${state ? 0 : 1}");
    print(await client.execute("gpio -g read ${pinNumber}"));
    await client.disconnect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: TextButton(
        onPressed: () => {Navigator.of(context).pushNamed('/mirrorEffect')},
        child: Text('zum Spiegel'),
      ),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(31, 42, 53, 1),
        shadowColor: Colors.white60,
        elevation: 40.0,
        title: Text(
          widget.title,
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Prompt',
            shadows: <Shadow>[
              Shadow(
                offset: Offset(3.0, 3.0),
                blurRadius: 5.0,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
              Shadow(
                offset: Offset(0.0, 0.0),
                blurRadius: 5.0,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        decoration: new BoxDecoration(
            gradient: new RadialGradient(
          center: Alignment.topCenter,
          radius: 0.85,
          colors: [
            Color.fromRGBO(71, 82, 93, 1),
            Color.fromRGBO(31, 42, 53, 1),
          ],
        )),
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MainHeader(),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(
                          'Räume',
                          style: TextStyleDefault,
                        ),
                        RoomsLine(),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Grün'),
                      Switch(
                        value: isSwitchedGreen,
                        onChanged: (value) {
                          setState(() {
                            isSwitchedGreen = value;
                            _testLed(3, value);
                          });
                        },
                      ),
                      Text('Rot'),
                      Switch(
                        value: isSwitchedRed,
                        onChanged: (value) {
                          setState(() {
                            isSwitchedRed = value;
                            _testLed(2, value);
                          });
                        },
                      ),
                      SizedBox(
                        height: 300,
                        width: MediaQuery.of(context).size.width / 2,
                        child: ListWheelScrollView(
                          offAxisFraction: 0.0,
                          itemExtent: 50,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Container(
                                color: Colors.blue,
                                height: 20,
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text('text'),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Container(
                                color: Colors.blue,
                                height: 20,
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text('text'),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Container(
                                color: Colors.blue,
                                height: 20,
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text('text'),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Container(
                                color: Colors.blue,
                                height: 20,
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text('text'),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Container(
                                color: Colors.blue,
                                height: 20,
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text('text'),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Container(
                                color: Colors.blue,
                                height: 20,
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text('text'),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Container(
                                color: Colors.blue,
                                height: 20,
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text('text'),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Container(
                                color: Colors.blue,
                                height: 20,
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text('text'),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Container(
                                color: Colors.blue,
                                height: 20,
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text('text'),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Container(
                                color: Colors.blue,
                                height: 20,
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text('text'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text('${this.statusRed}'),
                      Text('${this.statusRed}'),
                      Text('${this.statusRed}'),
                      Text('${this.statusRed}'),
                      Text('${this.statusRed}'),
                      Text('${this.statusRed}'),
                      Text('${this.statusRed}'),
                      Text('${this.statusRed}'),
                      Text('${this.statusRed}'),
                      Text('${this.statusRed}'),
                      Text('${this.statusRed}'),
                      Text('${this.statusRed}'),
                      Text('${this.statusRed}'),
                      Text('${this.statusRed}'),
                      Text('${this.statusRed}'),
                      Text('${this.statusRed}'),
                      Text('${this.statusRed}'),
                      Text('${this.statusRed}'),
                      Text('${this.statusRed}'),
                      Text('${this.statusRed}'),
                      Text('${this.statusRed}'),
                      Text('${this.statusRed}'),
                      Text('${this.statusRed}'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
