import 'package:flutter/material.dart';
import 'input.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = false;

  void toggleTheme(bool value) {
    setState(() {
      isDarkMode = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Tracker',
      theme: ThemeData(
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: MyHomePage(
        isDarkMode: isDarkMode,
        toggleTheme: toggleTheme,
      ),
      routes: {
        '/input': (context) => BMIInputPage(isDarkMode: isDarkMode, toggleTheme: toggleTheme),
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  final bool isDarkMode;
  final Function toggleTheme;

  const MyHomePage({super.key, required this.isDarkMode, required this.toggleTheme});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Tracker'),
        backgroundColor: isDarkMode ? Colors.black : Colors.blueAccent,
        actions: [
          Switch(
            value: isDarkMode,
            onChanged: (value) {
              toggleTheme(value);
            },
            activeColor: Colors.white,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Selamat Datang di BMI Tracker!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Pantau kesehatanmu dengan menghitung BMI berdasarkan tinggi dan berat badanmu.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/input');
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                backgroundColor: isDarkMode ? Colors.black : Colors.blueAccent,
              ),
              child: const Text(
                'Mulai Hitung BMI',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
