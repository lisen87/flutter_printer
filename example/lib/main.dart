import 'package:flutter/material.dart';
import 'package:flutter_printer/flutter_printer.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;

      List list = [
        "http://xxxx0.png",
        "http://xxxx1.png",
        "http://xxxx2.png",
        "http://xxxx3.png"
      ];
      Map map1 = {"id": "1"};
      List list1 = [
        map1,
        map1,
      ];
      List list2 = [
        list1,
        null,
        list1,
        [map1, map1, map1, map1],
        [list1, list1, list1, [], list1]
      ];

      Map map = {
        "map": {"key1": 1, "key2": "2", "list2": []},
        "id": "1",
        "orders": null,
        "member": {
          "id": "888",
          "name": "leeson",
          "phone": null,
          "age": 88,
          "last": list
        },
        "last": list
      };


      Printer.printMapJsonLog(
        map1,
        stackTrace: StackTrace.current,
        prefix: "我是测试前缀:",
      );
      Printer.debug(
        list,
        stackTrace: StackTrace.current,
      );
      Printer.warn(
        list2,
        stackTrace: StackTrace.current,
      );
      Printer.error(
        map,
        stackTrace: StackTrace.current,
      );

//
//      ///不推荐的使用方式
//      /// Not recommended
//      Printer.printMapJsonLog("printer--> Printer.printLog"+map.toString(),stackTrace: StackTrace.current,);

      String data =
          "BuildContext\nBuildContext\nBuildContext\nBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContextBuildContext";
      // Printer.printMapJsonLog(null,stackTrace: StackTrace.current);
      // Printer.printMapJsonLog("",stackTrace: StackTrace.current);
      Printer.printMapJsonLog(data, stackTrace: StackTrace.current);

      Printer.info(data,
          stackTrace: StackTrace.current,
          prefix: "我是测试前缀:",
          xtermRgb: xtermRgb(
              Colors.white.red, Colors.white.green, Colors.white.blue));
    });
  }
  @override
  void initState() {
    super.initState();
    // Printer.config = ColorConfig(
    //   infoRgb: xtermRgb(Colors.red.red, Colors.red.green, Colors.red.blue),
    //   debugRgb: xtermRgb(Colors.orange.red, Colors.orange.green, Colors.orange.blue),
    //   warnRgb: xtermRgb(Colors.brown.red, Colors.brown.green, Colors.brown.blue),
    //   errorRgb: xtermRgb(Colors.teal.red, Colors.teal.green, Colors.teal.blue),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
