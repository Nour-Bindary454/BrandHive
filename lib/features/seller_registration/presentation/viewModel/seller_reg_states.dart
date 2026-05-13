import 'package:brand/features/seller_registration/data/model/category_model.dart';
import 'package:brand/features/seller_registration/data/model/seller_reg_model.dart';

abstract class BrandRequestState {}

class BrandRequestInitial extends BrandRequestState {}

class BrandRequestLoading extends BrandRequestState {}

class BrandRequestSuccess extends BrandRequestState {
  final String message;
  final BrandRequestData? data;
  BrandRequestSuccess({required this.message, this.data});
}

class BrandRequestFailure extends BrandRequestState {
  final String error;
  BrandRequestFailure(this.error);
}

// ── Categories ──
class CategoriesLoading extends BrandRequestState {}

class CategoriesLoaded extends BrandRequestState {
  final List<CategoryModel> categories;
  CategoriesLoaded(this.categories);
}

class CategoriesFailure extends BrandRequestState {
  final String error;
  CategoriesFailure(this.error);
}
