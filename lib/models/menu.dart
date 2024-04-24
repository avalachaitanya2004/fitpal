import 'rive_model.dart';

class Menu {
  final String title;
  final RiveModel rive;

  Menu({required this.title, required this.rive});
}

List<Menu> bottomNavItems = [
  Menu(
    title: "Home",
    rive: RiveModel(
      src: "assets/RiveAssets/icons.riv",
      artboard: "HOME",
      stateMachineName: "HOME_interactivity",
    ),
  ),
  Menu(
    title: "Challenges",
    rive: RiveModel(
      src: "assets/RiveAssets/icons2.riv",
      artboard: "challenges",
      stateMachineName: "challenges_state",
    ),
  ),
  Menu(
    title: "Scan",
    rive: RiveModel(
      src: "assets/RiveAssets/icons3.riv",
      artboard: "scan_board",
      stateMachineName: "Scan_state",
    ),
  ),
  Menu(
    title: "Food",
    rive: RiveModel(
      src: "assets/RiveAssets/icons2.riv",
      artboard: "food",
      stateMachineName: "food_interactivity",
    ),
  ),
  Menu(
    title: "Exersices",
    rive: RiveModel(
      src: "assets/RiveAssets/icons3.riv",
      artboard: "challenges",
      stateMachineName: "challenges_state",
    ),
  ),
];
