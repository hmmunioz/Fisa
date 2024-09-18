import 'dart:async';

import 'package:bloc/bloc.dart' as bloc;
import 'package:fisatest/app/_childrens/container/_childrens/home/models/cards_info_model.dart';
import 'package:fisatest/app/_childrens/container/_childrens/home/models/meta_model.dart';
import 'package:fisatest/app/enums/archetype_enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:fisatest/app/constants/apiurl.dart';
import 'package:equatable/equatable.dart';
import 'package:fisatest/app/utils/api/api_rest_client.dart';
import 'package:fisatest/app/utils/api/api_rest_result.dart';
import 'package:get_it/get_it.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends bloc.Bloc<HomeEvent, HomeState> {
  final _logger = Logger();
  final ApiRestClient _apiRestClient = GetIt.I<ApiRestClient>();

  HomeBloc() : super(const HomeState()) {
    on<GetCardsEvent>(_onGetCardsEvent);
    on<GetMoreCardsEvent>(_onGetMoreCardsEvent);
    on<ReloadCardsEvent>(_onReloadCardsEvent);
    on<ChangeCurrentCard>(_onChangeCurrentCard);
    on<ChangeCurrentFilterEvent>(_onChangeCurrentFilterEvent);
    on<ActiveBanListEvent>(_onActiveBanListEvent);
  }

  Future<HomeState> _getCardsApi([bool isReload = false]) async {
    final oldCards = state.cardYuGuiList;
    try {
      List<CardInfoModel> cardsList = [];
      if (state.metaData == null ||
          state.metaData?.rowsRemaining != 0 ||
          isReload) {
        var url =
            "${ApiUrlValues.getCards}?offset=${state.page}&num=${state.limit}";
        url = state.currentFilter == ArchetypeEnum.all
            ? url
            : "$url&archetype=${state.currentFilter.name}";

        url = state.activeBanlist == false ? url : "$url&banlist=tcg";
        final response = await _apiRestClient.call(
          HttpMethod.get,
          url,
        );
        if (response is Succeeded) {
          _logger.d("Response: ${response.data}");

          final dataResponseJson = response.data as Map<String, dynamic>;
          final cardYuGuiList = dataResponseJson['data']
              .map<CardInfoModel>((json) => CardInfoModel.fromJson(json))
              .toList();
          final metaData = MetaModel.fromJson(dataResponseJson['meta']);

          cardsList = [...(oldCards ?? []), ...cardYuGuiList];

          return state.copyWith(
            cardYuGuiList: cardsList,
            limit: state.limit,
            page: state.page + 1,
            isLast: metaData.rowsRemaining == 0,
            metaData: metaData,
            state: HomeStateEnum.success,
          );
        } else if (response is Failed) {
          return state.copyWith(
            cardYuGuiList: oldCards,
            limit: state.limit,
            page: state.page,
            isLast: cardsList.length == (state.metaData?.totalRows ?? 0)
                ? false
                : true,
            state: HomeStateEnum.error,
            error: true,
            errorMessage: "Ha ocurrido un error",
          );
        } else if (response is Error) {
          return state.copyWith(
            cardYuGuiList: oldCards,
            limit: state.limit,
            page: state.page,
            isLast: cardsList.length == (state.metaData?.totalRows ?? 0)
                ? false
                : true,
            state: HomeStateEnum.error,
            error: true,
            errorMessage: "Ha ocurrido un error",
          );
        }
      }
      return state.copyWith(state: HomeStateEnum.loaded);
    } catch (e) {
      _logger.e("Exception caught: $e");
      return state.copyWith(
        cardYuGuiList: oldCards,
        limit: state.limit,
        page: state.page,
        isLast: true,
        state: HomeStateEnum.error,
        error: true,
        errorMessage: "Ha ocurrido un error",
      );
    }
  }

  FutureOr<void> _onGetCardsEvent(
      GetCardsEvent event, Emitter<HomeState> emit) async {
    _logger.d("GetCardsEvent");
    emit(state.copyWith(state: HomeStateEnum.loading));
    final tempState = await _getCardsApi();
    emit(state.copyWith(state: HomeStateEnum.loaded));
    final oldCards = state.cardYuGuiList;
    if (oldCards != null &&
        tempState.cardYuGuiList != null &&
        oldCards.isEmpty &&
        tempState.cardYuGuiList!.isEmpty) {
      emit(state.copyWith(
        cardYuGuiList: oldCards,
        limit: state.limit,
        page: state.page,
        isLast:
            oldCards.length == (state.metaData?.totalRows ?? 0) ? false : true,
        state: HomeStateEnum.error,
        error: true,
        errorMessage: "Ha ocurrido un error",
      ));
    } else {
      emit(tempState);
    }
  }

  FutureOr<void> _onChangeCurrentCard(
      ChangeCurrentCard event, Emitter<HomeState> emit) async {
    emit(state.copyWith(currentCardInfo: event.cardInfoModel));
  }

  void _onGetMoreCardsEvent(
    GetMoreCardsEvent event,
    Emitter<HomeState> emit,
  ) async {
    _logger.d("GetMoreCardsEvent");
    final oldCards = state.cardYuGuiList;
    emit(state.copyWith(state: HomeStateEnum.loading));

    try {
      final tempState = await _getCardsApi();
      emit(state.copyWith(state: HomeStateEnum.loaded));
      emit(tempState);
    } catch (error) {
      emit(state.copyWith(
        cardYuGuiList: oldCards,
        limit: state.limit,
        page: state.page,
        isLast: false,
        state: HomeStateEnum.error,
        error: true,
        errorMessage: "Ha ocurrido un error",
      ));
    }
  }

  void _onReloadCardsEvent(
    ReloadCardsEvent event,
    Emitter<HomeState> emit,
  ) async {
    _logger.d("ReloadCardsEvent");
    emit(state.copyWith(
        cardYuGuiList: [],
        metaData: null,
        page: 0,
        isLast: false,
        limit: 30,
        state: HomeStateEnum.loading));
    try {
      final tempState = await _getCardsApi(true);
      emit(state.copyWith(state: HomeStateEnum.loaded));
      emit(tempState);
    } catch (error) {
      emit(state.copyWith(
        cardYuGuiList: [],
        limit: state.limit,
        page: state.page,
        isLast: false,
        state: HomeStateEnum.error,
        error: true,
        errorMessage: "Ha ocurrido un error",
      ));
    }
  }

  void _onChangeCurrentFilterEvent(
    ChangeCurrentFilterEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(
        currentFilter: event.filterType,
        cardYuGuiList: [],
        metaData: null,
        page: 0,
        isLast: false,
        limit: 30,
        state: HomeStateEnum.loading));
    try {
      final tempState = await _getCardsApi(true);
      emit(state.copyWith(state: HomeStateEnum.loaded));
      emit(tempState);
    } catch (error) {
      emit(state.copyWith(
        cardYuGuiList: [],
        limit: state.limit,
        page: state.page,
        isLast: false,
        state: HomeStateEnum.error,
        error: true,
        errorMessage: "Ha ocurrido un error",
      ));
    }
  }

  void _onActiveBanListEvent(
    ActiveBanListEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(
        currentFilter: ArchetypeEnum.all,
        activeBanlist: !(state.activeBanlist ?? false),
        cardYuGuiList: [],
        metaData: null,
        page: 0,
        isLast: false,
        limit: 30,
        state: HomeStateEnum.loading));
    try {
      final tempState = await _getCardsApi(true);
      emit(state.copyWith(state: HomeStateEnum.loaded));
      emit(tempState);
    } catch (error) {
      emit(state.copyWith(
        cardYuGuiList: [],
        limit: state.limit,
        page: state.page,
        activeBanlist: true,
        isLast: false,
        state: HomeStateEnum.error,
        error: true,
        errorMessage: "Ha ocurrido un error",
      ));
    }
  }
}
