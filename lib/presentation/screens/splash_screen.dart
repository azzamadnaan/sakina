import 'dart:async';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../main_layout.dart';
import '../../core/constants/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  VideoPlayerController? _controller;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _initVideo();
  }

  void _initVideo() {
    _controller = VideoPlayerController.asset('assets/videos/welcome.mp4')
      ..initialize().then((_) {
        setState(() {});
        _controller!.play();
        _controller!.addListener(() {
          if (_controller!.value.position >= _controller!.value.duration) {
            _navigateToHome();
          }
        });
      }).catchError((error) {
        setState(() => _hasError = true);
        Timer(const Duration(seconds: 3), _navigateToHome);
      });
  }

  void _navigateToHome() {
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MainLayout()),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_hasError || _controller == null || !_controller!.value.isInitialized) {
      return Scaffold(
        backgroundColor: SakinahColors.scaffoldBg,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo.png', width: 140),
              const SizedBox(height: 24),
              const CircularProgressIndicator(color: SakinahColors.primary),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox.expand(
        child: FittedBox(
          fit: BoxFit.cover,
          child: SizedBox(
            width: _controller!.value.size.width,
            height: _controller!.value.size.height,
            child: VideoPlayer(_controller!),
          ),
        ),
      ),
    );
  }
}
