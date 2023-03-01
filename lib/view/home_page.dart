import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  String computeListOfTimestamps(int count) {
    StringBuffer sb = StringBuffer();
    for (int i = 0; i < count; i++) {
      sb.writeln('${i + 1}:${DateTime.now()}');
    }
    return sb.toString();
  }

  Future<String> createFuturecal(int count) {
    return Future(() {
      return computeListOfTimestamps(count);
    });
  }

  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  bool showCal = false;

  void onInvokeFuturePressed() {
    setState(() {
      showCal = !showCal;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget child = showCal
        ? FutureBuilder(
            future: widget.createFuturecal(10000),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return Expanded(
                  child: SingleChildScrollView(
                      child: Text(
                          '${snapshot.data == null ? '' : snapshot.data}',
                          style: const TextStyle(fontSize: 20))));
            })
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Center(
                child: CircularProgressIndicator(),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Hit the button to show calculation'),
              )
            ],
          );
    return Scaffold(
      appBar: AppBar(title: const Text('Grid View App')),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[child]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onInvokeFuturePressed,
        tooltip: 'Invoke Future',
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
