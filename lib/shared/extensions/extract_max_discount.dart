String? extractMaxDiscount(String title) {
  final matches = RegExp(r'(\d+(?:[.,]\d+)?)%').allMatches(title);

  if (matches.isEmpty) {
    return null;
  }

  final maxMatch = matches.reduce((a, b) {
    final aValue = double.parse(a.group(1)!.replaceAll(',', '.'));
    final bValue = double.parse(b.group(1)!.replaceAll(',', '.'));

    return aValue >= bValue ? a : b;
  });

  return maxMatch.group(0);
}
