import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(TestApp());

class TestApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test App',
      theme: ThemeData(
        primarySwatch: Colors.primaries[Random().nextInt(Colors.primaries.length)],
      ),
      home: RandomColor(title: 'Random Color'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class RandomColor extends StatefulWidget {
  RandomColor({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _RandomColorState createState() => _RandomColorState();
}

class _RandomColorState extends State<RandomColor> {
  Color _bgColor;
  Color _textColor;
  final Random _random = Random();

  void _setColors() {
    setState(() {
      final int r = _random.nextInt(256);
      final int g = _random.nextInt(256);
      final int b = _random.nextInt(256);
      final double brightness = r * 0.299 + g * 0.587 + b * 0.114;
      _bgColor = Color.fromARGB(255, r, g, b);
      _textColor = (brightness > 130) ? Colors.black : Colors.white;
    });
  }

  @override
  void initState() {
    super.initState();
    _setColors();
  }

  @override
  void reassemble() {
    super.reassemble();
    _setColors();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: _setColors,
        child: Center(
          child: Text(
            'Hey there',
            style: TextStyle(color: _textColor, fontSize: 18.0),
          ),
        ),
        behavior: HitTestBehavior.opaque,
      ),
      backgroundColor: _bgColor,
    );
  }
}
