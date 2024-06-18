class FlightBookingDTO {
  final int userId;
  final int? flightId;
  final DateTime? bookingDate;
  final String? status;
  final String? flightName;
  final String? flightImageUrl;

  FlightBookingDTO({
    required this.userId,
    this.flightId,
    this.bookingDate,
    this.status,
    this.flightName,
    this.flightImageUrl,
  });

  factory FlightBookingDTO.fromJson(Map<String, dynamic> json) {
    return FlightBookingDTO(
      userId: json['userId'],
      flightId: json['flightId'],
      bookingDate: json['bookingDate'] != null ? DateTime.parse(json['bookingDate']) : null,
      status: json['status'],
      flightName: json['flightName'],
      flightImageUrl: json['flightImageUrl'],
    );
  }
}