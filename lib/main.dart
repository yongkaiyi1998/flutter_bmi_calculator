import 'package:flutter/material.dart';
import 'bmi_calculator.dart';

void main() {
  runApp(const BMICalculatorApp());
}

class BMICalculatorApp extends StatelessWidget {
  const BMICalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const BMICalculatorScreen(),
    );
  }
}

class BMICalculatorScreen extends StatefulWidget {
  const BMICalculatorScreen({super.key});

  @override
  BMICalculatorScreenState createState() => BMICalculatorScreenState();
}

class BMICalculatorScreenState extends State<BMICalculatorScreen> {
  double _weight = 70;
  double _height = 170;
  String _result = '';

  void _calculateBMI() {
    final bmiCalculator = BMICalculator();
    final bmi = bmiCalculator.calculateBMI(_weight, _height / 100);
    final category = bmiCalculator.getBMICategory(bmi);

    setState(() {
      _result = 'Your BMI is ${bmi.toStringAsFixed(1)}\n($category)';
    });
  }

  @override
  void initState() {
    super.initState();
    _calculateBMI();  // Initial calculation with default values
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Calculator'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildSliderSection('Weight (kg)', _weight, 40, 140, (value) {
              setState(() {
                _weight = value;
                _calculateBMI();
              });
            }),
            const SizedBox(height: 30),
            _buildSliderSection('Height (cm)', _height, 120, 200, (value) {
              setState(() {
                _height = value;
                _calculateBMI();
              });
            }),
            const SizedBox(height: 90),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Text(
                _result,
                style: const TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSliderSection(String label, double value, double min, double max, ValueChanged<double> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '$label: ${value.toStringAsFixed(1)}',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        Slider(
          value: value,
          min: min,
          max: max,
          divisions: (max - min).toInt(),
          label: value.toStringAsFixed(1),
          onChanged: onChanged,
          activeColor: Colors.blueAccent,
          inactiveColor: Colors.blueAccent.withOpacity(0.5),
        ),
      ],
    );
  }
}
