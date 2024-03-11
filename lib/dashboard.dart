import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasetry/main.dart';
import 'package:flutter/material.dart';

class DashBooard extends StatefulWidget {
  const DashBooard({super.key});

  @override
  State<DashBooard> createState() => _DashBooardState();
}

class _DashBooardState extends State<DashBooard> {

  
void logout () async {
  await FirebaseAuth.instance.signOut();
  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => FirebaseHome()));
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: logout, icon: Icon(Icons.logout)),
        ],
        title: Text('Dashboard'),
      ),
    );
  }
}