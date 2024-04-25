class Excersise {
  final String name;
  final int reps;

  int returntime() {
    if (returnBool() ?? false) {
      return reps;
    } else {
      return reps * 4;
    }
  }

  String? generateInst() {
    if (exerciseDictionary.containsKey(name)) {
      return exerciseDictionary[name]?['hintsForBeginners'] as String?;
    } else {
      return "";
    }
  }

  String? generateInfo() {
    if (exerciseDictionary.containsKey(name)) {
      return exerciseDictionary[name]?['info'] as String?;
    } else {
      return "";
    }
  }

  String? ImagePath() {
    if (exerciseDictionary.containsKey(name)) {
      return exerciseDictionary[name]?['image'] as String?;
    } else {
      return "";
    }
  }

  String? VideoPath() {
    if (exerciseDictionary.containsKey(name)) {
      return exerciseDictionary[name]?['video'] as String?;
    } else {
      return "";
    }
  }

  bool? returnBool() {
    if (exerciseDictionary.containsKey(name)) {
      return exerciseDictionary[name]?['perMinute'] as bool? ?? false;
    } else {
      return true;
    }
  }

  // double? getcal() {
  //   if (exerciseDictionary.containsKey(name)) {
  //     return exerciseDictionary[name]!['calories'].toDouble();
  //   } else {
  //     return 0;
  //   }
  // }
  double? getcal() {
    if (exerciseDictionary.containsKey(name)) {
      var calories = exerciseDictionary[name]!['calories'];
      if (calories != null) {
        return calories
            as double; // No need for conversion, it's already a double
      } else {
        return null; // Or return another value to indicate that calories are not available
      }
    } else {
      return 0;
    }
  }

  // double? getXP() {
  //   if (exerciseDictionary.containsKey(name)) {
  //     var calories = exerciseDictionary[name]!['xp'];
  //     if (calories != null) {
  //       return calories
  //           as double; // No need for conversion, it's already a double
  //     } else {
  //       return null; // Or return another value to indicate that calories are not available
  //     }
  //   } else {
  //     return 0;
  //   }
  // }
  // double? totalxp() {
  //   double s = reps * getXP()!;
  //   return s;
  // }
  double? getXP() {
    if (exerciseDictionary.containsKey(name)) {
      var xp = exerciseDictionary[name]!['xp'];
      if (xp != null) {
        return xp as double; // Ensure xp is cast to double
      } else {
        return null;
      }
    } else {
      return null; // Return null when exercise is not found
    }
  }

  double totalxp() {
    double xp = getXP() ?? 0.0; // If getXP() returns null, default to 0
    return reps * xp;
  }

  double? gettotcal() {
    double s = reps * getcal()!;
    return s;
  }

  Excersise({required this.name, required this.reps});
}

