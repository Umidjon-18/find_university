class InputFormatter {
  String formatCountry(String country) {
    String formattedString = country.trim().replaceAll(RegExp(r' '), '+');
    return formattedString;
  }
}
