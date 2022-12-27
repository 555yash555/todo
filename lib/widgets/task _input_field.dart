import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/constants/constants.dart';

class task_input_field extends StatefulWidget {
  const task_input_field({
    Key? key,
    required this.textcontroller,
    required this.store,
  }) : super(key: key);
  final TextEditingController textcontroller;
  final FirebaseFirestore store;

  @override
  State<task_input_field> createState() => _task_input_fieldState();
}

class _task_input_fieldState extends State<task_input_field> {
  @override
  void initState() {
    store = widget.store;
    super.initState();
  }

  String task = '';
  TextEditingController controller = TextEditingController();
  late FirebaseFirestore store;
  bool status = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 3),
              child: Material(
                elevation: 10.0,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: TextField(
                  enabled: status,
                  controller: controller,
                  decoration:
                      inputdecoration.copyWith(hintText: 'enter something..'),
                  onChanged: (value) {
                    task = value;
                  },
                  onSubmitted: (value) {},
                ),
              ),
            ),
          ),
          Material(
            elevation: 10,
            shadowColor: Colors.black,
            borderRadius: BorderRadius.all(Radius.circular(45)),
            borderOnForeground: true,
            child: IconButton(
              iconSize: 45,
              icon: Icon(
                Icons.add_circle,
                size: 45,
              ),
              onPressed: () async {
                setState(() {
                  status = false;
                });
                await store.collection('tasks').add({
                  'task': task,
                  'time': DateTime.now().millisecondsSinceEpoch.toString(),
                  'enabled': 'false'
                });
                task = '';
                controller.clear();
                setState(() {
                  status = true;
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
