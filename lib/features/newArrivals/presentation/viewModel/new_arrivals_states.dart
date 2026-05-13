abstract class NewArrivalsState {}

class NewArrivalsInitial extends NewArrivalsState {}

class NewArrivalsLoading extends NewArrivalsState {}

class NewArrivalsSuccess extends NewArrivalsState {
  final List products;

  NewArrivalsSuccess(this.products);
}

class NewArrivalsError extends NewArrivalsState {
  final String error;

  NewArrivalsError(this.error);
}
