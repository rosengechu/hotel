import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  final String title;

  const MyHomePage({required this.title, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'images/logo.png', // Replace with your image path
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 32), // Added more spacing
            Text(
              'Welcome to In-House Properties.',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.purple, // Purple color
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8), // Added some more spacing
            Text(
              'Your valued Hotel Booking Site',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.purple, // Purple color
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32), // Added more spacing
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/signUp');
              },
              child: const Text('Sign up'),
            ),
          ],
        ),
      ),
    );
  }
}
