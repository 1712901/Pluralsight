import 'dart:convert';

Search searchFromJson(String str) => Search.fromJson(json.decode(str));

String searchToJson(Search data) => json.encode(data.toJson());

class Search {
    Search({
        this.keyword,
        this.opt,
        this.limit,
        this.offset,
    });

    String keyword;
    Opt opt;
    int limit;
    int offset;

    factory Search.fromJson(Map<String, dynamic> json) => Search(
        keyword: json["keyword"],
        opt: Opt.fromJson(json["opt"]),
        limit: json["limit"],
        offset: json["offset"],
    );

    Map<String, dynamic> toJson() => {
        "keyword": keyword,
        "opt": opt.toJson(),
        "limit": limit,
        "offset": offset,
    };
}

SearchV2 searchV2FromJson(String str) => SearchV2.fromJson(json.decode(str));

String searchV2ToJson(SearchV2 data) => json.encode(data.toJson());

class SearchV2 {
    SearchV2({
        this.token,
        this.keyword,
        this.limit,
        this.offset,
        this.opt,
    });

    String token;
    String keyword;
    int limit;
    int offset;
    Opt opt;

    factory SearchV2.fromJson(Map<String, dynamic> json) => SearchV2(
        token: json["token"],
        keyword: json["keyword"],
        limit: json["limit"],
        offset: json["offset"],
        opt: Opt.fromJson(json["opt"]),
    );

    Map<String, dynamic> toJson() => {
        "token": token,
        "keyword": keyword,
        "limit": limit,
        "offset": offset,
        "opt": opt.toJson(),
    };
}

class Opt {
    Opt({
        this.sort,
        this.category,
        this.time,
        this.price,
    });

    Sort sort;
    List<String> category;
    List<Time> time;
    List<Price> price;
    

    factory Opt.fromJson(Map<String, dynamic> json) => Opt(
        sort: Sort.fromJson(json["sort"]),
        category: List<String>.from(json["category"].map((x) => x)),
        time: List<Time>.from(json["time"].map((x) => Price.fromJson(x))),
        price: List<Price>.from(json["price"].map((x) => Price.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "sort": sort.toJson(),
        "category": this.category==null?null:List<dynamic>.from(category.map((x) => x)),
        "time": this.time==null?null:List<dynamic>.from(time.map((x) => x.toJson())),
        "price": this.price==null?null:List<dynamic>.from(price.map((x) => x.toJson())),
    };
}

class Price {
    Price({
        this.max,
        this.min,
    });

    int max;
    int min;

    factory Price.fromJson(Map<String, dynamic> json) => Price(
        max: json["max"],
        min: json["min"] == null ? null : json["min"],
    );

    Map<String, dynamic> toJson() => {
        "max": max,
        "min": min == null ? null : min,
    };
}
class Time {
    Time({
        this.max,
        this.min,
    });

    int max;
    int min;

    factory Time.fromJson(Map<String, dynamic> json) => Time(
        max: json["max"],
        min: json["min"] == null ? null : json["min"],
    );

    Map<String, dynamic> toJson() => {
        "max": max,
        "min": min == null ? null : min,
    };
}

class Sort {
    Sort({
        this.attribute,
        this.rule,
    });

    String attribute;
    String rule;

    factory Sort.fromJson(Map<String, dynamic> json) => Sort(
        attribute: json["attribute"],
        rule: json["rule"],
    );

    Map<String, dynamic> toJson() => {
        "attribute": attribute,
        "rule": rule,
    };
}
