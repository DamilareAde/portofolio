import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactScreen extends StatelessWidget {
  // Function to launch the URL for social media
  Future<void> _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(
              'Connect with me on social media:',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20),
            // Social media icons using Lottie animations
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    _launchUrl('https://www.instagram.com/yourusername');  // Replace with your Instagram URL
                  },
                  child: Lottie.asset(
                    'assets/animations/instagram.json', // Replace with the path to your Instagram Lottie animation
                    width: 60,
                    height: 60,
                  ),
                ),
                const SizedBox(width: 20),
                GestureDetector(
                  onTap: () {
                    _launchUrl('https://www.linkedin.com/in/yourusername');  // Replace with your LinkedIn URL
                  },
                  child: Lottie.asset(
                    'assets/animations/linkedin.json', // Replace with the path to your LinkedIn Lottie animation
                    width: 60,
                    height: 60,
                  ),
                ),
                const SizedBox(width: 20),
                GestureDetector(
                  onTap: () {
                    _launchUrl('https://twitter.com/yourusername');  // Replace with your Twitter URL
                  },
                  child: Lottie.asset(
                    'assets/animations/twitter.json', // Replace with the path to your Twitter Lottie animation
                    width: 60,
                    height: 60,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            Text(
              'You can also email me at:',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () => _launchUrl('mailto:your.email@example.com'),  // Replace with your email address
              child: Text(
                'your.email@example.com',
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
