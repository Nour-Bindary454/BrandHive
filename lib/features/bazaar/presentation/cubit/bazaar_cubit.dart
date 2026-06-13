import 'dart:io';
import 'package:brand/features/bazaar/domain/repository/bazaar_repository.dart';
import 'package:brand/features/bazaar/presentation/cubit/bazaar_states.dart';
import 'package:brand/features/bazaar/data/models/bazaar_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class BazaarCubit extends Cubit<BazaarState> {
  final BazaarRepository _repo;

  BazaarCubit(this._repo) : super(BazaarInitial());

  BazaarModel? myBazaar;
  List<BazaarModel> allBazaars = [];
  int currentPage = 1;
  bool isFetchingMore = false;
  bool hasReachedMax = false;
  File? pickedBazaarImage;

  // Image Picker helper
  Future<void> pickBazaarImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (pickedFile != null) {
      pickedBazaarImage = File(pickedFile.path);
      emit(BazaarInitial());
    }
  }

  void clearPickedImage() {
    pickedBazaarImage = null;
    emit(BazaarInitial());
  }

  // Get My Bazaar info (Seller)
  Future<void> getMyBazaar() async {
    emit(MyBazaarLoading());
    final result = await _repo.getMyBazaar();
    result.fold(
      (failure) {
        emit(MyBazaarFailure(failure.errMessage));
      },
      (bazaar) {
        myBazaar = bazaar;
        emit(MyBazaarSuccess(bazaar));
      },
    );
  }

  // Update or Create Bazaar (Seller)
  Future<void> updateBazaar({
    required String name,
    required String description,
    required String address,
    required String contactInfo,
  }) async {
    emit(BazaarUpdateLoading());
    final body = {
      'name': name,
      'description': description,
      'address': address,
      'contactInfo': contactInfo,
      if (pickedBazaarImage != null) 'image': pickedBazaarImage,
    };
    final result = await _repo.updateBazaar(body);
    result.fold(
      (failure) {
        emit(BazaarUpdateFailure(failure.errMessage));
      },
      (bazaar) {
        myBazaar = bazaar;
        pickedBazaarImage = null;
        emit(BazaarUpdateSuccess(bazaar, 'Bazaar updated successfully!'));
      },
    );
  }

  // Get all Bazaars (Customer/Admin) with pagination
  Future<void> getBazaars({bool isRefresh = false}) async {
    if (isRefresh) {
      currentPage = 1;
      hasReachedMax = false;
      allBazaars.clear();
    }

    if (hasReachedMax) return;

    if (currentPage == 1) {
      emit(BazaarsLoading());
    } else {
      isFetchingMore = true;
      emit(BazaarsSuccess(List.from(allBazaars)));
    }

    final result = await _repo.getAllBazaars(page: currentPage, limit: 10);
    result.fold(
      (failure) {
        isFetchingMore = false;
        emit(BazaarsFailure(failure.errMessage));
      },
      (bazaars) {
        isFetchingMore = false;
        if (bazaars.isEmpty || bazaars.length < 10) {
          hasReachedMax = true;
        }
        allBazaars.addAll(bazaars);
        currentPage++;
        emit(BazaarsSuccess(List.from(allBazaars), hasReachedMax: hasReachedMax));
      },
    );
  }

  // Search Bazaars
  Future<void> searchBazaars(String query) async {
    emit(BazaarsLoading());
    final result = await _repo.searchBazaars(query);
    result.fold(
      (failure) {
        emit(BazaarsFailure(failure.errMessage));
      },
      (bazaars) {
        emit(BazaarsSuccess(bazaars, hasReachedMax: true));
      },
    );
  }

  // Send announcement
  Future<void> sendAnnouncement({required String title, required String message}) async {
    emit(AnnouncementLoading());
    final result = await _repo.notifyFollowers(title, message);
    result.fold(
      (failure) {
        emit(AnnouncementFailure(failure.errMessage));
      },
      (_) {
        emit(AnnouncementSuccess('Announcement sent successfully!'));
      },
    );
  }

  // Toggle status (Admin)
  Future<void> toggleBazaarStatus(String id) async {
    emit(BazaarToggleLoading());
    final result = await _repo.toggleBazaarStatus(id);
    result.fold(
      (failure) {
        emit(BazaarToggleFailure(failure.errMessage));
      },
      (_) {
        emit(BazaarToggleSuccess(id));
      },
    );
  }
}
