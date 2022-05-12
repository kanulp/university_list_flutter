import 'package:university_list/src/model/university_model.dart';

import '../network/api_service.dart';

class UniversityListRepository {
  final ApiService _apiService = ApiService();

  Future<List<UniversityModel>> fetchData(String name, String country) async {
    List<UniversityModel> response = await _apiService.getList(name, country);
    return response;
  }
}
