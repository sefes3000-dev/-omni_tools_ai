import 'package:flutter/material.dart';
import 'package:torch_light/torch_light.dart';

class FlashlightScreen extends StatefulWidget {
  const FlashlightScreen({super.key});

  @override
  State<FlashlightScreen> createState() => _FlashlightScreenState();
}

class _FlashlightScreenState extends State<FlashlightScreen> {
  bool _isOn = false;

  Future<void> _toggleFlashlight() async {
    try {
      if (_isOn) {
        await TorchLight.disableTorch();
      } else {
        await TorchLight.enableTorch();
      }
      setState(() => _isOn = !_isOn);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not access flashlight')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flashlight')),
      body: Center(
        child: GestureDetector(
          onTap: _toggleFlashlight,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              color: _isOn ? Colors.yellow : Colors.grey[800],
              shape: BoxShape.circle,
              boxShadow: _isOn
                  ? [
                      BoxShadow(
                        color: Colors.yellow.withOpacity(0.5),
                        blurRadius: 50,
                        spreadRadius: 20,
                      ),
                    ]
                  : [],
            ),
            child: Icon(
              _isOn ? Icons.flashlight_on : Icons.flashlight_off,
              size: 80,
              color: _isOn ? Colors.white : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
