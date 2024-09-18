import 'dart:async';
import 'package:fisatest/app/_childrens/container/_childrens/home/models/cards_info_model.dart';
import 'package:fisatest/app/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:fisatest/app/_childrens/container/pages/container_app_interactor.dart';
import 'package:fisatest/app/_childrens/container/pages/container_app_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ContainerPageApp extends StatelessWidget implements ContainerAppInteractor {
  final Widget children;

  const ContainerPageApp({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return ContainerAppUI(
      interactor: this,
      children: children,
    );
  }

  @override
  void logOut(BuildContext context) {
    final initBloc = BlocProvider.of<InitBloc>(context, listen: false);
    initBloc.add(const ChangeStateEvent(InitStateEnum.initial));
  }

  @override
  void changeCurrentCard(CardInfoModel cardInfoModel) {
    // Implementación pendiente de changeCurrentCard
  }
}
