import 'package:flutter/material.dart';

class NoInternetScreen extends StatefulWidget {
  const NoInternetScreen({super.key});

  @override
  State<NoInternetScreen> createState() => _NoInternetScreenState();
}

class _NoInternetScreenState extends State<NoInternetScreen>
    with SingleTickerProviderStateMixin {
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() => _visible = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnimatedOpacity(
        duration: const Duration(milliseconds: 600),
        opacity: _visible ? 1.0 : 0.0,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: AnimatedSlide(
              offset: _visible ? Offset.zero : const Offset(0, 0.2),
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOut,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.wifi_off, size: 80, color: Colors.redAccent),
                  SizedBox(height: 20),
                  Text(
                    "No Internet Connection",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    "Please connect to the internet and try again.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

