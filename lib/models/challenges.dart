class Challenges {
  Challenges(this.title, this.duration, this.type, this.iscompleted,
      this.daysCompleted);
  String title;
  int duration; //  in days
  String type;
  int iscompleted;
  int daysCompleted; //0 for not started, 1 for ongoing, 2 for completed
}
