import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:superapi/model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String apiUrl = 'https://api.adviceslip.com/advice';
  Advice _advice;

  @override
  void initState() {
    super.initState();
    getAdvice();
  }

  void getAdvice() async {
    var response = await http.get(apiUrl);
    var body = response.body;

    var decodeJson = jsonDecode(body);

    _advice = Advice.fromJson(decodeJson);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        width: double.infinity,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Text(
                  'MY ADVICE',
                  style: GoogleFonts.sanchez(
                      fontSize: 30.0, fontWeight: FontWeight.bold),
                ),
              ),
              _advice != null
                  ? Column(
                      children: [
                        Container(
                          child: Text(
                            _advice.slip.advice,
                            style: GoogleFonts.sanchez(fontSize: 30.0),
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Row(
                          children: [
                            BottomDot(),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 10.0),
                              child: Text(
                                _advice.slip.id.toString(),
                                style: GoogleFonts.sanchez(fontSize: 20.0),
                              ),
                            ),
                            BottomDot(),
                          ],
                        )
                      ],
                    )
                  : LinearProgressIndicator(),
              GestureDetector(
                onTap: getAdvice,
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  height: MediaQuery.of(context).size.height / 14,
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: Text(
                    'New Advice',
                    style: GoogleFonts.sanchez(
                        fontSize: 20.0, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BottomDot extends StatelessWidget {
  const BottomDot({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.amber),
          ),
        ),
      ),
    );
  }
}
