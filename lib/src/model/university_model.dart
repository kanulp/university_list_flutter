import 'dart:convert';

List<UniversityModel> universityModelFromJson(String str) => List<UniversityModel>.from(json.decode(str).map((x) => UniversityModel.fromJson(x)));

String universityModelToJson(List<UniversityModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UniversityModel {
    UniversityModel({
        required this.alphaTwoCode,
        required this.domains,
        required this.country,
        required this.stateProvince,
        required this.webPages,
        required this.name,
    });

    late String alphaTwoCode;
    late List<String> domains;
    late String country;
    late dynamic stateProvince;
    late List<String> webPages;
    late String name;

    factory UniversityModel.fromJson(Map<String, dynamic> json) => UniversityModel(
        alphaTwoCode: json["alpha_two_code"],
        domains: List<String>.from(json["domains"].map((x) => x)),
        country: json["country"],
        stateProvince: json["state-province"],
        webPages: List<String>.from(json["web_pages"].map((x) => x)),
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "alpha_two_code": alphaTwoCode,
        "domains": List<dynamic>.from(domains.map((x) => x)),
        "country": country,
        "state-province": stateProvince,
        "web_pages": List<dynamic>.from(webPages.map((x) => x)),
        "name": name,
    };
}
