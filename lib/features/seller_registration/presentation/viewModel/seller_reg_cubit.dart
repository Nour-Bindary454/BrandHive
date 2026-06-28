import 'dart:io';

import 'package:brand/core/errors/failure.dart';
import 'package:brand/features/seller_registration/data/model/category_model.dart';
import 'package:brand/features/seller_registration/data/repository/seller_reg_repo.dart';
import 'package:brand/features/seller_registration/presentation/viewModel/seller_reg_states.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BrandRequestCubit extends Cubit<BrandRequestState> {
  final BrandRequestRepo repo;

  List<CategoryModel> categories = [];

  BrandRequestCubit(this.repo) : super(BrandRequestInitial()) {
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    emit(CategoriesLoading());
    try {
      categories = await repo.getCategories();
      emit(CategoriesLoaded(categories));
    } on DioException catch (e) {
      final failure = ServerFailure.fromDioError(e);
      emit(CategoriesFailure(failure.errMessage));
    } catch (e) {
      emit(CategoriesFailure(e.toString()));
    }
  }

  Future<void> sendRequest({
    required String name,
    required String description,
    required String country,
    required String city,
    required String phone,
    List<String>? categories,
    String? website,
    String? whatsappLink,
    required bool shipsInternationally,
    File? logo,
  }) async {
    emit(BrandRequestLoading());

    try {
      final Map<String, dynamic> body = {
        "name": name,
        "description": description,
        "country": country,
        "city": city,
        "phone": phone,
        if (website != null) "website": website,
        if (whatsappLink != null) "whatsappLink": whatsappLink,
        "shipsInternationally": shipsInternationally,
        if (logo != null) "logo": logo,
      };

      if (categories != null && categories.isNotEmpty) {
        body["categories[]"] = categories;
      }

      final res = await repo.sendRequest(body);

      emit(BrandRequestSuccess(message: res.message, data: res.data));
    } on DioException catch (e) {
      final failure = ServerFailure.fromDioError(e);
      emit(BrandRequestFailure(failure.errMessage));
    } catch (e) {
      emit(BrandRequestFailure(e.toString()));
    }
  }
}
