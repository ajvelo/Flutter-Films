import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:flutter_films/features/characters/presentation/pages/character_detail.dart';
import 'package:flutter_films/features/characters/presentation/pages/character_home.dart';
import 'package:flutter_films/features/films/presentation/pages/home_page.dart';

import '../../features/characters/domain/entities/character.dart';

part 'app_router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    CustomRoute(
        page: HomePage,
        initial: true,
        transitionsBuilder: TransitionsBuilders.fadeIn),
    CustomRoute(
        page: CharacterHomePage,
        transitionsBuilder: TransitionsBuilders.slideLeftWithFade),
    CustomRoute(
        page: CharacterDetailPage,
        transitionsBuilder: TransitionsBuilders.slideLeftWithFade),
  ],
)
class AppRouter extends _$AppRouter {}
