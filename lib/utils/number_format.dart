class NumberFormat {
  static String formatAmount(String price) {
    String priceInText = "";
    int counter = 0;
    for (int i = (price.length - 1); i >= 0; i--) {
      counter++;
      String str = price[i];
      if ((counter % 3) != 0 && i != 0) {
        priceInText = "$str$priceInText";
      } else if (i == 0) {
        priceInText = "$str$priceInText";
      } else {
        priceInText = ".$str$priceInText";
      }
    }
    return priceInText.trim();
  }

  static String formatSale(int price, int sale) {
    return "${((1 - sale / price) * 100).ceil()}%";
  }
}
