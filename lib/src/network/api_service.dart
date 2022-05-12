import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:university_list/src/const.dart';
import 'package:university_list/src/model/university_model.dart';
import 'package:university_list/src/network/util/app_exception.dart';

class ApiService {
  Future<dynamic> getList(String name, String country) async {
    dynamic responseJson;
    final queryParameters = {"name": name, "country": country};
    try {
      var uri = Uri.parse(url);
      final finalURI = uri.replace(queryParameters: queryParameters);
      final response = await http.get(finalURI, headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      });

      responseJson = universityModelFromJson(response.body);
    } catch (e) {
      print('No Internet Connection $e');
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while communication with server' +
                ' with status code : ${response.statusCode}');
    }
  }
}
