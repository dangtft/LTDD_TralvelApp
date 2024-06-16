class Hotel {
  int hotelId;
  String hotelName;
  String imageUrl;
  String location;
  double price;
  int rating;
  bool isLike;
  String information;

  Hotel({
    required this.hotelId,
    required this.hotelName,
    required this.imageUrl,
    required this.location,
    required this.price,
    required this.rating,
    required this.isLike,
    required this.information,
  });

  factory Hotel.fromJson(Map<String, dynamic> json) {
    return Hotel(
      hotelId: json['hotelId'],
      hotelName: json['hotelName'],
      imageUrl: json['imageUrl'],
      location: json['location'],
      price: json['price'],
      rating: json['rating'],
      isLike: json['isLike'],
      information: json['information'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'hotelId': hotelId,
      'hotelName': hotelName,
      'imageUrl': imageUrl,
      'location': location,
      'price': price,
      'rating': rating,
      'isLike': isLike,
      'information': information,
    };
  }
}
