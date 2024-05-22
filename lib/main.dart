import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:read/constants/colors.dart';
import 'package:read/firebase_options.dart';
import 'package:read/screen/homepage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splash(),
    );
  }
}

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool _isConnected = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkInternetConnection();
  }

  Future<void> _checkInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    print(connectivityResult);
    if (connectivityResult[0] == ConnectivityResult.none) {
      setState(() {
        _isConnected = false;
      });
    } else {
      setState(() {
        _isConnected = true;
      });
      Timer(const Duration(seconds: 2), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Homepage()),
        );
      });
    }
  }

  void retry() {
    _checkInternetConnection();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/assets/back.png"),
            fit: BoxFit.cover,
          ),
        ),
      ),
      !_isConnected
          ? Scaffold(
              backgroundColor: transparent,
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.wifi_off_rounded,
                  ),
                  Center(
                    child: Text(
                      "No internet connection.",
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.045,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      retry();
                    },
                    backgroundColor: primaryColor,
                    child: const Icon(
                      Icons.restart_alt_rounded,
                      color: white,
                    ),
                  )
                ],
              ),
            )
          : Scaffold(
              backgroundColor: transparent,
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "read.",
                      style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                              fontSize: 50, fontWeight: FontWeight.bold)),
                    ),
                    Text(
                      "Open a world of books, right at your fingertips",
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.038)),
                    )
                  ],
                ),
              ),
            ),
    ]);
  }
}
