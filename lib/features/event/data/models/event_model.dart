class EventModel {
  final String id;
  final String title;
  final String description;
  final String date;
  final String time;
  final String location;
  final String organizer;
  final String? imageUrl;
  final String? bazaarId;

  EventModel({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.location,
    required this.organizer,
    this.imageUrl,
    this.bazaarId,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['_id'] ?? json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      date: json['date'] ?? '',
      time: json['time'] ?? '10:00 AM - 10:00 PM',
      location: json['location'] ?? '',
      organizer: json['organizer'] ?? 'Organizer',
      imageUrl: json['imageUrl'] ?? json['image'],
      bazaarId: json['bazaarId'] ?? json['bazaar'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date,
      'time': time,
      'location': location,
      'organizer': organizer,
      'imageUrl': imageUrl,
      'bazaarId': bazaarId,
    };
  }
}
