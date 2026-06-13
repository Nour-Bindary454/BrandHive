import 'package:brand/features/bazaar/data/models/bazaar_model.dart';

abstract class BazaarState {}

class BazaarInitial extends BazaarState {}

// My Bazaar management
class MyBazaarLoading extends BazaarState {}
class MyBazaarSuccess extends BazaarState {
  final BazaarModel bazaar;
  MyBazaarSuccess(this.bazaar);
}
class MyBazaarFailure extends BazaarState {
  final String message;
  MyBazaarFailure(this.message);
}

// Bazaars listing & search
class BazaarsLoading extends BazaarState {}
class BazaarsSuccess extends BazaarState {
  final List<BazaarModel> bazaars;
  final bool hasReachedMax;
  BazaarsSuccess(this.bazaars, {this.hasReachedMax = false});
}
class BazaarsFailure extends BazaarState {
  final String message;
  BazaarsFailure(this.message);
}

// Update Bazaar
class BazaarUpdateLoading extends BazaarState {}
class BazaarUpdateSuccess extends BazaarState {
  final BazaarModel bazaar;
  final String message;
  BazaarUpdateSuccess(this.bazaar, this.message);
}
class BazaarUpdateFailure extends BazaarState {
  final String message;
  BazaarUpdateFailure(this.message);
}

// Announcement
class AnnouncementLoading extends BazaarState {}
class AnnouncementSuccess extends BazaarState {
  final String message;
  AnnouncementSuccess(this.message);
}
class AnnouncementFailure extends BazaarState {
  final String message;
  AnnouncementFailure(this.message);
}

// Toggle status
class BazaarToggleLoading extends BazaarState {}
class BazaarToggleSuccess extends BazaarState {
  final String id;
  BazaarToggleSuccess(this.id);
}
class BazaarToggleFailure extends BazaarState {
  final String message;
  BazaarToggleFailure(this.message);
}
