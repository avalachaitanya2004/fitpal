import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({Key? key}) : super(key: key);

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        title: Text('Feedback',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontFamily: 'ProductSans')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: _controller,
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'ProductSans',
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              decoration: InputDecoration(
                hintText: 'Enter your feedback',
                hintStyle: TextStyle(
                  color: Colors.grey.shade800,
                  fontFamily: 'ProductSans',
                  fontWeight: FontWeight.w400,
                ),
                border: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                ),
              ),
              maxLines: 7,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
              ),
              onPressed: () {
                _launchEmail(_controller.text, context);
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: Text(
                'Submit',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  fontFamily: 'ProductSans',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _launchEmail(String Feedback, BuildContext context) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'nanduseemakurthi257@gmail.com',
      query: 'subject=Feedback from App&body=$Feedback',
    );

    if (!await launchUrl(emailLaunchUri)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch email')),
      );
    }
  }
}
