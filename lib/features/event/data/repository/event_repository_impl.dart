import 'package:brand/core/errors/failure.dart';
import 'package:brand/core/services/api_services.dart';
import 'package:brand/features/event/data/models/event_model.dart';
import 'package:brand/features/event/domain/repository/event_repository.dart';
import 'package:dartz/dartz.dart';

class EventRepositoryImpl implements EventRepository {
  final ApiService apiService;

  EventRepositoryImpl(this.apiService);

  final List<EventModel> _mockEvents = [
    EventModel(
      id: 'e1',
      title: 'Cairo Artisan Bazaar',
      description: 'Experience Cairo’s premier handcraft bazaar featuring Nilotic weavers and traditional pottery workshops.',
      date: 'Dec 15-17',
      time: '10:00 AM - 10:00 PM',
      location: 'Khan El Khalili, Cairo',
      organizer: 'Egyptian Ministry of Tourism',
      imageUrl: 'https://images.unsplash.com/photo-1610701596007-11502861dcfa?q=80&w=600&auto=format&fit=crop',
    ),
    EventModel(
      id: 'e2',
      title: 'Ramadan Craft Fair',
      description: 'Celebrate the holy month with authentic Ramadan lanterns, handcrafted pottery, and local garments.',
      date: 'Feb 10-14',
      time: '12:00 PM - Midnight',
      location: 'Zamalek District, Cairo',
      organizer: 'Cairo Cultural Association',
      imageUrl: 'https://images.unsplash.com/photo-1545128485-c400e7702796?q=80&w=600&auto=format&fit=crop',
    ),
  ];

  @override
  Future<Either<Failure, List<EventModel>>> getFeaturedEvents() async {
    try {
      await Future.delayed(const Duration(milliseconds: 300));
      return right(_mockEvents);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<EventModel>>> getBazaarEvents(String bazaarId) async {
    try {
      await Future.delayed(const Duration(milliseconds: 300));
      return right(_mockEvents);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, EventModel>> getEventDetails(String eventId) async {
    try {
      await Future.delayed(const Duration(milliseconds: 300));
      final found = _mockEvents.where((e) => e.id == eventId);
      if (found.isNotEmpty) {
        return right(found.first);
      }
      return left(ServerFailure('Event not found'));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
