
import 'package:json_annotation/json_annotation.dart';

// user.g.dart 将在我们运行生成命令后自动生成
part 'TestModel.g.dart';

///这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()

class TestModel{
  TestModel(this.phone, this.pre_register);

  String phone;
  int  pre_register;
  //不同的类使用不同的mixin即可
  factory TestModel.fromJson(Map<String, dynamic> json) => _$TestModelFromJson(json);
  Map<String, dynamic> toJson() => _$TestModelToJson(this);
}