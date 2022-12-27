import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import '../constants/constants.dart';
import '../widgets/list_widget.dart';
import '../widgets/task _input_field.dart';
import 'package:todo/widgets/builder.dart';

class MyHomePage extends StatefulWidget {
  static String pageid = 'hompage';
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final _store = FirebaseFirestore.instance;
  void delete(FirebaseFirestore _store, var task) async {
    var id = task.reference.id;
    await _store.collection('tasks').doc(id).delete();
  }

  void update(FirebaseFirestore _store, var task) async {
    var id = task.reference.id;
    await _store.collection('tasks').doc(id).delete();
  }

  TextEditingController textcontroller = TextEditingController();

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Center(
          child: Padding(
        padding: EdgeInsets.only(top: 40),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const Text(
                'TO DO App',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 35,
                ),
              ),
              task_input_field(
                textcontroller: textcontroller,
                store: _store,
              ),
              builder(store: _store)
            ]),
      )),
    ));
  }
}
