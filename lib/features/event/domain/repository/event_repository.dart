import 'package:brand/core/errors/failure.dart';
import 'package:brand/features/event/data/models/event_model.dart';
import 'package:dartz/dartz.dart';

abstract class EventRepository {
  Future<Either<Failure, List<EventModel>>> getFeaturedEvents();
  Future<Either<Failure, List<EventModel>>> getBazaarEvents(String bazaarId);
  Future<Either<Failure, EventModel>> getEventDetails(String eventId);
}
