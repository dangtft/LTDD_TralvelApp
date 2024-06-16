class Flight {
  int flightId;
  String flightName;
  String imageUrl;
  String location;
  String destination;
  int dayFlight;
  DateTime departureTime;
  double price;
  int ticket;

  Flight({
    required this.flightId,
    required this.flightName,
    required this.imageUrl,
    required this.location,
    required this.destination,
    required this.dayFlight,
    required this.departureTime,
    required this.price,
    required this.ticket,
  });

  factory Flight.fromJson(Map<String, dynamic> json) {
    return Flight(
      flightId: json['flightId'],
      flightName: json['flightName'],
      imageUrl: json['imageUrl'],
      location: json['location'],
      destination: json['destination'],
      dayFlight: json['dayFlight'],
      departureTime: DateTime.parse(json['departureTime']),
      price: json['price'],
      ticket: json['ticket'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'flightId': flightId,
      'flightName': flightName,
      'imageUrl': imageUrl,
      'location': location,
      'destination': destination,
      'dayFlight': dayFlight,
      'departureTime': departureTime.toIso8601String(),
      'price': price,
      'ticket': ticket,
    };
  }
}
