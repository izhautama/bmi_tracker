import 'package:flutter/material.dart';

class BMIResultPage extends StatelessWidget {
  final double height;
  final double weight;
  final int age;
  final String gender;
  final bool isDarkMode;
  final Function toggleTheme;

  BMIResultPage({
    required this.height,
    required this.weight,
    required this.age,
    required this.gender,
    required this.isDarkMode,
    required this.toggleTheme,
  });

  @override
  Widget build(BuildContext context) {
    double bmi = weight / ((height / 100) * (height / 100));
    String bmiCategory = _bmiCategory(bmi);
    Color bmiColor = _bmiColor(bmi);
    

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hasil BMI'),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Gambar avatar gender
              CircleAvatar(
                backgroundImage: gender == 'Laki-laki'
                    ? AssetImage('assets/male.png')
                    : AssetImage('assets/female.png'),
                radius: 50,
              ),
              const SizedBox(height: 20),
              
              // BMI Info
              Text(
                'BMI untuk $gender',
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                'Berat Ideal',
                style: TextStyle(fontSize: 22, color: Colors.redAccent, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                'Tinggi (cm): $height   Berat (kg): $weight',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              
              // Slider BMI dengan indikator
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 10,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.green, Colors.yellow, Colors.orange, Colors.red],
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Positioned(
                    left: bmiPosition(bmi),
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black,
                      ),
                      child: Center(
                        child: Text(
                          bmi.toStringAsFixed(1),
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                'Pastikan asupan kalori sesuai dengan kebutuhan kalori harian & konsumsi makanan sehat',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
              const SizedBox(height: 20),
              
              // Tombol Cek Ulang
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Cek Ulang',
                  style: TextStyle(color: Colors.redAccent),
                ),
              ),
              const SizedBox(height: 20),
              
              // Container Hasil BMI (warna dinamis)
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: isDarkMode ? Colors.black : Colors.grey[200], // Ubah warna berdasarkan mode
                ),
                child: Column(
                  children: [
                    Text(
                      'BMI kamu: ${bmi.toStringAsFixed(1)}, $bmiCategory',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: bmiColor),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Diet yang baik dapat mempertahankan kesehatan & imun',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 20),
                   
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _bmiCategory(double bmi) {
    if (bmi < 18.5) {
      return 'Kurus';
    } else if (bmi >= 18.5 && bmi < 24.9) {
      return 'Berat Ideal';
    } else if (bmi >= 25 && bmi < 29.9) {
      return 'Gemuk';
    } else {
      return 'Obesitas';
    }
  }

  Color _bmiColor(double bmi) {
    if (bmi < 18.5) {
      return Colors.orange;
    } else if (bmi >= 18.5 && bmi < 24.9) {
      return Colors.green;
    } else if (bmi >= 25 && bmi < 29.9) {
      return Colors.yellow;
    } else {
      return Colors.red;
    }
  }

  double bmiPosition(double bmi) {
    if (bmi <= 18.5) return 0;
    if (bmi > 18.5 && bmi <= 24.9) return 75;
    if (bmi > 24.9 && bmi <= 29.9) return 150;
    return 225;
  }

  double _calculateIdealWeight(double height, String gender, int age) {
    double idealWeight;
    if (gender == "Laki-laki") {
      idealWeight = 50 + 0.9 * (height - 152.4);
    } else {
      idealWeight = 45.5 + 0.9 * (height - 152.4);
    }

    if (age > 40) {
      idealWeight += idealWeight * 0.1; // Modifikasi usia (tambah 10% untuk usia di atas 40 tahun)
    }

    return idealWeight;
  }
}
