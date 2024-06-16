class Room {
  int roomId;
  String roomName;
  String roomSize;
  String imageUrl;
  double price;
  int hotelId;
  String contact;
  String promoCode;
  String status;
  int rating;

  Room({
    required this.roomId,
    required this.roomName,
    required this.roomSize,
    required this.imageUrl,
    required this.price,
    required this.hotelId,
    required this.contact,
    required this.promoCode,
    required this.status,
    required this.rating
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      roomId: json['roomId'],
      roomName: json['roomName'],
      roomSize: json['roomSize'],
      imageUrl: json['imageUrl'],
      price: json['price'].toDouble(),
      hotelId: json['hotelId'],
      contact: json['contact'],
      promoCode: json['promoCode'],
      status: json['status'],
      rating: json['rating']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'roomId': roomId,
      'roomName': roomName,
      'roomSize': roomSize,
      'imageUrl': imageUrl,
      'price': price,
      'hotelId': hotelId,
      'contact': contact,
      'promoCode': promoCode,
      'status': status,
      'rating': rating
    };
  }
}
