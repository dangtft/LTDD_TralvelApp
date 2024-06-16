class HotelPayment {
  int paymentId;
  int bookingId;
  double totalPrice;
  DateTime paymentDate;
  String paymentMethod;

  HotelPayment({
    required this.paymentId,
    required this.bookingId,
    required this.totalPrice,
    required this.paymentDate,
    required this.paymentMethod,
  });

  factory HotelPayment.fromJson(Map<String, dynamic> json) {
    return HotelPayment(
      paymentId: json['paymentId'],
      bookingId: json['bookingId'],
      totalPrice: json['totalPrice'],
      paymentDate: DateTime.parse(json['paymentDate']),
      paymentMethod: json['paymentMethod'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'paymentId': paymentId,
      'bookingId': bookingId,
      'totalPrice': totalPrice,
      'paymentDate': paymentDate.toIso8601String(),
      'paymentMethod': paymentMethod,
    };
  }
}
