import 'dart:convert';

List<TemplateCategory> templateCategoryFromJson(String str) => List<TemplateCategory>.from(json.decode(str).map((x) => TemplateCategory.fromJson(x)));

String templateCategoryToJson(List<TemplateCategory> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TemplateCategory {
  TemplateCategory({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory TemplateCategory.fromJson(Map<String, dynamic> json) => TemplateCategory(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
  };
}
