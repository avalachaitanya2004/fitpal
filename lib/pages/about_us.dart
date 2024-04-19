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
    name: 'Seemakurthi Nandan Sri Siva Ramakrishna',
    imageUrl:
        'https://i.pinimg.com/564x/e9/51/25/e951250f7f452c8e278d12ac073b9b5b.jpg',
    email: 'seemakurthi_nssr@cs.iitr.ac.in',
    bio:
        'A 2nd Year Undergrad at IIT Roorkee. Good coding experience with C++ and Java. Interest lies in software development.',
    githubUrl: 'https://github.com/Nandu-25',
    linkedInUrl:
        'https://www.linkedin.com/in/nandan-sri-siva-ramakrishna-seemakurthi/',
  ),
  Person(
    name: 'Ogireddy Sree Sudeep Reddy',
    imageUrl:
        'https://i.pinimg.com/564x/e9/51/25/e951250f7f452c8e278d12ac073b9b5b.jpg',
    email: 'ogireddy_ssr@cs.iitr.ac.in',
    bio:
        'A 2nd Year Undergrad at IIT Roorkee. Good coding experience with C++ and Java. Interest lies in software development.',
    githubUrl: 'https://github.com/sudeepreddy999',
    linkedInUrl: '',
  ),
  Person(
    name: 'Mudasani Rushikesh Reddy',
    imageUrl:
        'https://i.pinimg.com/564x/e9/51/25/e951250f7f452c8e278d12ac073b9b5b.jpg',
    email: 'mudasani_r@cs.iitr.ac.in',
    bio:
        'A 2nd Year Undergrad at IIT Roorkee. Good coding experience with C++ and Java. Interest lies in machine learning and software development.',
    githubUrl: 'https://github.com/Iknowimalone',
    linkedInUrl: 'https://www.linkedin.com/in/rushikesh-reddy/',
  ),
  Person(
    name: 'Avala Chaitanya Lakshmi Prakash Yadav',
    imageUrl:
        'https://i.pinimg.com/564x/e9/51/25/e951250f7f452c8e278d12ac073b9b5b.jpg',
    email: 'avala_clpy@cs.iitr.ac.in',
    bio:
        'A 2nd Year Undergrad at IIT Roorkee. Have good coding experience with C++ and Java. Interest lies in software development.',
    githubUrl: 'https://github.com/avalachaitanya2004',
    linkedInUrl: 'https://www.linkedin.com/in/chaitanya-avala/',
  ),
  Person(
    name: 'Dharavath Madhu',
    imageUrl:
        'https://i.pinimg.com/564x/e9/51/25/e951250f7f452c8e278d12ac073b9b5b.jpg',
    email: 'dharavath_m@cs.iitr.ac.in',
    bio:
        'A 2nd Year Undergrad at IIT Roorkee. Have good coding experience with C++ and Java. Interest lies in software development.',
    githubUrl: 'https://github.com/Madhudharavath',
    linkedInUrl: 'https://www.linkedin.com/in/dharavath-madhu/',
  ),
  Person(
    name: 'Gavireddy Diimppul',
    imageUrl:
        'https://i.pinimg.com/564x/e9/51/25/e951250f7f452c8e278d12ac073b9b5b.jpg',
    email: 'gavireddy_d@cs.iitr.ac.in',
    bio:
        'A 2nd Year Undergrad at IIT Roorkee. Good coding experience with C++ and Java. Interest lies in software development.',
    githubUrl: 'https://github.com/diimppulg',
    linkedInUrl: 'https://www.linkedin.com/in/diimppul-g/',
  ),
  Person(
    name: 'Perumallapalli Srinivasa Aditya',
    imageUrl:
        'https://i.pinimg.com/564x/e9/51/25/e951250f7f452c8e278d12ac073b9b5b.jpg',
    email: 'perumallapalli_sa@cs.iitr.ac.in',
    bio:
        ' A 2nd Year Undergrad at IIT Roorkee. Good coding experience with C++,Python and Java.Holds a keen interest in machine learning , Web and App development',
    githubUrl: 'https://github.com/Aditya0407',
    linkedInUrl: 'https://www.linkedin.com/in/srinivasa-aditya-0459a1271/',
  ),
];

void main() => runApp(MaterialApp(home: AboutUsPage()));

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
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
