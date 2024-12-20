import 'package:flutter/material.dart';
import 'dart:async';

class AboutScreen extends StatefulWidget {
  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool isFront = true;

  String animatedText = "";
  int textIndex = 0;
  final String fullText =
      "I'm a passionate Flutter developer with a knack for building modern, user-friendly applications. I specialize in creating seamless user experiences and love to experiment with animations and UI/UX design.";

  @override
  void initState() {
    super.initState();

    // Animation for the flipping card
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    // Start live typing animation
    Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (textIndex < fullText.length) {
        if (mounted) {
          setState(() {
            animatedText += fullText[textIndex];
            textIndex++;
          });
        }
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _flipCard() {
    if (isFront) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    setState(() {
      isFront = !isFront;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("About Me"),
      ),
      body: Column(
        children: [
          const SizedBox(height: 32),
          // Fixed Profile Picture and Heading Section
          Column(
            children: [
              // Flipping Profile Picture
              GestureDetector(
                onTap: _flipCard,
                child: AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    final angle = _animation.value * 3.14;
                    return Transform(
                      transform: Matrix4.rotationY(angle),
                      alignment: Alignment.center,
                      child: angle < 3.14 / 2
                          ? _buildFrontSide()
                          : _buildBackSide(),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              // Static "Hi, I'm Damilare!"
              Text(
                "Hi, I'm Damilare!",
                style: theme.textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          const SizedBox(height: 32),
          // Scrolling Content
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    // Live Typing Text
                    LiveTypingText(
                      text: animatedText,
                      style: theme.textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFrontSide() {
    return CircleAvatar(
      radius: 60,
      backgroundColor: Colors.grey[800],
      child: ClipOval(
        child: Image.asset(
          "assets/images/profile.jpeg",
          fit: BoxFit.cover,
          width: 120,
          height: 120,
        ),
      ),
    );
  }

  Widget _buildBackSide() {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey[800],
      ),
      alignment: Alignment.center,
      child: Text(
        "Flutter Enthusiast",
        style: const TextStyle(color: Colors.white, fontSize: 14),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class LiveTypingText extends StatelessWidget {
  final String text;
  final TextStyle? style;

  const LiveTypingText({required this.text, this.style});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style,
      textAlign: TextAlign.center,
    );
  }
}
