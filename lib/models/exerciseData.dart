class ExerciseCard {
  final String name;
  final int defaultreps;
  final int repsWanted;
  final bool isSelected;
  final bool ismin;
  String generateInst() {
    switch (name) {
      case 'JUMPING JACKS':
        return "Jumping jacks are a fantastic cardiovascular exercise that engages multiple muscle groups, including your legs, arms, and core. To perform a jumping jack correctly, start by standing with your feet together and your arms at your sides. Then, simultaneously jump your feet out to the sides while raising your arms above your head. Ensure that your arms are straight and your legs are fully extended. Next, jump back to the starting position by bringing your feet together and lowering your arms back to your sides. Repeat this motion continuously for a set duration\n \n or number of repetitions. Remember to maintain proper form, ";

      case 'ABDOMINAL CRUNCHES':
        return "Abdominal crunches are a fundamental exercise for strengthening the core muscles. To perform them effectively, lie on your back with your knees bent and feet flat on the ground. Engage your core by drawing your navel towards your spine. Lift your head, neck, and shoulders off the ground using your abdominal muscles, while keeping your lower back pressed into the mat. Avoid pulling on your neck with your hands and focus on controlled movements. Exhale as you lift and inhale as you lower back down. Aim for 10-15 repetitions per set, gradually increasing as you\n \n build strength. Remember to maintain proper form and listen to your body to prevent strain or injury.";

      case 'RUSSIAN TWIST':
        return "Russian twists are an effective exercise for targeting the oblique muscles and improving core strength and stability. To perform Russian twists correctly, sit on the floor with your knees bent and feet flat on the ground. Lean back slightly to engage your core muscles and lift your feet off the ground, balancing on your sitting bones. Interlace your fingers or hold a weight in front of you, keeping your arms extended. Twist your torso to the right, bringing your hands or weight towards the floor beside your hip. Return to the center and then twist to the left side, repeating \n \nthe movement in a controlled manner. Keep your chest lifted and your back straight throughout the exercise to prevent strain on your lower back. Aim for 10-15 repetitions per set, gradually increasing as you build strength and stability. Adjust the difficulty by increasing the weight or extending the duration of each set. Remember to breathe evenly and engage your core muscles to maximize the effectiveness of the exercise.";

      case 'MOUNTAIN CLIMBER':
        return "Mountain climbers are a dynamic and challenging exercise that engages multiple muscle groups, including the core, shoulders, and legs. To perform mountain climbers correctly, start in a plank position with your hands directly under your shoulders and your body forming a straight line from head to heels. Engage your core muscles to maintain stability throughout the exercise. Next, bring one knee towards your chest while keeping your hips low and your back flat. Quickly switch legs, extending the bent leg back while bringing the opposite knee towards your chest. Alternate legs in\n \n a rapid, running motion, keeping your movements controlled and your core engaged. Aim for a steady pace, and try to maintain proper form without letting your hips rise or sag. Start with 30 seconds to a minute of mountain climbers, gradually increasing the duration as you build strength and endurance. Remember to breathe steadily throughout the exercise to maximize oxygen flow and energy.";
      default:
        return "this is not in DB";
    }
  }

  ExerciseCard({
    required this.name,
    required this.defaultreps,
    required this.repsWanted,
    required this.isSelected,
    required this.ismin,
  });
}
