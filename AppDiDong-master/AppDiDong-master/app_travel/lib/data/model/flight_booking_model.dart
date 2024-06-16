class FlightBooking {
  int flightBookingId;
  int userId;
  int flightId;
  DateTime bookingDate;
  String status;

  FlightBooking({
    required this.flightBookingId,
    required this.userId,
    required this.flightId,
    required this.bookingDate,
    required this.status,
  });

  factory FlightBooking.fromJson(Map<String, dynamic> json) {
    return FlightBooking(
      flightBookingId: json['flightBookingId'],
      userId: json['userId'],
      flightId: json['flightId'],
      bookingDate: DateTime.parse(json['bookingDate']),
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'flightBookingId': flightBookingId,
      'userId': userId,
      'flightId': flightId,
      'bookingDate': bookingDate.toIso8601String(),
      'status': status,
    };
  }
}
