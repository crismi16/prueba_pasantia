class CardModel {
  final int id;
  final String name;
  final String type;
  final String desc;
  final String imageUrl;
  final String? archetype;

  CardModel({
    required this.id,
    required this.name,
    required this.type,
    required this.desc,
    required this.imageUrl,
    this.archetype,
  });

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      id: json['id'],
      name: json['name'] ?? 'Unknown', 
      type: json['type'] ?? 'Unknown', 
      desc: json['desc'] ?? 'No description available', 
      imageUrl: json['card_images'][0]['image_url'] ?? 'https://via.placeholder.com/150',
      archetype: json['archetype'],
    );
  }
}
