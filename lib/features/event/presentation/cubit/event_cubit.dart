import 'package:brand/features/event/domain/repository/event_repository.dart';
import 'package:brand/features/event/presentation/cubit/event_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventCubit extends Cubit<EventState> {
  final EventRepository _repo;

  EventCubit(this._repo) : super(EventInitial());

  Future<void> getFeaturedEvents() async {
    emit(EventsLoading());
    final result = await _repo.getFeaturedEvents();
    result.fold(
      (failure) => emit(EventsFailure(failure.errMessage)),
      (events) => emit(EventsSuccess(events)),
    );
  }

  Future<void> getBazaarEvents(String bazaarId) async {
    emit(EventsLoading());
    final result = await _repo.getBazaarEvents(bazaarId);
    result.fold(
      (failure) => emit(EventsFailure(failure.errMessage)),
      (events) => emit(EventsSuccess(events)),
    );
  }

  Future<void> getEventDetails(String eventId) async {
    emit(EventDetailsLoading());
    final result = await _repo.getEventDetails(eventId);
    result.fold(
      (failure) => emit(EventDetailsFailure(failure.errMessage)),
      (event) => emit(EventDetailsSuccess(event)),
    );
  }
}
