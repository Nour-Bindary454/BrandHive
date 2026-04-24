class BazaarDetailsModel {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String date;
  final String time;
  final String location;
  final String phone;
  final String whatsapp;
  final String organizer;
  final List<String> additionalDetails;
  final List<UpcomingDateModel> upcomingDates;
  final List<ParticipatingBrandModel> participatingBrands;
  final List<String> eventHighlights;

  BazaarDetailsModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.date,
    required this.time,
    required this.location,
    required this.phone,
    required this.whatsapp,
    required this.organizer,
    required this.additionalDetails,
    required this.upcomingDates,
    required this.participatingBrands,
    required this.eventHighlights,
  });
}

class UpcomingDateModel {
  final String id;
  final String dateRange;
  final String fullDateString;
  final String status;

  UpcomingDateModel({
    required this.id,
    required this.dateRange,
    required this.fullDateString,
    required this.status,
  });
}

class ParticipatingBrandModel {
  final String id;
  final String name;
  final bool isFeatured;

  ParticipatingBrandModel({
    required this.id,
    required this.name,
    this.isFeatured = false,
  });
}
