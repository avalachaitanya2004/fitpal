import random
exercise_dict = {
    "corkscrew": {
        "info": "Corkscrew is a core exercise that targets your abdominal muscles and improves spinal flexibility. It involves lying on your back with arms by your sides and lifting your legs towards the ceiling. Keeping your legs straight, lower them to one side in a circular motion, then bring them back up and lower them to the other side, forming a 'corkscrew' motion.",
        "calories": 6,
        "perMinute": True,
        "hintsForBeginners": "Start with small, controlled movements to avoid straining your back. Focus on engaging your core muscles throughout the exercise. Keep your shoulders relaxed and use your core to initiate the movement."
    },
    "alternating plank": {
        "info": "Alternating plank is a full-body exercise that strengthens your core, shoulders, and arms. Begin in a plank position with your hands directly under your shoulders and your body in a straight line from head to heels. Lift one arm off the ground and touch your opposite shoulder, then return to the starting position and repeat with the other arm.",
        "calories": 4,
        "perMinute": True,
        "hintsForBeginners": "Begin with a modified plank by resting on your knees instead of your toes. Keep your body in a straight line from head to knees. Engage your core to stabilize your body as you lift each arm."
    },
    "tricep dips": {
        "info": "Tricep dips target the triceps, shoulders, and chest muscles. It involves lowering and raising your body using a stable surface like a chair or bench. Sit on the edge of the chair with your hands gripping the edge. Walk your feet forward and lift your hips off the chair. Bend your elbows to lower your body towards the ground, then straighten your arms to lift yourself back up.",
        "calories": 0.0115,
        "perMinute": False,
        "hintsForBeginners": "Keep your elbows close to your body and your back close to the surface you're dipping on. Start with shallow dips and gradually increase your range of motion as you build strength. Focus on using your triceps to lift your body."
    },
    "inclined pushups": {
        "info": "Inclined pushups are a modification of traditional pushups that are easier for beginners. They target the chest, shoulders, and triceps. Place your hands on an elevated surface like a bench or countertop, slightly wider than shoulder-width apart. Lower your chest towards the surface by bending your elbows, then push through your palms to return to the starting position.",
        "calories": 5,
        "perMinute": True,
        "hintsForBeginners": "Use an elevated surface like a bench or countertop to perform inclined pushups. Keep your body in a straight line from head to heels and lower your chest toward the surface. Focus on maintaining proper form and gradually increase the depth of your pushup as you get stronger."
    },
    "prisoners squat": {
        "info": "Prisoners squat is a lower body exercise that targets the quads, glutes, and hamstrings. It involves squatting down with your hands clasped behind your head. Stand with your feet shoulder-width apart and your hands clasped behind your head. Squat down by bending your knees and pushing your hips back, then return to the starting position by straightening your legs.",
        "calories": 10.5,
        "perMinute": True,
        "hintsForBeginners": "Start with a wider stance and focus on keeping your knees aligned with your toes as you squat down. Keep your chest up and back straight throughout the movement. Engage your core to stabilize your body and prevent your knees from collapsing inward."
    },
    "running burpees": {
        "info": "Running burpees are a high-intensity full-body exercise that combines a squat, plank, pushup, and jump. They improve cardiovascular fitness and strength. Begin in a standing position, then squat down and place your hands on the ground. Jump or step your feet back into a plank position, perform a pushup, then jump or step your feet forward and explode up into a jump.",
        "calories": 10,
        "perMinute": True,
        "hintsForBeginners": "Begin with a modified version by stepping back into the plank position instead of jumping. Focus on maintaining proper form and gradually increase your speed as you get comfortable. Engage your core throughout the exercise to stabilize your body."
    },
    "twisted mountain climber": {
        "info": "Twisted mountain climber is a core and cardio exercise that targets the obliques, abs, and shoulders. Begin in a plank position with your hands directly under your shoulders and your body in a straight line from head to heels. Bring one knee towards the opposite elbow while twisting your torso, then return to the starting position and repeat on the other side.",
        "calories": 12,
        "perMinute": True,
        "hintsForBeginners": "Start with slow, controlled movements to get the form right. Keep your core engaged and your hips stable throughout the exercise. Focus on bringing your knee towards your elbow while maintaining a straight back."
    },
    "shoulder tap": {
        "info": "Shoulder tap is a core stabilization exercise that targets the abs, shoulders, and arms. Begin in a plank position with your hands directly under your shoulders and your body in a straight line from head to heels. Lift one hand off the ground and touch your opposite shoulder, then return to the starting position and repeat with the other hand.",
        "calories": 0.87,
        "perMinute": False,
        "hintsForBeginners": "Begin with a wider stance to improve balance and stability. Focus on keeping your hips steady and your core engaged as you tap each shoulder. Avoid rocking your hips from side to side."
    },
    "kneeled narrow pushup": {
        "info": "Kneeled narrow pushup is a modified version of the narrow pushup that targets the triceps and chest. It's suitable for beginners who may not have the strength to perform regular pushups. Begin on your hands and knees with your hands directly under your shoulders and your knees hip-width apart. Lower your chest towards the ground by bending your elbows, then push through your palms to return to the starting position.",
        "calories": 10,
        "perMinute": True,
        "hintsForBeginners": "Kneel on a mat or soft surface to reduce pressure on your knees. Keep your elbows close to your body as you lower yourself down, and push through your palms to return to the starting position. Engage your core throughout the exercise to maintain proper form."
    },
    "butt kicks": {
        "info": "Butt kicks are a dynamic warm-up exercise that targets the quadriceps and hamstrings. They involve quickly bringing your heels up towards your glutes while jogging in place. Begin by jogging in place, then focus on kicking your heels up towards your glutes with each step.",
        "calories": 0.075,
        "perMinute": False,
        "hintsForBeginners": "Start with a slow pace and gradually increase your speed as you warm up. Focus on bringing your heels as close to your glutes as possible with each kick. Keep your upper body relaxed and your arms swinging naturally."
    },
    "pulse rows": {
        "info": "Pulse rows are a back-strengthening exercise that targets the upper back and shoulders. They involve pulling weights or resistance bands towards your body in a rowing motion with short pulses at the top of the movement. Stand with your feet hip-width apart and hold a weight or resistance band in each hand. Bend your knees slightly and hinge forward at the hips, keeping your back flat. Pull the weights or bands towards your body, squeezing your shoulder blades together, then pulse at the top of the movement before returning to the starting position.",
        "calories": 0.45,
        "perMinute": False,
        "hintsForBeginners": "Start with light weights or resistance bands to avoid straining your muscles. Focus on squeezing your shoulder blades together with each repetition to engage the upper back muscles. Keep your core engaged and your back flat throughout the exercise."
    },
    "seal pushups": {
        "info": "Seal pushups are a variation of traditional pushups that target the chest, shoulders, and triceps. They involve a wider hand placement and a rhythmic pulsing motion at the bottom of the pushup. Begin in a plank position with your hands slightly wider than shoulder-width apart. Lower your chest towards the ground by bending your elbows, then push through your palms to return to the starting position while pulsing your chest up and down.",
        "calories": 0.81,
        "perMinute": False,
        "hintsForBeginners": "Begin with a modified version on your knees to build strength. Keep your core engaged and your body in a straight line from head to knees throughout the exercise. Focus on maintaining a controlled rhythm as you pulse at the bottom of the pushup."
    },
    "scapular pushups": {
        "info": "Scapular pushups are a shoulder-strengthening exercise that targets the muscles around the shoulder blades. Begin in a plank position with your hands directly under your shoulders and your body in a straight line from head to heels. Lower your chest towards the ground by protracting your shoulder blades, then push through your palms to return to the starting position while retracting your shoulder blades.",
        "calories": 8,
        "perMinute": True,
        "hintsForBeginners": "Focus on moving the shoulder blades smoothly and controlled. Keep your core engaged and avoid shrugging your shoulders towards your ears. Start with a small range of motion and gradually increase as you build strength."
    },
    "reverse snow angels": {
        "info": "Reverse snow angels are a back and shoulder exercise that targets the muscles of the upper back and shoulders. Begin lying face down on the ground with your arms extended out to the sides and your palms facing down. Lift your chest and arms off the ground while squeezing your shoulder blades together, then lower them back down to the starting position.",
        "calories": 4.73,
        "perMinute": True,
        "hintsForBeginners": "Start with small movements and focus on squeezing your shoulder blades together as you lift your arms. Keep your neck in a neutral position to avoid straining your neck muscles. Engage your core to stabilize your body throughout the exercise."
    },
    "mountain runner": {
        "info": "Mountain runners are a high-intensity cardio exercise that mimics the motion of running in place. They engage the core, legs, and cardiovascular system. Begin in a plank position with your hands directly under your shoulders and your body in a straight line from head to heels. Quickly alternate bringing your knees towards your chest while maintaining a fast-paced rhythm.",
        "calories": 7.5,
        "perMinute": True,
        "hintsForBeginners": "Start with a slow pace and focus on maintaining proper form. Keep your core engaged and your knees lifted towards your chest with each step. Focus on breathing rhythmically to maintain endurance."
    },
    "diamond pushups": {
        "info": "Diamond pushups are a challenging variation of traditional pushups that target the triceps, chest, and shoulders. They involve placing your hands close together in a diamond shape beneath your chest. Begin in a plank position with your hands close together and your thumbs and index fingers forming a diamond shape. Lower your chest towards your hands by bending your elbows, then push through your palms to return to the starting position.",
        "calories": 0.4,
        "perMinute": False,
        "hintsForBeginners": "Begin with a modified version on your knees or an elevated surface to reduce the intensity. Keep your elbows close to your body and lower your chest towards your hands in a controlled motion. Engage your core to maintain stability throughout the exercise."
    },
    "inchworm": {
        "info": "Inchworm is a full-body exercise that targets the core, shoulders, and hamstrings. Begin standing with your feet hip-width apart. Bend forward at the waist and place your hands on the ground, then walk them out into a plank position. Hold for a moment, then walk your hands back towards your feet and return to the starting position.",
        "calories": 0.86,
        "perMinute": False,
        "hintsForBeginners": "Start with a slight bend in your knees if you have tight hamstrings. Focus on maintaining a flat back as you walk your hands out and in. Engage your core to stabilize your body and prevent your hips from sagging."
    },
    "single leg circle": {
        "info": "Single leg circle is a Pilates exercise that targets the core, hips, and thighs. Begin lying on your back with your arms by your sides and your legs extended straight up towards the ceiling. Lower one leg towards the ground in a circular motion, then bring it back up to the starting position. Repeat the motion in the opposite direction, then switch legs.",
        "calories": 0.5,
        "perMinute": False,
        "hintsForBeginners": "Start with small circles and focus on maintaining control throughout the movement. Keep your core engaged and your lower back pressed into the mat. Keep your shoulders relaxed and avoid arching your back."
    },
    "dynamic rollouts": {
        "info": "Dynamic rollouts are an advanced core exercise that targets the abs, shoulders, and lower back. They involve kneeling on the ground and rolling a wheel or ball out in front of you while maintaining a straight body position. Begin kneeling on the ground with your hands gripping a wheel or ball in front of you. Roll the wheel or ball out in front of you as far as you can while maintaining a straight body position, then roll it back in towards your knees.",
        "calories": 0.75,
        "perMinute": False,
        "hintsForBeginners": "Start with a smaller range of motion and gradually increase the distance you roll out as you build strength. Engage your core muscles to prevent your lower back from arching. Focus on breathing rhythmically throughout the exercise to maintain control."
    }
}



