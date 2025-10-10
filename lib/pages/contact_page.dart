import 'package:flutter/material.dart';

class Contact extends StatelessWidget {
  const Contact({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff284a79),
        title: const Text('Contact Us'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('📞 Phone: +234 800 000 0000', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text('📧 Email: info@deusmagnus.com', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text('📍 Location: Lagos, Nigeria', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
