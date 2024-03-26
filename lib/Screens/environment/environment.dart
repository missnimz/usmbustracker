import 'package:flutter/material.dart';
import 'dart:math';

class Environment extends StatefulWidget {
  const Environment({Key? key}) : super(key: key);

  @override
  _EnvironmentState createState() => _EnvironmentState();
}

class _EnvironmentState extends State<Environment> {
  // Mock data for demonstration
  final double temperature = 25; // Example temperature
  final double gasLevel = 5; // Example gas level
  final double humidity = 70; // Example humidity level

  String getTemperatureRange(double temp) {
    if (temp <= 10) return 'Very Cold';
    if (temp <= 20) return 'Cold';
    if (temp <= 29) return 'Good';
    if (temp <= 35) return 'Hot';
    return 'Very Hot';
  }

  @override
  Widget build(BuildContext context) {
    String tempRange = getTemperatureRange(temperature);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Weather",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
          ),
        ),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(0.0), // Adjust padding as needed
        child: Container(
          color: Colors.purple.shade50, // Container with purple shade 50
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Updated Current Location with icon
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.location_on, color: Colors.purple),
                    SizedBox(width: 8),
                    Text('Current Location: TBD', style: TextStyle(fontSize: 20)),
                  ],
                ),
                SizedBox(height: 20),
                // Temperature Display
                Container(
                  width: 200,
                  height: 100,
                  child: CustomPaint(
                    painter: TemperatureIndicatorPainter(temperature),
                  ),
                ),
                Text('Temperature: $temperature°C', style: TextStyle(fontSize: 24)),
                Text('Condition: $tempRange', style: TextStyle(fontSize: 24)),
                SizedBox(height: 20),
                // Rectangles for Gas and Humidity
                buildEnvironmentalDataCard('Gas Level', gasLevel.toString(), Colors.orange),
                buildEnvironmentalDataCard('Humidity', '$humidity%', Colors.blue),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildEnvironmentalDataCard(String title, String value, Color color) {
    return Card(
      margin: EdgeInsets.all(8),
      child: ListTile(
        title: Text(title),
        subtitle: Text(value),
        trailing: Icon(Icons.sensor_window, color: color),
      ),
    );
  }
}

class TemperatureIndicatorPainter extends CustomPainter {
  final double temperature;

  TemperatureIndicatorPainter(this.temperature);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height);
    final radius = size.width / 2;

    // Function to draw filled arc for each temperature zone
    void drawFilledArc(double startAngle, double sweepAngle, Color color) {
      final paint = Paint()
        ..style = PaintingStyle.fill // Changed to fill the arc
        ..color = color;
      canvas.drawArc(Rect.fromCircle(center: center, radius: radius),
          startAngle, sweepAngle, true, paint);
    }

    // Draw filled arcs for each temperature zone
    drawFilledArc(pi, pi * 0.25, Colors.blue); // Cold to Comfortable
    drawFilledArc(pi * 1.25, pi * 0.25, Colors.green); // Comfortable to Good
    drawFilledArc(pi * 1.5, pi * 0.25, Colors.orange); // Good to Hot
    drawFilledArc(pi * 1.75, pi * 0.25, Colors.red); // Hot to Very Hot

    // Calculate needle angle
    double tempFraction = (temperature - 0) / (40 - 0); // Assuming max temp is 40 for simplicity
    double angle = pi + (pi * tempFraction);
    final needlePaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2;
    final needleEnd = center + Offset(cos(angle) * radius, sin(angle) * radius);
    canvas.drawLine(center, needleEnd, needlePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
