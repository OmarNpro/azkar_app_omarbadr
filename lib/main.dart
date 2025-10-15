import 'package:flutter/material.dart';

void main() {
  runApp(const AdhkarCounterApp());
}

class AdhkarCounterApp extends StatelessWidget {
  const AdhkarCounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Adhkar Counter',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        fontFamily: 'Arial',
      ),
      home: const AdhkarCounterPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Dhikr {
  final String arabic;
  final String transliteration;
  final int target;

  Dhikr({
    required this.arabic,
    required this.transliteration,
    required this.target,
  });
}

class AdhkarCounterPage extends StatefulWidget {
  const AdhkarCounterPage({super.key});

  @override
  State<AdhkarCounterPage> createState() => _AdhkarCounterPageState();
}

class _AdhkarCounterPageState extends State<AdhkarCounterPage> {
  int _counter = 0;
  int _selectedDhikrIndex = 0;

  final List<Dhikr> _adhkar = [
    Dhikr(
      arabic: 'سُبْحَانَ اللهِ',
      transliteration: 'SubhanAllah',
      target: 33,
    ),
    Dhikr(
      arabic: 'الْحَمْدُ لِلَّهِ',
      transliteration: 'Alhamdulillah',
      target: 33,
    ),
    Dhikr(
      arabic: 'اللهُ أَكْبَرُ',
      transliteration: 'Allahu Akbar',
      target: 34,
    ),
    Dhikr(
      arabic: 'لَا إِلَهَ إِلَّا اللهُ',
      transliteration: 'La ilaha illallah',
      target: 100,
    ),
    Dhikr(
      arabic: 'أَسْتَغْفِرُ اللهَ',
      transliteration: 'Astaghfirullah',
      target: 100,
    ),
  ];

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }

  void _selectDhikr(int index) {
    setState(() {
      _selectedDhikrIndex = index;
      _counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final selectedDhikr = _adhkar[_selectedDhikrIndex];
    final progress = _counter / selectedDhikr.target;
    final isComplete = _counter >= selectedDhikr.target;

    return Scaffold(
      backgroundColor: Colors.teal[50],
      appBar: AppBar(
        title: const Text('Adhkar Counter'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Dhikr Selection
          Container(
            height: 100,
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _adhkar.length,
              itemBuilder: (context, index) {
                final isSelected = index == _selectedDhikrIndex;
                return GestureDetector(
                  onTap: () => _selectDhikr(index),
                  child: Container(
                    margin: const EdgeInsets.only(right: 12),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.teal : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _adhkar[index].transliteration,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: isSelected ? Colors.white : Colors.teal,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${_adhkar[index].target}x',
                          style: TextStyle(
                            fontSize: 12,
                            color: isSelected
                                ? Colors.white70
                                : Colors.teal[300],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Arabic Text
                  Text(
                    selectedDhikr.arabic,
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),

                  // Transliteration
                  Text(
                    selectedDhikr.transliteration,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.teal[700],
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Counter Circle
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 200,
                        height: 200,
                        child: CircularProgressIndicator(
                          value: progress > 1 ? 1 : progress,
                          strokeWidth: 12,
                          backgroundColor: Colors.teal[100],
                          valueColor: AlwaysStoppedAnimation<Color>(
                            isComplete ? Colors.green : Colors.teal,
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            '$_counter',
                            style: const TextStyle(
                              fontSize: 64,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal,
                            ),
                          ),
                          Text(
                            'of ${selectedDhikr.target}',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.teal[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Complete indicator
                  if (isComplete)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: const Text(
                        '✓ Complete!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),

          // Buttons
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              children: [
                // Reset Button
                Expanded(
                  child: ElevatedButton(
                    onPressed: _resetCounter,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red[400],
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      'Reset',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),

                // Count Button
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: _incrementCounter,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      'Count',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}