import 'package:flutter/material.dart';

import 'package:one_point/features/tutor/domain/usecases/get_tutor_detail_usecase.dart';
import 'package:one_point/features/tutor/domain/entities/common/tutor.dart';

class TutorDetailProvider extends ChangeNotifier {
  final GetTutorDetailUseCase _getTutorDetail;
  TutorDetailProvider(this._getTutorDetail);

  Tutor? _tutor;
  bool _isLoading = false;
  String? _error;

  Tutor? get tutor => _tutor;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchTutor(String id) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _tutor = await _getTutorDetail(id);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
} 