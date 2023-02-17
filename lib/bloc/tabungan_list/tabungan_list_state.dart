part of 'tabungan_list_bloc.dart';

abstract class TabunganListState extends Equatable {
  const TabunganListState();

  @override
  List<Object> get props => [];
}

class TabunganListInitial extends TabunganListState {}

class TabunganListLoaded extends TabunganListState {
  final TabunganListModel tabunganListModel;
  TabunganListLoaded({this.tabunganListModel});
  @override
  List<Object> get props => [tabunganListModel];
}

class TabunganListError extends TabunganListState {
  final String error;
  TabunganListError({this.error});
  @override
  List<Object> get props => [error];
}

class TabunganCheckPaymentLoaded extends TabunganListState {
  final CheckTagihanSavingModel checkTagihanSavingModel;
  TabunganCheckPaymentLoaded({this.checkTagihanSavingModel});
  @override
  List<Object> get props => [checkTagihanSavingModel];
}

// tagihan

class TagihanInquiryPaymentLoaded extends TabunganListState {
  final ResponseTagihanInquiry responseTagihanInquiry;
  TagihanInquiryPaymentLoaded({this.responseTagihanInquiry});
  @override
  List<Object> get props => [responseTagihanInquiry];
}
