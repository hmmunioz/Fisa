import 'package:fisatest/app/_childrens/container/_childrens/home/_childrens/pages/card_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:fisatest/app/_childrens/init/bloc/init_bloc.dart';
import 'package:fisatest/app/_childrens/init/pages/init/init_page.dart';
import 'package:fisatest/app/_childrens/container/pages/container_app_page.dart';
import 'package:fisatest/app/_childrens/container/_childrens/home/pages/home_page.dart';
import 'package:fisatest/app/constants/colors.dart';
import 'package:fisatest/app/routes/go_router_refresh_stream.dart';
import 'package:get_it/get_it.dart';

class MyAppRouter {
  final BuildContext context;

  MyAppRouter(this.context);

  GoRouter createdRouter() {
    return GoRouter(
        routes: [
          //main
          GoRoute(
            path: '/',
            name: 'init_page',
            builder: (context, state) => const InitPage(),
          ),

          //shellrouter
          ShellRoute(
              builder: (context, state, child) {
                return ContainerPageApp(
                  children: child,
                );
              },
              routes: [
                GoRoute(
                  path: '/home',
                  name: 'home_page',
                  builder: (context, state) => const HomePage(),
                ),
              ]),
          GoRoute(
            path: '/card_detail',
            name: 'card_detail_page',
            builder: (context, state) => const CardDetailPage(),
          ),
        ],
        redirect: (BuildContext context, GoRouterState state) {
          final initStatus = context.read<InitBloc>().state.state;

          if (initStatus == InitStateEnum.authorized) {
            return state.fullPath == "/" || state.fullPath == null
                ? '/home'
                : state.fullPath;
          } else {
            return '/';
          }
        },
        debugLogDiagnostics: false,
        refreshListenable:
            GoRouterRefreshStream(context.read<InitBloc>().stream));
  }

  void handleLink(String? link) {
    if (link != null) {
      final router = GoRouter.of(context);
      router.go('/deeplink?deeplink=$link');
    }
  }
}

//widget routes

class UnknowPage extends StatelessWidget {
  const UnknowPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
      ),
    );
  }
}

class CheckingPage extends StatelessWidget {
  const CheckingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: ColorsTheme.jediBrown,
        ),
      ),
    );
  }
}
