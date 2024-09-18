import 'package:fisatest/app/_childrens/container/_childrens/home/bloc/home_bloc.dart';
import 'package:fisatest/app/_childrens/container/_childrens/home/models/cards_info_model.dart';
import 'package:fisatest/app/enums/archetype_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:fisatest/app/blocs/blocs.dart';
import 'package:fisatest/app/utils/extensions/buildcontext.dart';
import 'package:go_router/go_router.dart';
import 'home_interactor.dart';
import 'home_ui.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> implements HomeInteractor {
  late HomeBloc _homeBloc;
  @override
  void initState() {
    _homeBloc = BlocProvider.of<HomeBloc>(context);
    getInitialData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state.state == HomeStateEnum.loading) {
          context.showLoadingDialog(translate('loading'));
        }
        if (state.state == HomeStateEnum.loaded && context.canPop()) {
          context.pop();
        }
      },
      builder: (context, state) {
        return HomeUI(this, state);
      },
    );
  }

  getInitialData() async {
    _homeBloc.add(GetCardsEvent());
  }

  @override
  void changeCurrentCard(CardInfoModel cardInfoModel) {
    _homeBloc.add(ChangeCurrentCard(cardInfoModel));
    context.pushNamed('card_detail_page');
  }

  @override
  void reloeadData() {
    _homeBloc.add(ReloadCardsEvent());
  }

  @override
  void changeCurrenFilter(ArchetypeEnum archetypeEnum) {
    _homeBloc.add(ChangeCurrentFilterEvent(archetypeEnum));
  }

  @override
  void getMoreData() {
    _homeBloc.add(GetMoreCardsEvent());
  }

  @override
  void changeBanList() {
    _homeBloc.add(ActiveBanListEvent());
  }
}
