import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/constants/constants.dart';

class list_widget extends StatefulWidget {
  list_widget(
      {this.text = 'please update the value',
      required this.store,
      required this.task,
      this.ischecked = false});

  final String text;
  var task;
  final FirebaseFirestore store;
  bool ischecked;

  @override
  State<list_widget> createState() => _list_widgetState();
}

class _list_widgetState extends State<list_widget> {
  String text = '';
  late FirebaseFirestore store;
  var task;
  bool ischecked = false;
  @override
  void initState() {
    text = widget.text;
    store = widget.store;
    task = widget.task;
    ischecked = widget.ischecked;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Material(
        elevation: 10.0,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        child: Row(
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  ischecked = !ischecked;
                });
              },
              child: Container(
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ischecked
                      ? Icon(
                          Icons.check,
                          size: 30.0,
                          color: Colors.black,
                        )
                      : Icon(
                          Icons.radio_button_unchecked,
                          size: 30.0,
                          color: Colors.black,
                        ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 3),
                child: TextField(
                  enabled: text == 'please update the value',
                  readOnly: !(text == 'please update the value'),
                  showCursor: text == 'please update the value',
                  decoration: inputdecoration.copyWith(hintText: text),
                  onChanged: (value) {
                    text = value;
                  },
                  onSubmitted: (value) async {
                    setState(() {});
                    var id = task.reference.id;
                    await store
                        .collection('tasks')
                        .doc(id)
                        .update({'task': text});
                  },
                ),
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.edit_outlined,
                size: 40,
              ),
              onPressed: () async {
                setState(() {
                  text = 'please update the value';
                });
              },
            ),
            SizedBox(
              width: 20,
            ),
            IconButton(
              icon: Icon(
                Icons.delete_outline_rounded,
                size: 40,
              ),
              onPressed: () async {
                var id = task.reference.id;
                await store.collection('tasks').doc(id).delete();
              },
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
      ),
    );
  }
}
