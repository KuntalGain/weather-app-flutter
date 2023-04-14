// Format the current time into DD/MM/YYYY format

String currentTime() {
  DateTime now = DateTime.now();
  String date = "${now.day}/${now.month}/${now.year}";

  return date;
}
