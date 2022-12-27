import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/constants/constants.dart';
import 'list_widget.dart';

class builder extends StatelessWidget {
  const builder({
    Key? key,
    required FirebaseFirestore store,
  })  : _store = store,
        super(key: key);

  final FirebaseFirestore _store;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _store.collection('tasks').orderBy('time').snapshots(),
      builder: (context, snapshot) {
        List<Widget> text = [];
        if (snapshot.hasData) {
          var tasks = snapshot.data!.docs;
          for (var task in tasks) {
            Widget f = list_widget(
              text: task['task'],
              task: task,
              store: _store,
              ischecked: (task['enabled'] == 'true') ? true : false,
            );
            text.add(f);
          }
        }
        return Expanded(
          child: ListView(
            shrinkWrap: true,
            children: text,
          ),
        );
      },
    );
  }
}
