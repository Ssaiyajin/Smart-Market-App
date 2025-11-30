extension DateTimeExtension on DateTime {
  String toLocalDate() {
    return '$day.$month.$year';
  }
}
