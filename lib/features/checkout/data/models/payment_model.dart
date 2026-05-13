enum PaymentMethodType {
  creditCard,
  cashOnDelivery,
}

class PaymentModel {
  final PaymentMethodType methodType;
  final String? cardNumber;
  final String? expiryDate;
  final String? cvv;

  PaymentModel({
    required this.methodType,
    this.cardNumber,
    this.expiryDate,
    this.cvv,
  });
  
  String get displayMethodName {
    switch (methodType) {
      case PaymentMethodType.creditCard:
        return 'Credit/Debit Card';
      case PaymentMethodType.cashOnDelivery:
        return 'Cash on Delivery';
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'methodType': methodType.toString(),
      'cardNumber': cardNumber,
      'expiryDate': expiryDate,
      'cvv': cvv,
    };
  }
}
