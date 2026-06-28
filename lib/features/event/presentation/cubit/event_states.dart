import 'package:brand/features/event/data/models/event_model.dart';

abstract class EventState {}

class EventInitial extends EventState {}

class EventsLoading extends EventState {}
class EventsSuccess extends EventState {
  final List<EventModel> events;
  EventsSuccess(this.events);
}
class EventsFailure extends EventState {
  final String message;
  EventsFailure(this.message);
}

class EventDetailsLoading extends EventState {}
class EventDetailsSuccess extends EventState {
  final EventModel event;
  EventDetailsSuccess(this.event);
}
class EventDetailsFailure extends EventState {
  final String message;
  EventDetailsFailure(this.message);
}
