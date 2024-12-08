import 'package:flutter/material.dart';
import 'result.dart';


class BMIInputPage extends StatefulWidget {
  final bool isDarkMode;
  final Function toggleTheme;

  BMIInputPage({required this.isDarkMode, required this.toggleTheme});

  @override
  _BMIInputPageState createState() => _BMIInputPageState();
}

class _BMIInputPageState extends State<BMIInputPage> {
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  final _ageController = TextEditingController();
  String gender = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Input Data BMI'),
        backgroundColor: widget.isDarkMode ? Colors.black : Colors.blueAccent,
        actions: [
          Switch(
            value: widget.isDarkMode,
            onChanged: (value) {
              widget.toggleTheme(value);
            },
            activeColor: Colors.white,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          gender = "Laki-laki";
                        });
                      },
                      child: CircleAvatar(
                        backgroundImage: AssetImage('assets/male.png'), // replace with your male avatar image path
                        radius: 40,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Laki-laki',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: gender == "Laki-laki" ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 40),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          gender = "Perempuan";
                        });
                      },
                      child: CircleAvatar(
                        backgroundImage: AssetImage('assets/female.png'), // replace with your female avatar image path
                        radius: 40,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Perempuan',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: gender == "Perempuan" ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _heightController,
              decoration: const InputDecoration(
                labelText: 'Tinggi (cm)',
                border: OutlineInputBorder(),
                hintText: 'Masukkan tinggi badan Anda',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _weightController,
              decoration: const InputDecoration(
                labelText: 'Berat (kg)',
                border: OutlineInputBorder(),
                hintText: 'Masukkan berat badan Anda',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _ageController,
              decoration: const InputDecoration(
                labelText: 'Usia',
                border: OutlineInputBorder(),
                hintText: 'Masukkan usia Anda',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final height = double.tryParse(_heightController.text) ?? 0;
                final weight = double.tryParse(_weightController.text) ?? 0;
                final age = int.tryParse(_ageController.text) ?? 0;

                if (height > 0 && weight > 0 && age > 0 && gender.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BMIResultPage(
                        height: height,
                        weight: weight,
                        age: age,
                        gender: gender,
                        isDarkMode: widget.isDarkMode,
                        toggleTheme: widget.toggleTheme,
                      ),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Harap masukkan semua data dengan valid!'),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                backgroundColor: widget.isDarkMode ? Colors.black : Colors.blueAccent,
              ),
              child: const Text(
                'Hitung BMI',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
