import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'dart:math' as math;

class CompassScreen extends StatefulWidget {
  const CompassScreen({super.key});

  @override
  State<CompassScreen> createState() => _CompassScreenState();
}

class _CompassScreenState extends State<CompassScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Compass')),
      body: StreamBuilder<CompassEvent>(
        stream: FlutterCompass.events,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          double? direction = snapshot.data!.heading;
          if (direction == null) {
            return const Center(child: Text('Compass not available'));
          }

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Transform.rotate(
                  angle: (direction * (math.pi / 180) * -1),
                  child: Container(
                    width: 250,
                    height: 250,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Theme.of(context).colorScheme.primary, width: 4),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        const Positioned(top: 20, child: Text('N', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
                        const Positioned(bottom: 20, child: Text('S', style: TextStyle(fontSize: 24))),
                        const Positioned(left: 20, child: Text('W', style: TextStyle(fontSize: 24))),
                        const Positioned(right: 20, child: Text('E', style: TextStyle(fontSize: 24))),
                        Container(
                          width: 4,
                          height: 100,
                          color: Colors.red,
                          alignment: Alignment.topCenter,
                          child: Container(width: 4, height: 20, color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Text(
                  '${direction.toStringAsFixed(0)}°',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                Text(
                  _getDirectionName(direction),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  String _getDirectionName(double degrees) {
    if (degrees >= 337.5 || degrees < 22.5) return 'North';
    if (degrees >= 22.5 && degrees < 67.5) return 'Northeast';
    if (degrees >= 67.5 && degrees < 112.5) return 'East';
    if (degrees >= 112.5 && degrees < 157.5) return 'Southeast';
    if (degrees >= 157.5 && degrees < 202.5) return 'South';
    if (degrees >= 202.5 && degrees < 247.5) return 'Southwest';
    if (degrees >= 247.5 && degrees < 292.5) return 'West';
    if (degrees >= 292.5 && degrees < 337.5) return 'Northwest';
    return '';
  }
}
