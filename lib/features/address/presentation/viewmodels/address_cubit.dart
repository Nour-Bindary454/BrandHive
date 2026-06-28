import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/address_model.dart';
import '../../data/repository/address_repository.dart';
import 'address_state.dart';

class AddressCubit extends Cubit<AddressState> {
  final AddressRepository _repository;

  AddressCubit(this._repository) : super(AddressInitial());

  List<AddressModel> _currentAddresses = [];
  List<AddressModel> get currentAddresses => _currentAddresses;

  Future<void> fetchAllAddresses() async {
    emit(AddressLoading());
    final result = await _repository.getAllAddresses();
    result.fold(
      (failure) => emit(AddressError(failure.errMessage)),
      (addresses) {
        _currentAddresses = addresses;
        emit(AddressLoaded(addresses));
      },
    );
  }

  Future<void> addAddress(AddressModel address) async {
    emit(AddressActionLoading());
    final result = await _repository.addAddress(address);
    result.fold(
      (failure) => emit(AddressActionError(failure.errMessage)),
      (newAddress) {
        emit(const AddressActionSuccess('Address added successfully'));
        fetchAllAddresses();
      },
    );
  }

  Future<void> updateAddress(AddressModel address) async {
    emit(AddressActionLoading());
    final result = await _repository.updateAddress(address);
    result.fold(
      (failure) => emit(AddressActionError(failure.errMessage)),
      (updatedAddress) {
        emit(const AddressActionSuccess('Address updated successfully'));
        fetchAllAddresses();
      },
    );
  }

  Future<void> deleteAddress(String id) async {
    emit(AddressActionLoading());
    final result = await _repository.deleteAddress(id);
    result.fold(
      (failure) => emit(AddressActionError(failure.errMessage)),
      (_) {
        emit(const AddressActionSuccess('Address deleted successfully'));
        fetchAllAddresses();
      },
    );
  }

  Future<void> setDefaultAddress(String id) async {
    emit(AddressActionLoading());
    // Find the address
    final address = _currentAddresses.firstWhere((a) => a.id == id);
    // Create an updated version with isDefault = true
    final updatedAddress = address.copyWith(isDefault: true);
    
    final result = await _repository.updateAddress(updatedAddress);
    result.fold(
      (failure) => emit(AddressActionError(failure.errMessage)),
      (_) {
        emit(const AddressActionSuccess('Default address updated'));
        fetchAllAddresses();
      },
    );
  }

  Future<void> calculateShippingFee(String governorate) async {
    emit(AddressLoading());
    final result = await _repository.getShippingFee(governorate);
    result.fold(
      (failure) => emit(AddressError(failure.errMessage)),
      (fee) => emit(ShippingFeeLoaded(fee)),
    );
  }
}
