import 'package:equatable/equatable.dart';
import '../../data/models/address_model.dart';

abstract class AddressState extends Equatable {
  const AddressState();

  @override
  List<Object?> get props => [];
}

class AddressInitial extends AddressState {}

class AddressLoading extends AddressState {}

class AddressLoaded extends AddressState {
  final List<AddressModel> addresses;

  const AddressLoaded(this.addresses);

  @override
  List<Object?> get props => [addresses];
}

class AddressError extends AddressState {
  final String message;

  const AddressError(this.message);

  @override
  List<Object?> get props => [message];
}

class AddressActionLoading extends AddressState {}

class AddressActionSuccess extends AddressState {
  final String message;
  final AddressModel? address;

  const AddressActionSuccess(this.message, {this.address});

  @override
  List<Object?> get props => [message, address];
}

class AddressActionError extends AddressState {
  final String message;

  const AddressActionError(this.message);

  @override
  List<Object?> get props => [message];
}

class ShippingFeeLoaded extends AddressState {
  final double fee;

  const ShippingFeeLoaded(this.fee);

  @override
  List<Object?> get props => [fee];
}
