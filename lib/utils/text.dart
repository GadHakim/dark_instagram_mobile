String trimStringToMaxChart(String str, {int maxChart = 12}) {
  if (maxChart <= 2) {
    throw Exception('The maximum number of characters must be greater than 2.');
  }

  StringBuffer buffer = StringBuffer();
  if (str.length <= maxChart) {
    return str;
  }

  for (var i = 0; i < maxChart - 1; i++) {
    String s = str[i];
    buffer.write(s);
  }
  buffer.write('..');

  return buffer.toString();
}