var exerciseDictionary = {
  // "corkscrew": {
  //   "info":
  //       "Corkscrew is a core exercise that targets your abdominal muscles and improves spinal flexibility. It involves lying on your back with arms by your sides and lifting your legs towards the ceiling. Keeping your legs straight, lower them to one side in a circular motion, then bring them back up and lower them to the other side, forming a 'corkscrew' motion.",
  //   "calories": 6,
  //   "perMinute": true,
  //   "hintsForBeginners":
  //       "Start with small, controlled movements to avoid straining your back. Focus on engaging your core muscles throughout the exercise. Keep your shoulders relaxed and use your core to initiate the movement.",
  //   "image":"assets/images/workoutImages/"

  // },
  "running in place": {
    "info":
        "Running in place is a cardiovascular exercise that elevates your heart rate and improves endurance. Begin by standing with your feet hip-width apart, and lift your knees upward alternately, simulating a running motion. Swing your arms naturally to mimic the movement of running. Continue at a brisk pace for the desired duration.",
    "calories": 8.0,
    "perMinute": true,
    "hintsForBeginners":
        "Start with a slow pace and gradually increase your speed as you become more comfortable. Focus on maintaining a good posture and engaging your core muscles. Land softly on the balls of your feet to reduce impact on your joints.",
    "image": "assets/images/workoutImages/RunninginPlace.jpg",
    "video": "assets/videos/Runninginplace.mp4",
    "xp": 0.2,
  },
  "Traise": {
    "info":
        "The T raise is a shoulder exercise that targets the deltoid muscles. Begin by standing with your feet shoulder-width apart, holding a dumbbell in each hand. With a slight bend in your elbows, raise your arms out to the sides until they are parallel to the ground, forming a 'T' shape. Slowly lower the weights back to the starting position and repeat.",
    "calories": 5.0,
    "perMinute": true,
    "hintsForBeginners":
        "Start with light weights to ensure proper form. Keep your core engaged and avoid swinging your body as you lift the weights. Focus on controlled movements and maintain a slight bend in your elbows throughout the exercise.",
    "image": "assets/images/workoutImages/Traise.jpg",
    "video": "assets/videos/Traise.mp4",
    "xp": 0.2,
  },
  "alternating plank": {
    "info":
        "Alternating plank is a full-body exercise that strengthens your core, shoulders, and arms. Begin in a plank position with your hands directly under your shoulders and your body in a straight line from head to heels. Lift one arm off the ground and touch your opposite shoulder, then return to the starting position and repeat with the other arm.",
    "calories": 4.0,
    "perMinute": true,
    "hintsForBeginners":
        "Begin with a modified plank by resting on your knees instead of your toes. Keep your body in a straight line from head to knees. Engage your core to stabilize your body as you lift each arm.",
    "image": "assets/images/workoutImages/AlternatingPlank.jpg",
    "video": "assets/videos/AlternatingPlank.mp4",
    "xp": 0.2,
  },
  "tricep dips": {
    "info":
        "Tricep dips target the triceps, shoulders, and chest muscles. It involves lowering and raising your body using a stable surface like a chair or bench. Sit on the edge of the chair with your hands gripping the edge. Walk your feet forward and lift your hips off the chair. Bend your elbows to lower your body towards the ground, then straighten your arms to lift yourself back up.",
    "calories": 0.0115,
    "perMinute": false,
    "hintsForBeginners":
        "Keep your elbows close to your body and your back close to the surface you're dipping on. Start with shallow dips and gradually increase your range of motion as you build strength. Focus on using your triceps to lift your body.",
    "image": "assets/images/workoutImages/Tricepdips.jpg",
    "video": "assets/videos/TricepDips.mp4",
    "xp": 1.0,
  },
  "inclined pushups": {
    "info":
        "Inclined pushups are a modification of traditional pushups that are easier for beginners. They target the chest, shoulders, and triceps. Place your hands on an elevated surface like a bench or countertop, slightly wider than shoulder-width apart. Lower your chest towards the surface by bending your elbows, then push through your palms to return to the starting position.",
    "calories": 5.0,
    "perMinute": true,
    "hintsForBeginners":
        "Use an elevated surface like a bench or countertop to perform inclined pushups. Keep your body in a straight line from head to heels and lower your chest toward the surface. Focus on maintaining proper form and gradually increase the depth of your pushup as you get stronger.",
    "image": "assets/images/workoutImages/ShoulderPushups.jpg",
    "video": "assets/videos/InclinePushups.mp4",
    "xp": 0.2,
  },
  "tricep press": {
    "info":
        "Tricep press is an isolation exercise that targets the triceps, the muscles located at the back of the upper arm. Begin by lying flat on your back on a bench or the floor, holding a dumbbell in each hand above your chest with palms facing inward. Lower the dumbbells toward your shoulders by bending your elbows, keeping them close to your body. Extend your arms back up to the starting position, fully straightening your elbows.",
    "calories": 5.0,
    "perMinute": true,
    "hintsForBeginners":
        "For beginners, start with a lighter weight to focus on proper form and technique. Keep your elbows stable throughout the movement, avoiding any swinging or momentum. Engage your core to stabilize your body and prevent overarching your lower back. Gradually increase the weight as you become more comfortable with the exercise.",
    "image": "assets/images/workoutImages/Tricepdips.jpg",
    "video": "assets/videos/Triceppress.mp4",
    "xp": 0.2,
  },
  "shoulder push-ups": {
    "info":
        "Shoulder push-ups are an effective bodyweight exercise that targets the shoulders, chest, and triceps. Begin in a plank position with your hands directly under your shoulders and feet hip-width apart. Lower your chest toward the ground while keeping your elbows close to your body. Push back up to the starting position, maintaining a straight line from head to heels.",
    "calories": 6.0,
    "perMinute": true,
    "hintsForBeginners":
        "For beginners, start with incline push-ups using a sturdy elevated surface like a bench or a step. Focus on maintaining a neutral spine and engaging your core throughout the movement. As you progress, gradually lower the incline until you can perform push-ups on the ground with proper form.",
    "image": "assets/images/workoutImages/ShoulderPushups.jpg",
    "video": "assets/videos/Shoulderpushups.mp4",
    "xp": 0.2,
  },
  "prisoners squat": {
    "info":
        "Prisoners squat is a lower body exercise that targets the quads, glutes, and hamstrings. It involves squatting down with your hands clasped behind your head. Stand with your feet shoulder-width apart and your hands clasped behind your head. Squat down by bending your knees and pushing your hips back, then return to the starting position by straightening your legs.",
    "calories": 10.5,
    "perMinute": true,
    "hintsForBeginners":
        "Start with a wider stance and focus on keeping your knees aligned with your toes as you squat down. Keep your chest up and back straight throughout the movement. Engage your core to stabilize your body and prevent your knees from collapsing inward.",
    "image": "assets/images/workoutImages/PrisonersSquat.jpg",
    "video": "assets/videos/Prisonerssquat.mp4",
    "xp": 0.2,
  },
  "running burpees": {
    "info":
        "Running burpees are a high-intensity full-body exercise that combines a squat, plank, pushup, and jump. They improve cardiovascular fitness and strength. Begin in a standing position, then squat down and place your hands on the ground. Jump or step your feet back into a plank position, perform a pushup, then jump or step your feet forward and explode up into a jump.",
    "calories": 10.0,
    "perMinute": true,
    "hintsForBeginners":
        "Begin with a modified version by stepping back into the plank position instead of jumping. Focus on maintaining proper form and gradually increase your speed as you get comfortable. Engage your core throughout the exercise to stabilize your body.",
    "image": "assets/images/workoutImages/RunningBurpees.jpg",
    "video": "assets/videos/Runningburpees.mp4",
    "xp": 0.2,
  },

  "jump squat": {
    "info":
        "Jump squats are a dynamic lower body exercise that enhances strength and explosiveness. Start in a standing position with feet shoulder-width apart. Lower into a squat, keeping your chest up and back straight. Explode upward, jumping as high as you can. Land softly and immediately descend into the next squat.",
    "calories": 8.0,
    "perMinute": true,
    "hintsForBeginners":
        "For beginners, perform regular squats focusing on form and depth before adding the jump. Start with small jumps and gradually increase height and intensity. Keep your knees aligned with your toes to prevent injury, and land softly to minimize impact on your joints.",
    "image": "assets/images/workoutImages/JumpSquats.jpg",
    "video": "assets/videos/Jumpsquat.mp4",
    "xp": 0.2,
  },
  "twisted mountain climber": {
    "info":
        "Twisted mountain climber is a core and cardio exercise that targets the obliques, abs, and shoulders. Begin in a plank position with your hands directly under your shoulders and your body in a straight line from head to heels. Bring one knee towards the opposite elbow while twisting your torso, then return to the starting position and repeat on the other side.",
    "calories": 12.0,
    "perMinute": true,
    "hintsForBeginners":
        "Start with slow, controlled movements to get the form right. Keep your core engaged and your hips stable throughout the exercise. Focus on bringing your knee towards your elbow while maintaining a straight back.",
    "image": "assets/images/workoutImages/TwistedMountainClimber.jpg",
    "video": "assets/videos/Twistedmountainclimber.mp4",
    "xp": 0.2,
  },
  "shoulder tap": {
    "info":
        "Shoulder tap is a core stabilization exercise that targets the abs, shoulders, and arms. Begin in a plank position with your hands directly under your shoulders and your body in a straight line from head to heels. Lift one hand off the ground and touch your opposite shoulder, then return to the starting position and repeat with the other hand.",
    "calories": 0.87,
    "perMinute": false,
    "hintsForBeginners":
        "Begin with a wider stance to improve balance and stability. Focus on keeping your hips steady and your core engaged as you tap each shoulder. Avoid rocking your hips from side to side.",
    "image": "assets/images/workoutImages/ShoulderTapPushups.jpg",
    "video": "assets/videos/Shouldertappushups.mp4",
    "xp": 1.0,
  },
  "push-up and rotation": {
    "info":
        "Push-up with rotation is a dynamic variation of the traditional push-up that engages the chest, shoulders, triceps, and core muscles. Begin in a plank position with your hands directly under your shoulders. Perform a push-up, then rotate your body to one side, extending the arm upward toward the ceiling. Return to the plank position and repeat on the other side.",
    "calories": 8.0,
    "perMinute": true,
    "hintsForBeginners":
        "If you're new to push-ups, start with modified push-ups on your knees to build strength. Focus on keeping your body in a straight line from head to knees. As you progress, work on increasing the depth of your push-ups before adding the rotation. Engage your core throughout the movement to stabilize your body.",
    "image": "assets/images/workoutImages/PushupandRotation.jpg",
    "video": "assets/videos/PushupandRotation.mp4",
    "xp": 0.2,
  },
  "kneeled narrow pushup": {
    "info":
        "Kneeled narrow pushup is a modified version of the narrow pushup that targets the triceps and chest. It's suitable for beginners who may not have the strength to perform regular pushups. Begin on your hands and knees with your hands directly under your shoulders and your knees hip-width apart. Lower your chest towards the ground by bending your elbows, then push through your palms to return to the starting position.",
    "calories": 10.0,
    "perMinute": true,
    "hintsForBeginners":
        "Kneel on a mat or soft surface to reduce pressure on your knees. Keep your elbows close to your body as you lower yourself down, and push through your palms to return to the starting position. Engage your core throughout the exercise to maintain proper form.",
    "image": "assets/images/workoutImages/KneeledNarrowPushups.jpg",
    "video": "assets/videos/Kneelednarrowpushups.mp4",
    "xp": 0.2,
  },
  "butt kicks": {
    "info":
        "Butt kicks are a dynamic warm-up exercise that targets the quadriceps and hamstrings. They involve quickly bringing your heels up towards your glutes while jogging in place. Begin by jogging in place, then focus on kicking your heels up towards your glutes with each step.",
    "calories": 0.075,
    "perMinute": false,
    "hintsForBeginners":
        "Start with a slow pace and gradually increase your speed as you warm up. Focus on bringing your heels as close to your glutes as possible with each kick. Keep your upper body relaxed and your arms swinging naturally.",
    "image": "assets/images/workoutImages/ButtKickers.jpg",
    "video": "assets/videos/Buttkicks.mp4",
    "xp": 1.0,
  },
  "t chin-ups": {
    "info":
        "Towel chin-ups are a challenging variation of the traditional chin-up that targets the back, biceps, and grip strength. Begin by draping a towel over a sturdy horizontal bar, gripping each end with an underhand grip. Hang with arms fully extended, then pull yourself up until your chin reaches the height of the bar. Lower yourself back down with control.",
    "calories": 12.0,
    "perMinute": true,
    "hintsForBeginners":
        "If you're new to chin-ups, start with assisted chin-ups using a resistance band or a chin-up assist machine. Focus on mastering the proper technique, engaging your back muscles throughout the movement. Gradually decrease assistance as you build strength.",
    "image": "assets/images/workoutImages/Tchinups.jpg",
    "video": "assets/videos/Tchinups.mp4",
    "xp": 0.2,
  },
  "pulse rows": {
    "info":
        "Pulse rows are a back-strengthening exercise that targets the upper back and shoulders. They involve pulling weights or resistance bands towards your body in a rowing motion with short pulses at the top of the movement. Stand with your feet hip-width apart and hold a weight or resistance band in each hand. Bend your knees slightly and hinge forward at the hips, keeping your back flat. Pull the weights or bands towards your body, squeezing your shoulder blades together, then pulse at the top of the movement before returning to the starting position.",
    "calories": 0.45,
    "perMinute": false,
    "hintsForBeginners":
        "Start with light weights or resistance bands to avoid straining your muscles. Focus on squeezing your shoulder blades together with each repetition to engage the upper back muscles. Keep your core engaged and your back flat throughout the exercise.",
    "image": "assets/images/workoutImages/PulseRows.jpg",
    "video": "assets/videos/Pulserows.mp4",
    "xp": 1.0,
  },
  "seal pushups": {
    "info":
        "Seal pushups are a variation of traditional pushups that target the chest, shoulders, and triceps. They involve a wider hand placement and a rhythmic pulsing motion at the bottom of the pushup. Begin in a plank position with your hands slightly wider than shoulder-width apart. Lower your chest towards the ground by bending your elbows, then push through your palms to return to the starting position while pulsing your chest up and down.",
    "calories": 0.81,
    "perMinute": false,
    "hintsForBeginners":
        "Begin with a modified version on your knees to build strength. Keep your core engaged and your body in a straight line from head to knees throughout the exercise. Focus on maintaining a controlled rhythm as you pulse at the bottom of the pushup.",
    "image": "assets/images/workoutImages/SealPushups.jpg",
    "video": "assets/videos/Sealpushups.mp4",
    "xp": 1.0,
  },
  "scapular pushups": {
    "info":
        "Scapular pushups are a shoulder-strengthening exercise that targets the muscles around the shoulder blades. Begin in a plank position with your hands directly under your shoulders and your body in a straight line from head to heels. Lower your chest towards the ground by protracting your shoulder blades, then push through your palms to return to the starting position while retracting your shoulder blades.",
    "calories": 8.0,
    "perMinute": true,
    "hintsForBeginners":
        "Focus on moving the shoulder blades smoothly and controlled. Keep your core engaged and avoid shrugging your shoulders towards your ears. Start with a small range of motion and gradually increase as you build strength.",
    "image": "assets/images/workoutImages/InclinedPushups.jpg",
    "video": "assets/videos/Scapularpushups.mp4",
    "xp": 1.0,
  },
  "reverse snow angels": {
    "info":
        "Reverse snow angels are a back and shoulder exercise that targets the muscles of the upper back and shoulders. Begin lying face down on the ground with your arms extended out to the sides and your palms facing down. Lift your chest and arms off the ground while squeezing your shoulder blades together, then lower them back down to the starting position.",
    "calories": 4.73,
    "perMinute": true,
    "hintsForBeginners":
        "Start with small movements and focus on squeezing your shoulder blades together as you lift your arms. Keep your neck in a neutral position to avoid straining your neck muscles. Engage your core to stabilize your body throughout the exercise.",
    "video": "assets/videos/Reversesnowangels.mp4",
    "image": "assets/images/workoutImages/ReverseSnowAngels.jpg",
    "xp": 0.2,
  },
  "mountain runner": {
    "info":
        "Mountain runners are a high-intensity cardio exercise that mimics the motion of running in place. They engage the core, legs, and cardiovascular system. Begin in a plank position with your hands directly under your shoulders and your body in a straight line from head to heels. Quickly alternate bringing your knees towards your chest while maintaining a fast-paced rhythm.",
    "calories": 7.5,
    "perMinute": true,
    "hintsForBeginners":
        "Start with a slow pace and focus on maintaining proper form. Keep your core engaged and your knees lifted towards your chest with each step. Focus on breathing rhythmically to maintain endurance.",
    "image": "assets/images/workoutImages/ReverseSnowAngels.jpg",
    "video": "assets/videos/MountainRunner.mp4",
    "xp": 0.2,
  },
  "diamond pushups": {
    "info":
        "Diamond pushups are a challenging variation of traditional pushups that target the triceps, chest, and shoulders. They involve placing your hands close together in a diamond shape beneath your chest. Begin in a plank position with your hands close together and your thumbs and index fingers forming a diamond shape. Lower your chest towards your hands by bending your elbows, then push through your palms to return to the starting position.",
    "calories": 0.4,
    "perMinute": false,
    "hintsForBeginners":
        "Begin with a modified version on your knees or an elevated surface to reduce the intensity. Keep your elbows close to your body and lower your chest towards your hands in a controlled motion. Engage your core to maintain stability throughout the exercise.",
    "image": "assets/images/workoutImages/Diamondpushups.jpg",
    "video": "assets/videos/Diamondpushups.mp4",
    "xp": 1.0,
  },
  "inchworm": {
    "info":
        "Inchworm is a full-body exercise that targets the core, shoulders, and hamstrings. Begin standing with your feet hip-width apart. Bend forward at the waist and place your hands on the ground, then walk them out into a plank position. Hold for a moment, then walk your hands back towards your feet and return to the starting position.",
    "calories": 0.86,
    "perMinute": false,
    "hintsForBeginners":
        "Start with a slight bend in your knees if you have tight hamstrings. Focus on maintaining a flat back as you walk your hands out and in. Engage your core to stabilize your body and prevent your hips from sagging.",
    "image": "assets/images/workoutImages/Inchworms.jpg",
    "video": "assets/videos/Inchworms.mp4",
    "xp": 1.0,
  },
  "single leg circle": {
    "info":
        "Single leg circle is a Pilates exercise that targets the core, hips, and thighs. Begin lying on your back with your arms by your sides and your legs extended straight up towards the ceiling. Lower one leg towards the ground in a circular motion, then bring it back up to the starting position. Repeat the motion in the opposite direction, then switch legs.",
    "calories": 0.5,
    "perMinute": false,
    "hintsForBeginners":
        "Start with small circles and focus on maintaining control throughout the movement. Keep your core engaged and your lower back pressed into the mat. Keep your shoulders relaxed and avoid arching your back.",
    "image": "assets/images/workoutImages/InclinedPushups.jpg",
    "xp": 1.0,
  },
  "dynamic rollouts": {
    "info":
        "Dynamic rollouts are an advanced core exercise that targets the abs, shoulders, and lower back. They involve kneeling on the ground and rolling a wheel or ball out in front of you while maintaining a straight body position. Begin kneeling on the ground with your hands gripping a wheel or ball in front of you. Roll the wheel or ball out in front of you as far as you can while maintaining a straight body position, then roll it back in towards your knees.",
    "calories": 0.75,
    "perMinute": false,
    "hintsForBeginners":
        "Start with a smaller range of motion and gradually increase the distance you roll out as you build strength. Engage your core muscles to prevent your lower back from arching. Focus on breathing rhythmically throughout the exercise to maintain control.",
    "image": "assets/images/workoutImages/InclinedPushups.jpg",
    "xp": 1.0,
  },
};
