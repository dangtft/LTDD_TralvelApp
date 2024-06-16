class HotelBooking {
  //int bookingId;
  int userId;
  int roomId;
  DateTime checkInDate;
  DateTime checkOutDate;
  String status;

  HotelBooking({
    //required this.bookingId,
    required this.userId,
    required this.roomId,
    required this.checkInDate,
    required this.checkOutDate,
    required this.status,
  });

  factory HotelBooking.fromJson(Map<String, dynamic> json) {
    return HotelBooking(
      //bookingId: json['bookingId'],
      userId: json['userId'],
      roomId: json['roomId'],
      checkInDate: DateTime.parse(json['checkInDate']),
      checkOutDate: DateTime.parse(json['checkOutDate']),
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      //'bookingId': bookingId,
      'userId': userId,
      'roomId': roomId,
      'checkInDate': checkInDate.toIso8601String(),
      'checkOutDate': checkOutDate.toIso8601String(),
      'status': status,
    };
  }
}
