import 'package:flutter/material.dart';
import 'screens/event_list_screen.dart';
import 'student_auth_screen/student_auth_screen.dart';

void main() => runApp(const EventApp());

class EventApp extends StatefulWidget {
  const EventApp({super.key});

  @override
  State<EventApp> createState() => _EventAppState();
}

class _EventAppState extends State<EventApp> {
  bool isLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Campus Events',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.deepPurple, useMaterial3: true),
      home: isLoggedIn
          ? const EventListScreen()
          : StudentAuthScreen(
              onLoginSuccess: () {
                setState(() {
                  isLoggedIn = true;
                });
              },
            ),
    );
  }
}