import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  final String title;

  const MyHomePage({required this.title, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hotel Management System'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 200, // Set your preferred width
              height: 200, // Set your preferred height
              child: Image.asset(
                'images/hotel.jpg', // Replace with your image path
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 32), // Added more spacing
            Text(
              'Book with Ease, Stay with Pleasure.',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 14, 12, 12), // Purple color
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 32), // Added more spacing
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/signUp');
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red), // Set background color to red
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0), // Set border radius for a more stylish look
                    ),
                  ),
                ),
                child: Container( // Wrap the text in a container for more styling options
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24), // Add padding for a better appearance
                  child: const Text(
                    'Sign up',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Text color
                    ),
                  ),
                ),
              ),

          ],
        ),
      ),
    );
  }
}
