import 'dart:math';

import 'package:clipboard_app/services/firebase_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Map map = {};
  String code = '';
  TextEditingController intxtCnt = TextEditingController();
  TextEditingController codetxtCnt = TextEditingController();
  TextEditingController outtxtCnt = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [
        TextField(
          controller: intxtCnt,
          decoration: const InputDecoration(
            hintText: "Enter data to Share",
            labelText: "Enter Data to Share",
          ),
        ),
        ElevatedButton(
            onPressed: () {
              if (intxtCnt.text.isNotEmpty) {
                code = generateRandom();
                // map[code] = intxtCnt.text;
                setState(() {});
                FirebaseService.addData(code, intxtCnt.text);
              } else {
                print('Invalid input');
              }
            },
            child: const Text("Send Code")),
        Text('Code $code'),
        TextField(
          controller: codetxtCnt,
          decoration: const InputDecoration(
            hintText: "Enter code to retrive data",
            labelText: "Enter code to retrive data",
          ),
        ),
        ElevatedButton(
            onPressed: () async {
              if (codetxtCnt.text.isNotEmpty) {
                outtxtCnt.text =
                    await FirebaseService.fetchData(codetxtCnt.text);
                // outtxtCnt.text = map[codetxtCnt.text];
              }
            },
            child: const Text("Retrive Code")),
        TextField(
          controller: outtxtCnt,
          enabled: false,
          decoration: const InputDecoration(
              // hintText:"Enter data to Share",
              // labelText:"Enter Data to Share",
              ),
        ),
      ]),
    ));
  }

  String generateRandom() {
    var ran = new Random();
    return (ran.nextInt(9000) + 1000).toString();
  }
}
