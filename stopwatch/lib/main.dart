import 'dart:async';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'StopWatch',
      home: StopWatch(),
    );
  }
}
class StopWatch extends StatefulWidget {
  const StopWatch({super.key});
  @override
  State<StopWatch> createState() => _StopWatchState();
}

class _StopWatchState extends State<StopWatch> {
  final Stopwatch _stopwatch = Stopwatch();

  // Timer
  late Timer _timer;
  String _result = '00:00:00';
  void _start() {
    _timer = Timer.periodic(const Duration(milliseconds: 30), (Timer t) {

      setState(() {
        _result =
        '${_stopwatch.elapsed.inMinutes.toString().padLeft(2, '0')}:${
            (_stopwatch.elapsed.inSeconds % 60).toString().padLeft(2, '0')}:${
            (_stopwatch.elapsed.inMilliseconds % 100).toString().padLeft(2, '0')}';
      });
    });
    _stopwatch.start();
  }

  void _stop() {
    _timer.cancel();
    _stopwatch.stop();
  }
  void _reset() {
    _stop();
    _stopwatch.reset();


    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[50],
      appBar: AppBar(
        title: const Text('StopWatch', style: TextStyle(fontSize: 30, color: Colors.white)),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _result,
              style: const TextStyle(
                  fontSize: 70.0, color: Colors.black
              ),
            ),
            const SizedBox(
              height: 40.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Start button
                ElevatedButton(
                  onPressed: _start,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.cyan
                  ),
                  child: const Text('Start', style: TextStyle( fontSize: 20)),
                ),
                // Stop button
                ElevatedButton(
                  onPressed: _stop,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: const Text('Stop', style: TextStyle( fontSize: 20)),
                ),
                // Reset button
                ElevatedButton(
                  onPressed: _reset,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey,
                  ),
                  child: const Text('Reset', style: TextStyle( fontSize: 20)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}