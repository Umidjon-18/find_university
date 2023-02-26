class UniversityModel {
  late List<String> domains;
  late String name;
  late List<String> webPages;
  late String country;
  late String alphaTwoCode;

  UniversityModel({
    required this.domains,
    required this.name,
    required this.webPages,
    required this.country,
    required this.alphaTwoCode,
  });

  UniversityModel.fromJson(Map<String, dynamic> json) {
    domains = json['domains'].cast<String>();
    name = json['name'];
    webPages = json['web_pages'].cast<String>();
    country = json['country'];
    alphaTwoCode = json['alpha_two_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['domains'] = domains;
    data['name'] = name;
    data['web_pages'] = webPages;
    data['country'] = country;
    data['alpha_two_code'] = alphaTwoCode;
    return data;
  }
}
