import 'package:flutter/material.dart';
import 'package:university_list/src/model/university_model.dart';
import 'package:university_list/src/network/util/api_response.dart';
import 'package:university_list/src/repository/university_list_repository.dart';

class UniversityViewModel with ChangeNotifier {
  ApiResponse _apiResponse = ApiResponse.initial("Empty Data");

  UniversityModel? _data;

  ApiResponse get response {
    return _apiResponse;
  }

  UniversityModel? get getList {
    return _data;
  }

  Future<void> fetchUniversityList(String name, String country) async {
    _apiResponse = ApiResponse.loading('Fetching university list');
    notifyListeners();
    try {
      List<UniversityModel> list =
          await UniversityListRepository().fetchData(name, country);
      _apiResponse = ApiResponse.completed(list);
    } catch (e) {
      _apiResponse = ApiResponse.error(e.toString());
      print("error in viewmodel $e");
    }
    notifyListeners();
  }

  void setSelectedItem(UniversityModel? model) {
    _data = model;
    notifyListeners();
  }
}