def calculate_bmr(weight, height, age, gender):
    if gender.lower() == 'male':
        bmr = 66 + (13.7 * weight) + (5 * height) - (6.8 * age)
    elif gender.lower() == 'female':
        bmr = 655 + (9.6 * weight) + (1.8 * height) - (4.7 * age)
    else:
        return "Invalid gender input"
    return bmr

def calculate_calories_burnt(weight, height, age, gender, activity_level):
    bmr = calculate_bmr(weight, height, age, gender)
    activity_factors = [1.2,1.375,1.55,1.9]
    if activity_level not in range(4):
        return "Invalid activity level input"
    calorie_calculation = bmr * activity_factors[activity_level]
    return calorie_calculation
    
def balanced_exercise_predictor(calories_to_burn,weight):
    per_minute_exercises = [(ex, details) for ex, details in exercise_dict.items() if details['perMinute']]
    fixed_time_exercises = [(ex, details) for ex, details in exercise_dict.items() if not details['perMinute']]
    random.shuffle(per_minute_exercises)
    random.shuffle(fixed_time_exercises)
    exercises_to_do = []
    remaining_calories = calories_to_burn
    calories_for_per_minute = remaining_calories / 2
    calories_for_fixed_time = remaining_calories / 2
    for exercise, details in per_minute_exercises:
        if calories_for_per_minute <= 0:
            break
        calories_burnt_per_minute = details['calories']*weight
        max_minutes = min(2, calories_for_per_minute / calories_burnt_per_minute)
        if max_minutes > 0:
            exercises_to_do.append((exercise, round(max_minutes, 2)))
            calories_for_per_minute -= calories_burnt_per_minute * max_minutes
    for exercise, details in fixed_time_exercises:
        if calories_for_fixed_time <= 0:
            break
        exercise_calories = details['calories'] * 5
        if calories_for_fixed_time >= exercise_calories:
            exercises_to_do.append((exercise, 5))
            calories_for_fixed_time -= exercise_calories

    return exercises_to_do

def main():
    gender = input("Enter your gender (male/female): ")
    weight = float(input("Enter your weight in kilograms: "))
    height = float(input("Enter your height in centimeters: "))
    age = int(input("Enter your age in years: "))
    activity_level = int(input("Enter your activity level (sedentary/lightly active/moderately active/very active/extra active): "))
    calories_burnt = calculate_calories_burnt(weight, height, age, gender, activity_level)
    exercise_todo=balanced_exercise_predictor(calories_burnt,weight)
    print(calories_burnt)
    print(exercise_todo)

main()