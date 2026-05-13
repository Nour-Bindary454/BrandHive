import 'package:brand/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../data_sources/address_remote_data_source.dart';
import '../models/address_model.dart';

class AddressRepository {
  final AddressRemoteDataSource _remoteDataSource;

  AddressRepository(this._remoteDataSource);

  Future<Either<Failure, List<AddressModel>>> getAllAddresses() async {
    try {
      final addresses = await _remoteDataSource.getAllAddresses();
      return Right(addresses);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, AddressModel>> getAddress(String id) async {
    try {
      final address = await _remoteDataSource.getAddress(id);
      return Right(address);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, AddressModel>> addAddress(AddressModel address) async {
    try {
      final newAddress = await _remoteDataSource.addAddress(address);
      return Right(newAddress);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, AddressModel>> updateAddress(AddressModel address) async {
    try {
      final updatedAddress = await _remoteDataSource.updateAddress(address);
      return Right(updatedAddress);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, void>> deleteAddress(String id) async {
    try {
      await _remoteDataSource.deleteAddress(id);
      return const Right(null);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, double>> getShippingFee(String governorate) async {
    try {
      final fee = await _remoteDataSource.getShippingFee(governorate);
      return Right(fee);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }
}
