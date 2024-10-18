import 'package:flutter/material.dart';
import 'package:flutter_application_1/Allmember.dart';
import 'package:flutter_application_1/favorite.dart';
import 'package:flutter_application_1/savedmember.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => FavoriteProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Favorite App',
            style: TextStyle(
              color: Colors.brown,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'All Members'),
              Tab(text: 'Saved Members'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            AllMembersTab(),
            SavedMembersTab(),
          ],
        ),
      ),
    );
  }
}
