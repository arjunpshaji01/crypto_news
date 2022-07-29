// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  Welcome({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  int? count;
  String? next;
  dynamic previous;
  List<Result>? results;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class Result {
  Result({
    this.kind,
    required this.domain,
    this.source,
    required this.title,
    this.publishedAt,
    required this.slug,
    this.currencies,
    this.id,
    this.url,
    this.createdAt,
    this.votes,
  });

  Kind? kind;
  String domain;
  Source? source;
  String title;
  DateTime? publishedAt;
  String slug;
  List<Currency>? currencies;
  int? id;
  String? url;
  DateTime? createdAt;
  Votes? votes;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        kind: kindValues.map[json["kind"]],
        domain: json["domain"],
        source: Source.fromJson(json["source"]),
        title: json["title"],
        publishedAt: DateTime.parse(json["published_at"]),
        slug: json["slug"],
        currencies: json["currencies"] == null
            ? null
            : List<Currency>.from(
                json["currencies"].map((x) => Currency.fromJson(x))),
        id: json["id"],
        url: json["url"],
        createdAt: DateTime.parse(json["created_at"]),
        votes: Votes.fromJson(json["votes"]),
      );

  Map<String, dynamic> toJson() => {
        "kind": kindValues.reverse![kind],
        "domain": domain,
        "source": source?.toJson(),
        "title": title,
        "published_at": publishedAt?.toIso8601String(),
        "slug": slug,
        "currencies": currencies == null
            ? null
            : List<dynamic>.from(currencies!.map((x) => x.toJson())),
        "id": id,
        "url": url,
        "created_at": createdAt?.toIso8601String(),
        "votes": votes?.toJson(),
      };
}

class Currency {
  Currency({
    required this.code,
    required this.title,
    required this.slug,
    required this.url,
  });

  String code;
  String title;
  String? slug;
  String url;

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
        code: json["code"],
        title: json["title"],
        slug: json["slug"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "title": title,
        "slug": slug,
        "url": url,
      };
}

enum Kind { NEWS, MEDIA }

final kindValues = EnumValues({"media": Kind.MEDIA, "news": Kind.NEWS});

class Source {
  Source({
    required this.title,
    required this.region,
    required this.domain,
    this.path,
  });

  String title;
  Region? region;
  String domain;
  dynamic path;

  factory Source.fromJson(Map<String, dynamic> json) => Source(
        title: json["title"],
        region: regionValues.map[json["region"]],
        domain: json["domain"],
        path: json["path"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "region": regionValues.reverse![region],
        "domain": domain,
        "path": path,
      };
}

enum Region { EN }

final regionValues = EnumValues({"en": Region.EN});

class Votes {
  Votes({
    required this.negative,
    required this.positive,
    required this.important,
    required this.liked,
    required this.disliked,
    required this.lol,
    required this.toxic,
    required this.saved,
    required this.comments,
  });

  int negative;
  int positive;
  int important;
  int liked;
  int disliked;
  int lol;
  int toxic;
  int saved;
  int comments;

  factory Votes.fromJson(Map<String, dynamic> json) => Votes(
        negative: json["negative"],
        positive: json["positive"],
        important: json["important"],
        liked: json["liked"],
        disliked: json["disliked"],
        lol: json["lol"],
        toxic: json["toxic"],
        saved: json["saved"],
        comments: json["comments"],
      );

  Map<String, dynamic> toJson() => {
        "negative": negative,
        "positive": positive,
        "important": important,
        "liked": liked,
        "disliked": disliked,
        "lol": lol,
        "toxic": toxic,
        "saved": saved,
        "comments": comments,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    reverseMap ??= map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
