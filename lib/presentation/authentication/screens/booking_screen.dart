import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hotel/presentation/authentication/screens/PaymentScreen.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({Key? key}) : super(key: key);

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  String? _selectedHotelId;
  final List<Map<String, dynamic>> hotels = [
    {
      'id': 'hotel_1',
      'name': 'Hotel Sunshine',
      'image': 'images/hoteltwo.jpeg',
      'availability': 'Available',
      'price': 120,
      'rating': 4.5,
      'amenities': ['Free WiFi', 'Swimming Pool', 'Gym', 'Restaurant']
    },
    {
      'id': 'hotel_2',
      'name': 'Grand Plaza',
      'image': 'images/hotelsix.jpeg',
      'availability': 'Limited Availability',
      'price': 150,
      'rating': 4.0,
      'amenities': ['Free WiFi', 'Breakfast', 'Parking', 'Bar']
    },
    {
      'id': 'hotel_3',
      'name': 'Luxury Suites',
      'image': 'images/hotelfour.jpeg',
      'availability': 'Sold Out',
      'price': 200,
      'rating': 4.8,
      'amenities': ['Free WiFi', 'Spa', 'Airport Shuttle', 'Restaurant']
    },
    {
      'id': 'hotel_4',
      'name': 'Royal Palace',
      'image': 'images/hotelfour.jpeg',
      'availability': 'Avaiable',
      'price': 180,
      'rating': 4.8,
      'amenities': ['Free WiFi', 'Spa' , 'Restaurant']
    },
    {
      'id': 'hotel_5',
      'name': 'Beach Resort',
      'image': 'images/hotelfour.jpeg',
      'availability': 'Available',
      'price': 220,
      'rating': 4.9,
      'amenities': ['Free WiFi', 'Spa', 'Private Beach', 'Restaurant']
    },
    {
      'id': 'hotel_6',
      'name': 'Neptune Resort',
      'image': 'images/hotelfour.jpeg',
      'availability': 'Sold Out',
      'price': 150,
      'rating': 4.6,
      'amenities': ['Free WiFi', 'Spa', 'Airport Shuttle', 'Restaurant']
    },
    {
      'id': 'hotel_7',
      'name': 'Silver Palms',
      'image': 'images/hotelfour.jpeg',
      'availability': 'Sold Out',
      'price': 250,
      'rating': 4.4,
      'amenities': ['Free WiFi', 'Restaurant']
    },
    {
      'id': 'hotel_8',
      'name': 'Palm Terrace',
      'image': 'images/hotelfour.jpeg',
      'availability': 'Available',
      'price': 170,
      'rating': 4.8,
      'amenities': ['Spa', 'Airport Shuttle', 'Restaurant']
    },
    {
      'id': 'hotel_9',
      'name': 'Royal Resort',
      'image': 'images/hotelfour.jpeg',
      'availability': 'Available',
      'price': 100,
      'rating': 4.0,
      'amenities': [ 'Spa',  'Restaurant']
    },
    {
      'id': 'hotel_10',
      'name': 'Sunset Paradise',
      'image': 'images/hotelfour.jpeg',
      'availability': 'Sold Out',
      'price': 130,
      'rating': 4.2,
      'amenities': ['Free WiFi', 'Spa', 'Swimming Pool' 'Restaurant']
    },
  ];

  Future<void> _selectDates(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (pickedDate != null) {
      print('Selected date: $pickedDate');
      // Handle the selected date
    }
  }

  void _storeBookingData(BuildContext context) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      Map<String, dynamic> bookingData = {
        'date': DateTime.now(), // Example date
        'hotelId': _selectedHotelId, // Selected hotel ID
      };

      DocumentReference documentReference = await firestore.collection('bookings').add(bookingData);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Booking successfully added to Firestore with ID: ${documentReference.id}')),
      );

      // Navigate to payment screen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PaymentScreen()),
      );
    } catch (e) {
      print('Error adding booking: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error adding booking')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book a Hotel'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Select Dates',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                _selectDates(context);
              },
              icon: Icon(Icons.calendar_today),
              label: Text('Choose Dates'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                backgroundColor: Colors.blue,
                textStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            SizedBox(height: 30),
            Text(
              'Select Hotel',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                children: List.generate(hotels.length, (index) {
                  return HotelCard(
                    hotel: hotels[index],
                    onSelect: () {
                      setState(() {
                        _selectedHotelId = hotels[index]['id'];
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${hotels[index]['name']} selected')),
                      );
                    },
                    onBook: () {
                      _selectedHotelId = hotels[index]['id'];
                      _storeBookingData(context);
                    },
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HotelCard extends StatelessWidget {
  final Map<String, dynamic> hotel;
  final VoidCallback onSelect;
  final VoidCallback? onBook;

  HotelCard({required this.hotel, required this.onSelect, this.onBook});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: hotel['availability'] != 'Sold Out' ? onSelect : null,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
              child: Image.asset(
                hotel['image'],
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    hotel['name'],
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  SizedBox(height: 5),
                  Text('Availability: ${hotel['availability']}'),
                  Text('Price: \$${hotel['price']} per night'),
                  Text('Rating: ${hotel['rating']}'),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: onBook,
                    child: Text('Book Now'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
