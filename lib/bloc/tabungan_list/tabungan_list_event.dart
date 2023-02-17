part of 'tabungan_list_bloc.dart';

abstract class TabunganListEvent extends Equatable {
  const TabunganListEvent();

  @override
  List<Object> get props => [];
}

class TabunganListGet extends TabunganListEvent {}

class TabunganCheckPayment extends TabunganListEvent {
  final String savingType;
  TabunganCheckPayment({this.savingType});
}

//

class PostTagihanResponseInquiry extends TabunganListEvent {
  final String id;
  PostTagihanResponseInquiry({this.id});
}
