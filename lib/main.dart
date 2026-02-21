import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'package:shared_preferences/shared_preferences.dart'; // New
import 'dart:async';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WakelockPlus.enable();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  runApp(const MaterialApp(debugShowCheckedModeBanner: false, home: UltimateRetroClock()));
}

class UltimateRetroClock extends StatefulWidget {
  const UltimateRetroClock({super.key});
  @override
  State<UltimateRetroClock> createState() => _UltimateRetroClockState();
}

class _UltimateRetroClockState extends State<UltimateRetroClock> {
  DateTime _now = DateTime.now();
  Timer? _timer;
  bool _isDayMode = false;

  @override
  void initState() {
    super.initState();
    _loadPreference(); // Load user choice on startup
    _startTimer();
  }

  // Retrieve the saved "Day/Night" choice
  void _loadPreference() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDayMode = prefs.getBool('isDayMode') ?? false;
    });
  }

  // Toggle mode, save choice, and trigger haptic pulse
  void _toggleTheme() async {
    HapticFeedback.lightImpact(); // The "thump"
    setState(() {
      _isDayMode = !_isDayMode;
    });
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDayMode', _isDayMode);
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) setState(() => _now = DateTime.now());
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // NIGHT: Green on Black | DAY: Deep Teal on White
    final bgColor = _isDayMode ? Colors.white : Colors.black;
    final textColor = _isDayMode ? const Color(0xFF003333) : const Color(0xFF00FF41);

    // 12-hour format logic
    int hour = _now.hour > 12 ? _now.hour - 12 : (_now.hour == 0 ? 12 : _now.hour);
    String timeStr = "$hour:${_now.minute.toString().padLeft(2, '0')}";

    return GestureDetector(
      onTap: _toggleTheme,
      child: Scaffold(
        backgroundColor: bgColor,
        body: Container(
          // Subtle Jitter for burn-in protection
          alignment: Alignment((_now.minute % 4 - 2) * 0.015, (_now.minute % 2 - 0.5) * 0.015),
          child: SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.contain,
              child: Text(
                timeStr,
                style: TextStyle(
                  fontFamily: 'SevenSegment',
                  fontSize: 500,
                  color: textColor,
                  shadows: _isDayMode ? [] : [
                    Shadow(blurRadius: 10, color: textColor.withOpacity(0.5)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}