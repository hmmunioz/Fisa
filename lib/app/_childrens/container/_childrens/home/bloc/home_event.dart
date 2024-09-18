part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class GetCardsEvent extends HomeEvent {}

class ChangeCurrentCard extends HomeEvent {
  final CardInfoModel cardInfoModel;

  const ChangeCurrentCard(this.cardInfoModel);
}

class ReloadCardsEvent extends HomeEvent {}

class GetMoreCardsEvent extends HomeEvent {}

class ChangeCurrentFilterEvent extends HomeEvent {
  final ArchetypeEnum filterType;

  const ChangeCurrentFilterEvent(this.filterType);
}

class ActiveBanListEvent extends HomeEvent {}
