import 'dart:convert';

ResGetAllCategory resGetAllCategoryFromJson(String str) => ResGetAllCategory.fromJson(json.decode(str));

String resGetAllCategoryToJson(ResGetAllCategory data) => json.encode(data.toJson());

class ResGetAllCategory {
    ResGetAllCategory({
        this.message,
        this.category,
    });

    String message;
    List<Category> category;

    factory ResGetAllCategory.fromJson(Map<String, dynamic> json) => ResGetAllCategory(
        message: json["message"],
        category: List<Category>.from(json["payload"].map((x) => Category.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "payload": List<dynamic>.from(category.map((x) => x.toJson())),
    };
}

class Category {
    Category({
        this.id,
        this.name,
        this.isDeleted,
        this.createdAt,
        this.updatedAt,
    });

    String id;
    String name;
    bool isDeleted;
    DateTime createdAt;
    DateTime updatedAt;

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        isDeleted: json["isDeleted"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "isDeleted": isDeleted,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}
