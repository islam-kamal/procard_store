import 'dart:convert';

// Handler for the network's request.
abstract class RequestMappable {
  Map<String, dynamic> toJson();
}

// Handler for the network's response.

abstract class Mappable<T>  {
  factory Mappable(Mappable type, String data) {
    if (type is BaseMappable) {
      print("11111111111");
      Map<String, dynamic> mappingData = json.decode(data);
      print("2222222");
      return type.fromJson(mappingData);
    } else if (type is ListMappable) {
      print("333333333");
      Iterable iterableData = json.decode(data);
      print("44444444444");
      return type.fromJsonList(iterableData);
    }
    print("I Couldn't Parser");
    return null;
  }
}

abstract class BaseMappable<T> implements Mappable {

  Mappable fromJson(Map<String, dynamic> json);
}

abstract class ListMappable<T> implements Mappable {
  Mappable fromJsonList(List<dynamic> json);
}
