// To parse this JSON data, do
//
//     final searchResponse = searchResponseFromJson(jsonString);

import 'dart:convert';

SearchResponse searchResponseFromJson(String str) =>
    SearchResponse.fromJson(json.decode(str));

String searchResponseToJson(SearchResponse data) => json.encode(data.toJson());

class SearchResponse {
  SearchResponse({
    this.type,
    this.query,
    this.features,
    this.attribution,
  });

  String type;
  List<String> query;
  List<Feature> features;
  String attribution;

  factory SearchResponse.fromJson(Map<String, dynamic> json) => SearchResponse(
        type: json["type"],
        query: List<String>.from(json["query"].map((x) => x)),
        features: List<Feature>.from(
            json["features"].map((x) => Feature.fromJson(x))),
        attribution: json["attribution"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "query": List<dynamic>.from(query.map((x) => x)),
        "features": List<dynamic>.from(features.map((x) => x.toJson())),
        "attribution": attribution,
      };
}

class Feature {
  Feature({
    this.id,
    this.type,
    this.placeType,
    this.relevance,
    this.properties,
    this.textEs,
    this.languageEs,
    this.placeNameEs,
    this.text,
    this.language,
    this.placeName,
    this.bbox,
    this.center,
    this.geometry,
    this.context,
  });

  String id;
  String type;
  List<String> placeType;
  int relevance;
  Properties properties;
  String textEs;
  String languageEs;
  String placeNameEs;
  String text;
  String language;
  String placeName;
  List<double> bbox;
  List<double> center;
  Geometry geometry;
  List<Context> context;

  factory Feature.fromJson(Map<String, dynamic> json) => Feature(
        id: json["id"],
        type: json["type"],
        placeType: List<String>.from(json["place_type"].map((x) => x)),
        relevance: json["relevance"],
        properties: Properties.fromJson(json["properties"]),
        textEs: json["text_es"],
        languageEs: json["language_es"] == null ? null : json["language_es"],
        placeNameEs: json["place_name_es"],
        text: json["text"],
        language: json["language"] == null ? null : json["language"],
        placeName: json["place_name"],
        bbox: json["bbox"] == null
            ? null
            : List<double>.from(json["bbox"].map((x) => x.toDouble())),
        center: List<double>.from(json["center"].map((x) => x.toDouble())),
        geometry: Geometry.fromJson(json["geometry"]),
        context: json["context"] == null
            ? null
            : List<Context>.from(
                json["context"].map((x) => Context.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "place_type": List<dynamic>.from(placeType.map((x) => x)),
        "relevance": relevance,
        "properties": properties.toJson(),
        "text_es": textEs,
        "language_es": languageEs == null ? null : languageEs,
        "place_name_es": placeNameEs,
        "text": text,
        "language": language == null ? null : language,
        "place_name": placeName,
        "bbox": bbox == null ? null : List<dynamic>.from(bbox.map((x) => x)),
        "center": List<dynamic>.from(center.map((x) => x)),
        "geometry": geometry.toJson(),
        "context": context == null
            ? null
            : List<dynamic>.from(context.map((x) => x.toJson())),
      };
}

class Context {
  Context({
    this.id,
    this.wikidata,
    this.shortCode,
    this.textEs,
    this.languageEs,
    this.text,
    this.language,
  });

  String id;
  String wikidata;
  String shortCode;
  String textEs;
  String languageEs;
  String text;
  String language;

  factory Context.fromJson(Map<String, dynamic> json) => Context(
        id: json["id"],
        wikidata: json["wikidata"],
        shortCode: json["short_code"] == null ? null : json["short_code"],
        textEs: json["text_es"],
        languageEs: json["language_es"],
        text: json["text"],
        language: json["language"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "wikidata": wikidata,
        "short_code": shortCode == null ? null : shortCode,
        "text_es": textEs,
        "language_es": languageEs,
        "text": text,
        "language": language,
      };
}

class Geometry {
  Geometry({
    this.type,
    this.coordinates,
  });

  String type;
  List<double> coordinates;

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        type: json["type"],
        coordinates:
            List<double>.from(json["coordinates"].map((x) => x.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
      };
}

class Properties {
  Properties({
    this.wikidata,
    this.foursquare,
    this.landmark,
    this.address,
    this.category,
    this.shortCode,
  });

  String wikidata;
  String foursquare;
  bool landmark;
  String address;
  String category;
  String shortCode;

  factory Properties.fromJson(Map<String, dynamic> json) => Properties(
        wikidata: json["wikidata"] == null ? null : json["wikidata"],
        foursquare: json["foursquare"] == null ? null : json["foursquare"],
        landmark: json["landmark"] == null ? null : json["landmark"],
        address: json["address"] == null ? null : json["address"],
        category: json["category"] == null ? null : json["category"],
        shortCode: json["short_code"] == null ? null : json["short_code"],
      );

  Map<String, dynamic> toJson() => {
        "wikidata": wikidata == null ? null : wikidata,
        "foursquare": foursquare == null ? null : foursquare,
        "landmark": landmark == null ? null : landmark,
        "address": address == null ? null : address,
        "category": category == null ? null : category,
        "short_code": shortCode == null ? null : shortCode,
      };
}
