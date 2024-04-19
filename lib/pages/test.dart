import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

class Person {
  final String name;
  final String imageUrl;
  final String email;
  final String bio;
  final String githubUrl;
  final String linkedInUrl;

  Person({
    required this.name,
    required this.imageUrl,
    required this.email,
    required this.bio,
    required this.githubUrl,
    required this.linkedInUrl,
  });
}

final List<Person> people = [
  Person(
    name: 'Nandu',
    imageUrl:
        'https://i.pinimg.com/564x/e9/51/25/e951250f7f452c8e278d12ac073b9b5b.jpg',
    email: 'chunduri_a@cs.iitr.ac.in',
    bio:
        'A 2nd Year Undergrad at IIT Roorkee. Good coding experience with C++ and Java. Interest lies in software development.',
    githubUrl: 'https://github.com/abhijitch1',
    linkedInUrl: '',
  ),
  Person(
    name: 'Sudeep',
    imageUrl:
        'https://i.pinimg.com/564x/e9/51/25/e951250f7f452c8e278d12ac073b9b5b.jpg',
    email: 'chunduri_a@cs.iitr.c.in',
    bio:
        'A 2nd Year Undergrad at IIT Roorkee. Good coding experience with C++ and Java. Interest lies in software development.',
    githubUrl: 'https://github.com/abhijitch1',
    linkedInUrl: '',
  ),
];

void main() => runApp(MaterialApp(home: TEST()));

class TEST extends StatefulWidget {
  const TEST({Key? key}) : super(key: key);

  @override
  State<TEST> createState() => _TESTState();
}

class _TESTState extends State<TEST> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
              fontFamily: 'ProductSans',
            )),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
              Text(
                'Meet the developers of FitPal',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                    fontFamily: 'ProductSans'),
              ),
              SizedBox(
                height: 20,
              ),
              ListView.builder(
                shrinkWrap: true, // Added shrinkWrap here
                physics:
                    NeverScrollableScrollPhysics(), // Ensure does not scroll independently
                itemCount: people.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: PersonCard(person: people[index]),
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

class PersonCard extends StatelessWidget {
  final Person person;

  PersonCard({required this.person});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: CircleAvatar(
                radius: 35,
                backgroundImage: NetworkImage(person.imageUrl),
              ),
              title: Text(person.name),
              subtitle: Text(person.bio),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  icon: Icon(Icons.email),
                  onPressed: () => _launchEmail(person.email, context),
                ),
                IconButton(
                  icon: SvgPicture.asset(
                    "assets/svg/github1.svg",
                    height: 20.0,
                    color: Colors.black,
                  ),
                  onPressed: () => _launchURL(person.githubUrl, context),
                ),
                IconButton(
                  icon: SvgPicture.asset(
                    'assets/svg/linkedin.svg',
                    height: 20.0,
                    color: Colors.black,
                  ),
                  onPressed: () => _launchURL(person.linkedInUrl, context),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _launchEmail(String email, BuildContext context) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
      query: 'subject=User of FitPal App&body=Hi, I want to say hi to you.',
    );

    if (!await launchUrl(emailLaunchUri)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch $email')),
      );
    }
  }

  void _launchURL(String url, BuildContext context) async {
    if (!await launchUrl(Uri.parse(url))) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch $url')),
      );
    }
  }
}
