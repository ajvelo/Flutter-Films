import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:flutter_films/features/characters/presentation/pages/character_detail.dart';
import 'package:flutter_films/features/characters/presentation/pages/character_home.dart';
import 'package:flutter_films/features/films/presentation/pages/home_page.dart';

import '../../features/characters/domain/entities/character.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends _$AppRouter {
  @override
  final List<AutoRoute> routes = [
    CustomRoute(
        page: HomeRoute.page,
        path: '/',
        transitionsBuilder: TransitionsBuilders.fadeIn),
    CustomRoute(
        page: CharacterHomeRoute.page,
        path: '/characters',
        transitionsBuilder: TransitionsBuilders.slideLeftWithFade),
    CustomRoute(
        page: CharacterDetailRoute.page,
        path: '/characters/:id',
        transitionsBuilder: TransitionsBuilders.slideLeftWithFade),
  ];
}
