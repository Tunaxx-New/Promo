String currencyName(int? currency) {
  switch (currency) {
    case 398:
      return '₸';
    case 840:
      return r'$';
    case 978:
      return '€';
    case 643:
      return '₽';
    default:
      return '';
  }
}
