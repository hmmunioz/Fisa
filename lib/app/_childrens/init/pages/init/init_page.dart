import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:go_router/go_router.dart';
import 'package:fisatest/app/blocs/blocs.dart';
import 'package:fisatest/app/utils/extensions/buildcontext.dart';
import 'init_interactor.dart';
import 'init_ui.dart';

class InitPage extends StatelessWidget implements InitInteractor {
  const InitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InitBloc, InitState>(
      listener: (context, state) {
        if (state.error ?? false || state.state == InitStateEnum.error) {
          context.messageDialog(
            message: state.errorMessage!,
          );
        }
        if (state.state == InitStateEnum.loading) {
          context.showLoadingDialog(translate('loading'));
        }
        if (state.state == InitStateEnum.loaded) {
          if (context.canPop()) {
            context.pop();
          }
        }
      },
      builder: (context, state) {
        return InitUI(this);
      },
    );
  }

  @override
  void goToHome(BuildContext context) {
    final initBloc = BlocProvider.of<InitBloc>(context, listen: false);
    initBloc.add(const ChangeStateEvent(InitStateEnum.authorized));
    context.goNamed('home_page');
  }
}
