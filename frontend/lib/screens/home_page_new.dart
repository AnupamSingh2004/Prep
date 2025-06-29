import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../widgets/main_layout.dart';

class HomePage extends StatelessWidget {
  final User user;

  const HomePage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainLayoutController(user: user);
  }
}
