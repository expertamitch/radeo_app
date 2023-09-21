extension StringExtension on String {
  String capitalizee() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}