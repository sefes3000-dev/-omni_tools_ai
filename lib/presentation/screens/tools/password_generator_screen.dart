import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';

class PasswordGeneratorScreen extends StatefulWidget {
  const PasswordGeneratorScreen({super.key});

  @override
  State<PasswordGeneratorScreen> createState() => _PasswordGeneratorScreenState();
}

class _PasswordGeneratorScreenState extends State<PasswordGeneratorScreen> {
  String _password = '';
  double _length = 16;
  bool _includeUppercase = true;
  bool _includeLowercase = true;
  bool _includeNumbers = true;
  bool _includeSymbols = true;

  void _generatePassword() {
    const uppercase = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    const lowercase = 'abcdefghijklmnopqrstuvwxyz';
    const numbers = '0123456789';
    const symbols = '!@#\$%^&*()_+-=[]{}|;:,.<>?';

    String chars = '';
    if (_includeUppercase) chars += uppercase;
    if (_includeLowercase) chars += lowercase;
    if (_includeNumbers) chars += numbers;
    if (_includeSymbols) chars += symbols;

    if (chars.isEmpty) return;

    final random = Random();
    setState(() {
      _password = List.generate(_length.toInt(), (index) => chars[random.nextInt(chars.length)]).join();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Password Generator')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _password.isEmpty ? 'Tap generate to create password' : _password,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontFamily: 'monospace',
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                  if (_password.isNotEmpty)
                    IconButton(
                      icon: const Icon(Icons.copy),
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: _password));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Password copied to clipboard')),
                        );
                      },
                    ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Length:'),
                Text(_length.toInt().toString()),
              ],
            ),
            Slider(
              value: _length,
              min: 4,
              max: 64,
              divisions: 60,
              onChanged: (value) => setState(() => _length = value),
            ),
            SwitchListTile(
              title: const Text('Uppercase (A-Z)'),
              value: _includeUppercase,
              onChanged: (value) => setState(() => _includeUppercase = value),
            ),
            SwitchListTile(
              title: const Text('Lowercase (a-z)'),
              value: _includeLowercase,
              onChanged: (value) => setState(() => _includeLowercase = value),
            ),
            SwitchListTile(
              title: const Text('Numbers (0-9)'),
              value: _includeNumbers,
              onChanged: (value) => setState(() => _includeNumbers = value),
            ),
            SwitchListTile(
              title: const Text('Symbols (!@#\$%)'),
              value: _includeSymbols,
              onChanged: (value) => setState(() => _includeSymbols = value),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _generatePassword,
                child: const Text('Generate Password'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
