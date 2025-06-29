import 'package:flutter/material.dart';
import 'screens/login_page.dart';
import 'screens/home_page.dart';
import 'models/user_model.dart';
import 'package:first_app/screens/Home/Widgets/scheme_card.dart';
import 'package:first_app/screens/Home/Widgets/recent_search.dart';
import 'package:first_app/screens/Home/Widgets/savings_card.dart';
import 'package:first_app/screens/Home/Widgets/stats_card.dart';

void main() {
  User dummyUser = User(
    id: '001',
    email: 'demo@example.com',
    firstName: 'Demo',
    lastName: 'User',
    emailVerified: true,
    isGoogleUser: false,
  );


  runApp(MyApp(user: dummyUser));

}

class MyApp extends StatelessWidget {
  final User user;
  const MyApp({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: HomePage(user: user),
    );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("A"),
          Text("B"),
          Text("C"),
          ElevatedButton(
            onPressed: () {
              print("Hello");
            },
            child: Text("Click me"),
          ),
        ],
      ),
    );
  }
}
