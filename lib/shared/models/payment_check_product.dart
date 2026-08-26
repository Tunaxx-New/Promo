class PaymentCheckProduct {
  final String id;
  final int index;
  final String name;
  final double price;
  final double amount;
  final double bonus;

  const PaymentCheckProduct({
    required this.id,
    required this.index,
    required this.name,
    required this.price,
    required this.amount,
    required this.bonus,
  });

  factory PaymentCheckProduct.fromJson(Map<String, dynamic> json) {
    return PaymentCheckProduct(
      id: json['id'] as String,
      index: json['index'] as int,
      name: json['name'] as String,
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
      bonus: (json['bonus'] as num?)?.toDouble() ?? 0.0,
    );
  }

  double get total => amount * price;
}
