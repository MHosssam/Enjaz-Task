import 'package:enjaz/main_models/status_model.dart';
import 'package:flutter/cupertino.dart';

abstract class AppState {}

class Start extends AppState {}

class Done extends AppState {

  List<Widget>? cards;
  List<dynamic>? list;
  bool? reload;
  bool? loading;
  String? data;

  Done({
    this.data,
    this.cards,
    this.list,
    this.reload = true,
    this.loading = false,
  });
}



class UserInfoDoneState extends AppState {
  final List<Widget>? requestsCard;
  final List<Widget>? shortCutsCard;

  UserInfoDoneState({this.requestsCard, this.shortCutsCard});
}

class GroupsDoneState extends AppState {
  List<Widget>? cards;
  List<Widget>? otherCards;

  GroupsDoneState({this.cards, this.otherCards});
}

class GroupInfoDoneState extends AppState {
  List<Widget>? cards;

  GroupInfoDoneState({this.cards});
}

class FindUserDoneState extends AppState {
  List<Widget>? cards;

  FindUserDoneState({this.cards});
}

class FindUserPageDoneState extends AppState {
  List<Widget>? followingListCards;
  List<Widget>? recentSearchCards;

  FindUserPageDoneState({this.recentSearchCards, this.followingListCards});
}

class SettingDoneState extends AppState {
  List<Widget>? cards;

  SettingDoneState({this.cards});
}

class MoreRequestsDoneState extends AppState {
  List<Widget>? cards;

  MoreRequestsDoneState({this.cards});
}

class NotificationDoneState extends AppState {
  List<Widget>? cards;

  NotificationDoneState({this.cards});
}

class SingleUserRequestDoneState extends AppState {
  List<Widget>? myRequests;
  List<Widget>? otherRequests;
  List<StatusModel>? status;

  SingleUserRequestDoneState({this.myRequests, this.otherRequests, this.status});
}

class RequestsDoneState extends AppState {
  List<Widget>? requests;

  RequestsDoneState({this.requests});
}

class ApprovalsDoneState extends AppState {
  List<Widget>? approvals;

  ApprovalsDoneState({this.approvals});
}

class Error extends AppState {}

class FilterState extends AppState {}

class Loading extends AppState {
  dynamic arguments;

  Loading({this.arguments});
}

class LoadingBTN extends AppState {}

class Empty extends AppState {
  final bool? initial;

  Empty({this.initial});
}
