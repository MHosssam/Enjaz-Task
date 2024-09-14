
import 'package:enjaz/helpers/translation/localization_methods.dart';

class StatusModel{
  final int? id ;
  final String? title ;
  final int? length;

  StatusModel({this.id, this.title, this.length });

  static List<StatusModel> get generateList => [
    StatusModel(id : 0, title : tr('all_requests')),
    StatusModel(id : 1, title : "C"),
    StatusModel(id : 2, title : "P"),
    StatusModel(id : 3, title :"T"),
    StatusModel(id : 4, title : "R"),
  ] ;
}