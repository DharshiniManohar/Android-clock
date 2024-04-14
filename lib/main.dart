import 'package:flutter/material.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';
import 'dart:async'; 

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isDarkMode = false;
  Stopwatch _stopwatch = Stopwatch();
  String _stopwatchText = '00:00:00';
  Timer? _timer; 

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  void _startStopwatch() {
    setState(() {
      _stopwatch.start();
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        if (_stopwatch.isRunning) {
          _updateStopwatchText();
        } else {
          timer.cancel(); 
        }
      });
    });
  }

  void _stopStopwatch() {
    setState(() {
      _stopwatch.stop();
      _timer?.cancel(); 
      _updateStopwatchText();
    });
  }

  void _resetStopwatch() {
    setState(() {
      _stopwatch.reset();
      _updateStopwatchText();
    });
  }

  void _updateStopwatchText() {
    setState(() {
      _stopwatchText = _stopwatch.elapsed.inHours.toString().padLeft(2, '0') +
          ':' +
          (_stopwatch.elapsed.inMinutes % 60).toString().padLeft(2, '0') +
          ':' +
          (_stopwatch.elapsed.inSeconds % 60).toString().padLeft(2, '0');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: const Text("DIGITAL CLOCK"),
        titleTextStyle: TextStyle(
          color: Color.fromRGBO(240, 234, 230, 0.8),
          fontSize: 30,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(_isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: _toggleTheme,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(60),
            child: Text(
              "The current time",
              style: TextStyle(
                fontSize: 35,
                color: _isDarkMode ? Colors.white : Colors.black,
              ),
            ),
          ),
          DigitalClock(
            is24HourTimeFormat: false,
            hourMinuteDigitTextStyle: TextStyle(
              fontSize: 70,
              color: _isDarkMode ? Colors.white : Colors.black,
            ),
            secondDigitTextStyle: TextStyle(
              fontSize: 40,
              color: _isDarkMode ? Colors.white : Colors.black,
            ),
            colon: Text(
              ":",
              style: TextStyle(
                fontSize: 30,
                color: _isDarkMode ? Colors.white : Colors.black,
              ),
            ),
          ),
          SizedBox(height: 20),
          Text(
            _stopwatchText,
            style: TextStyle(
              fontSize: 40,
              color: _isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _startStopwatch,
                child: Text('Start'),
              ),
              SizedBox(width: 20),
              ElevatedButton(
                onPressed: _stopStopwatch,
                child: Text('Stop'),
              ),
              SizedBox(width: 20),
              ElevatedButton(
                onPressed: _resetStopwatch,
                child: Text('Reset'),
              ),
            ],
          ),
        ],
      ),
      backgroundColor: _isDarkMode ? Colors.black : Colors.white,
    );
  }
}
