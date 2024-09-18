part of 'home_bloc.dart';

enum HomeStateEnum {
  initial,
  loading,
  loaded,
  login,
  success,
  error,
  checking,
  welcome,
  homeorized,
  logout
}

class HomeState extends Equatable {
  const HomeState({
    this.state = HomeStateEnum.initial,
    this.cardYuGuiList,
    this.currentCardInfo,
    this.metaData,
    this.limit = 30,
    this.page = 0,
    this.currentFilter = ArchetypeEnum.all,
    this.activeBanlist = false,
    this.isLast = false,
    this.errorMessage,
    this.error,
  });

  final List<CardInfoModel>? cardYuGuiList;
  final CardInfoModel? currentCardInfo;
  final MetaModel? metaData;
  final String? errorMessage;
  final int limit;
  final int page;
  final ArchetypeEnum currentFilter;
  final bool isLast;
  final bool? error;
  final HomeStateEnum state;
  final bool? activeBanlist;
  HomeState copyWith({
    List<CardInfoModel>? cardYuGuiList,
    CardInfoModel? currentCardInfo,
    MetaModel? metaData,
    int? limit,
    int? page,
    bool? activeBanlist,
    ArchetypeEnum? currentFilter,
    bool? isLast,
    HomeStateEnum? state,
    bool? error,
    String? errorMessage,
  }) {
    return HomeState(
      cardYuGuiList: cardYuGuiList ?? this.cardYuGuiList,
      currentCardInfo: currentCardInfo ?? this.currentCardInfo,
      metaData: metaData ?? this.metaData,
      state: state ?? this.state,
      page: page ?? this.page,
      activeBanlist: activeBanlist ?? this.activeBanlist,
      currentFilter: currentFilter ?? this.currentFilter,
      isLast: isLast ?? this.isLast,
      limit: limit ?? this.limit,
      errorMessage: errorMessage ?? this.errorMessage,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        cardYuGuiList,
        currentCardInfo,
        metaData,
        state,
        page,
        activeBanlist,
        currentFilter,
        isLast,
        limit,
        errorMessage,
        error,
      ];
}
