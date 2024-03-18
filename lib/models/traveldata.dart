class Landmark {
  List<String> likers;
  String imageUrl;
  int price;
  String location;
  List<String> registrants;
  int id;
  String description;
  String name;

  Landmark({
    required this.likers,
    required this.imageUrl,
    required this.price,
    required this.location,
    required this.registrants,
    required this.id,
    required this.description,
    required this.name,
  });

  factory Landmark.fromJson(Map<String, dynamic> json) {
    return Landmark(
      likers: List<String>.from(json['beğenenler']),
      imageUrl: json['resim'],
      price: json['ücreti'],
      location: json['konumu'],
      registrants: List<String>.from(json['kayıtlılar']),
      id: json['id'],
      description: json['hakkında'],
      name: json['isim'],
    );
  }
}
