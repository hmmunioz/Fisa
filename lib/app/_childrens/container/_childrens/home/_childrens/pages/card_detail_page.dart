import 'package:fisatest/app/_childrens/container/_childrens/home/models/cards_info_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:fisatest/app/blocs/blocs.dart';
import 'package:fisatest/app/utils/extensions/buildcontext.dart';
import 'package:go_router/go_router.dart';
import 'card_detail_ui.dart';

class CardDetailPage extends StatelessWidget {
  const CardDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state.error ?? false || state.state == HomeStateEnum.error) {
          context.messageDialog(message: state.errorMessage!);
        }
        if (state.state == HomeStateEnum.loading) {
          context.showLoadingDialog(translate('loading'));
        }
        if (state.state == HomeStateEnum.loaded && context.canPop()) {
          context.pop();
        }
      },
      builder: (context, state) {
        return CardDetailUI(state);
      },
    );
  }
}
