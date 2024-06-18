class HotelBookingDTO {
  final int userId;
  final int? roomId;
  final DateTime? checkInDate;
  final DateTime? checkOutDate;
  final String? status;
  final String? hotelName;
  final String? hotelImageUrl;
  final String? roomName;
  final String? roomImage;
  final double? price;

  HotelBookingDTO({
    required this.userId,
    this.roomId,
    this.checkInDate,
    this.checkOutDate,
    this.status,
    this.hotelName,
    this.hotelImageUrl,
    this.roomName,
    this.roomImage,
    this.price
  });

  factory HotelBookingDTO.fromJson(Map<String, dynamic> json) {
    return HotelBookingDTO(
      userId: json['userId'],
      roomId: json['roomId'],
      checkInDate: json['checkInDate'] != null ? DateTime.parse(json['checkInDate']) : null,
      checkOutDate: json['checkOutDate'] != null ? DateTime.parse(json['checkOutDate']) : null,
      status: json['status'],
      hotelName: json['hotelName'],
      hotelImageUrl: json['hotelImageUrl'],
      roomName: json['roomName'],
      roomImage: json['roomImage'],
      price: json['price']
    );
  }
}