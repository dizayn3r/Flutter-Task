import 'package:flutter/material.dart';
import 'package:flutter_interview_task/providers/album_provider.dart';
import 'package:flutter_interview_task/providers/photo_provider.dart';
import 'package:flutter_interview_task/providers/user_provider.dart';
import 'package:flutter_interview_task/ui/screens/home/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => AlbumProvider()),
        ChangeNotifierProvider(create: (context) => PhotoProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Tasks',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
          useMaterial3: true,
          appBarTheme: const AppBarTheme(centerTitle: true),
          inputDecorationTheme: InputDecorationTheme(
            focusColor: Colors.cyan,
            alignLabelWithHint: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.0),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.0),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.0),
            ),
          ),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
