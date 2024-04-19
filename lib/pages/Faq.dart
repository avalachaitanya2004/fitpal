import 'package:flutter/material.dart';

final List<FAQItem> _data = [
  FAQItem(
    title: 'How do I sign up or log in to the app?',
    answer:
        'You can sign up or log in by entering your username and password or using Google and Apple Auth. If your credentials are valid, you will be granted access. If there is an error, an error message will be displayed.',
  ),
  FAQItem(
    title: 'Can I update my personal information after signing up?',
    answer:
        'Yes, you can update your height, weight, age, physical activity level, and goals at any time. This information is used for personalized calculations and recommendations.',
  ),
  FAQItem(
    title: 'How do I log out of the app?',
    answer:
        'To log out, simply confirm logout through the settings menu, and you will be directed back to the login screen.',
  ),
  FAQItem(
    title: 'How do I choose a workout plan?',
    answer:
        'You can browse through pre-defined workout plans tailored to your calorie intake and fitness goals, or you can create a custom workout. Each plan details the exercises, sets, reps, and duration.',
  ),
  FAQItem(
    title: 'How is my workout tracked by the app?',
    answer:
        'When you start a workout, the app tracks each exercise\'s completion, sets, reps, and the time elapsed. You can pause or complete the workout, and the app will save this data accordingly.',
  ),
  FAQItem(
    title: 'How do I add and track calories of the food I eat?',
    answer:
        'Simply take a picture of your meal, and the app will estimate the calorie count using an automated system (may involve external service integration). You can confirm or adjust the estimated calories, and the app will store this information.',
  ),
  FAQItem(
    title: 'How can I add or remove a friend in the app?',
    answer:
        'To add a friend, search for them by username, select the appropriate user from the results, and send a friend request. To remove a friend, follow the same steps to find the user and then confirm removal. The app will update your friends list accordingly.',
  ),
  FAQItem(
    title: 'How do I view someone\'s profile?',
    answer:
        'Search for the user whose profile you wish to view, select them from the search results, and their profile details will be displayed.',
  ),
  FAQItem(
    title: 'How do I participate in fitness challenges?',
    answer:
        'Browse available challenges in the app, select one that interests you, and confirm your participation. The app tracks your progress automatically as you perform workouts related to the challenge.',
  ),
  FAQItem(
    title: 'What happens when I complete a challenge?',
    answer:
        'Upon meeting the challenge requirements, the app validates your completion and awards points or rewards if applicable. It also updates your XP and streaks automatically.',
  ),
  FAQItem(
    title: 'How can I monitor my progress?',
    answer:
        'You can view your earned experience points (XP), check your ranking on the leaderboard, and view your set fitness goals through the app\'s dedicated sections for XP, leaderboard, and goals.',
  ),
  FAQItem(
    title: 'What if I encounter issues or errors in the app?',
    answer:
        'If you encounter any issues or errors, please use the help and support option in the app to report them. Our support team will assist you in resolving them promptly.',
  ),
  FAQItem(
    title:
        'Can I use the app without entering all my personal details such as height, weight, and age?',
    answer:
        'While you can use the app without entering all your personal details, providing this information allows for more personalized recommendations and accurate calorie and workout tracking.',
  ),
  FAQItem(
    title: 'What should I do if I forget my password?',
    answer:
        'If you forget your password, use the "Forgot Password" feature on the login screen. You\'ll be prompted to enter your email address, and a link to reset your password will be sent to you.',
  ),
  FAQItem(
    title: 'Can I modify a pre-defined workout plan?',
    answer:
        'Yes, you can customize pre-defined workout plans by adding or removing exercises or adjusting sets, reps, and durations to better fit your personal goals and fitness level.',
  ),
  FAQItem(
    title: 'Does the app provide instructional content for exercises?',
    answer:
        'Yes, the app includes detailed descriptions and instructional videos for each exercise to ensure you perform each movement correctly and safely.',
  ),
  FAQItem(
    title:
        'Does the app cater to specific dietary requirements (e.g., vegan, keto, allergies)?',
    answer:
        'Yes, when setting up your profile, you can specify dietary preferences and restrictions. The app will tailor your food recommendations accordingly to meet your dietary needs.',
  ),
  FAQItem(
    title: 'How accurate is the calorie count provided by the app?',
    answer:
        'The calorie estimates are based on general data and the images you upload. While we strive for accuracy, actual calorie counts may vary. We recommend using these estimates as a guide and adjusting based on your own experience.',
  ),
  FAQItem(
    title:
        'What functionalities are available through social interaction in the app?',
    answer:
        'Social features include adding and removing friends, viewing friends\' profiles, sharing workouts and achievements, and participating in group challenges.',
  ),
  FAQItem(
    title: 'Can I block or report someone if necessary?',
    answer:
        'Yes, the app allows you to block or report users who are harassing or behaving inappropriately towards you. This can be done directly from their profile page.',
  ),
  FAQItem(
    title: 'Are there any incentives for completing challenges?',
    answer:
        'Completing challenges can earn you rewards such as badges, points, or even physical rewards, depending on the challenge and level of completion.',
  ),
  FAQItem(
    title: 'How does the app help keep me motivated?',
    answer:
        'The app keeps you motivated by tracking your progress, offering rewards, and enabling competition through leaderboards and community challenges. You can also receive personalized encouragement based on your activity and goals.',
  ),
  FAQItem(
    title:
        'How often does the app update, and will I lose my data with updates?',
    answer:
        'The app is updated regularly to introduce new features and improvements. We ensure that updates do not affect your stored data, so your progress and information will be preserved.',
  ),
  FAQItem(
    title: 'Who do I contact if I have feedback or suggestions for the app?',
    answer:
        'We welcome feedback and suggestions! Please use the feedback option in the app\'s settings or contact our customer support team via email or phone as listed in the app.',
  ),
];

class FAQItem {
  final String title;
  final String answer;

  FAQItem({required this.title, required this.answer});
}

class FAQPage extends StatelessWidget {
  const FAQPage({super.key});

  @override
  Widget build(BuildContext context) {
    var textStyle = TextStyle(
      fontFamily: 'ProductSans',
      color: Colors.black,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: textStyle.color, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        title:
            Text('FAQ', style: textStyle.copyWith(fontWeight: FontWeight.bold)),
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: _data.length,
        itemBuilder: (context, index) {
          final item = _data[index];
          return Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              title:
                  Text(item.title, style: textStyle.copyWith(fontSize: 16.0)),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(item.answer,
                      style: textStyle.copyWith(fontSize: 14.0, height: 1.5)),
                ),
              ],
              iconColor: Colors.black,
              collapsedIconColor: Colors.grey[700],
              backgroundColor: Colors.white,
              childrenPadding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              tilePadding: const EdgeInsets.symmetric(horizontal: 16.0),
            ),
          );
        },
      ),
    );
  }
}
