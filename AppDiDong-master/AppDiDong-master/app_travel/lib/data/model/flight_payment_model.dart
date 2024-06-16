class FlightPayment {
  int paymentId;
  int flightBookingId;
  double totalPrice;
  DateTime paymentDate;
  String paymentMethod;

  FlightPayment({
    required this.paymentId,
    required this.flightBookingId,
    required this.totalPrice,
    required this.paymentDate,
    required this.paymentMethod,
  });

  factory FlightPayment.fromJson(Map<String, dynamic> json) {
    return FlightPayment(
      paymentId: json['paymentId'],
      flightBookingId: json['flightBookingId'],
      totalPrice: json['totalPrice'],
      paymentDate: DateTime.parse(json['paymentDate']),
      paymentMethod: json['paymentMethod'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'paymentId': paymentId,
      'flightBookingId': flightBookingId,
      'totalPrice': totalPrice,
      'paymentDate': paymentDate.toIso8601String(),
      'paymentMethod': paymentMethod,
    };
  }
}
