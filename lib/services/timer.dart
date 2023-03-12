String currentTime() {
  DateTime now = DateTime.now();
  String date = "${now.day}/${now.month}/${now.year}";

  return date;
}
