import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _phoneNumberController = TextEditingController();
  final _amountController = TextEditingController();

  Future<String> _getAccessToken(String consumerKey, String consumerSecret) async {
    final response = await http.get(
      Uri.parse('https://sandbox.safaricom.co.ke/oauth/v1/generate?grant_type=client_credentials'),
      headers: {
        'Authorization': 'Basic ' + base64Encode(utf8.encode('$consumerKey:$consumerSecret')),
      },
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      return responseBody['access_token'];
    } else {
      throw Exception('Failed to get access token');
    }
  }

  Future<void> _initiateMpesaPayment() async {
    final phoneNumber = _phoneNumberController.text.trim();
    final amount = _amountController.text.trim();

    final url = 'https://sandbox.safaricom.co.ke/mpesa/stkpush/v1/processrequest';
    final consumerKey = 'your_consumer_key';
    final consumerSecret = 'your_consumer_secret';
    final shortCode = 'your_shortcode';
    final lipaNaMpesaOnlinePassKey = 'your_lipa_na_mpesa_online_passkey';

    final timestamp = DateTime.now().toUtc().toString().replaceAll(RegExp(r'\D'), '').substring(0, 14);
    final password = base64.encode(utf8.encode(shortCode + lipaNaMpesaOnlinePassKey + timestamp));

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer ' + await _getAccessToken(consumerKey, consumerSecret),
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'BusinessShortCode': shortCode,
        'Password': password,
        'Timestamp': timestamp,
        'TransactionType': 'CustomerPayBillOnline',
        'Amount': amount,
        'PartyA': phoneNumber,
        'PartyB': shortCode,
        'PhoneNumber': phoneNumber,
        'CallBackURL': 'https://yourcallbackurl.com/callback',
        'AccountReference': 'BookingPayment',
        'TransactionDesc': 'Hotel Booking Payment',
      }),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Payment initiated successfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to initiate payment')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _phoneNumberController,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 20),
            TextField(
              controller: _amountController,
              decoration: InputDecoration(
                labelText: 'Amount',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: _initiateMpesaPayment,
              child: Text('Pay Now'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15),
                backgroundColor: Colors.blue,
                textStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
