import 'package:cloudwalknasa/models/apod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'apod_union.freezed.dart';

@freezed
class ApodUnion with _$ApodUnion {
  const factory ApodUnion.apod(Apod apod) = ApodSingle;
  const factory ApodUnion.apodList(List<Apod?> apodList) = ApodList;

  factory ApodUnion.fromJson(dynamic json) {
    if (json is List) {
      final apodList = json.map<Apod?>((item) => Apod.fromJson(item)).toList();
      return ApodUnion.apodList(apodList);
    } else {
      return ApodUnion.apod(Apod.fromJson(json));
    }
  }
}