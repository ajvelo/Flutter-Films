// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

part of 'app_router.dart';

class _$AppRouter extends RootStackRouter {
  _$AppRouter([GlobalKey<NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return CustomPage<dynamic>(
        routeData: routeData,
        child: const HomePage(),
        transitionsBuilder: TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    CharacterHomeRoute.name: (routeData) {
      final args = routeData.argsAs<CharacterHomeRouteArgs>();
      return CustomPage<dynamic>(
        routeData: routeData,
        child: CharacterHomePage(
          key: args.key,
          characterUrls: args.characterUrls,
          uid: args.uid,
        ),
        transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
        opaque: true,
        barrierDismissible: false,
      );
    },
    CharacterDetailRoute.name: (routeData) {
      final args = routeData.argsAs<CharacterDetailRouteArgs>();
      return CustomPage<dynamic>(
        routeData: routeData,
        child: CharacterDetailPage(
          key: args.key,
          character: args.character,
        ),
        transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
        opaque: true,
        barrierDismissible: false,
      );
    },
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(
          HomeRoute.name,
          path: '/',
        ),
        RouteConfig(
          CharacterHomeRoute.name,
          path: '/character-home-page',
        ),
        RouteConfig(
          CharacterDetailRoute.name,
          path: '/character-detail-page',
        ),
      ];
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute()
      : super(
          HomeRoute.name,
          path: '/',
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [CharacterHomePage]
class CharacterHomeRoute extends PageRouteInfo<CharacterHomeRouteArgs> {
  CharacterHomeRoute({
    Key? key,
    required List<String> characterUrls,
    required String uid,
  }) : super(
          CharacterHomeRoute.name,
          path: '/character-home-page',
          args: CharacterHomeRouteArgs(
            key: key,
            characterUrls: characterUrls,
            uid: uid,
          ),
        );

  static const String name = 'CharacterHomeRoute';
}

class CharacterHomeRouteArgs {
  const CharacterHomeRouteArgs({
    this.key,
    required this.characterUrls,
    required this.uid,
  });

  final Key? key;

  final List<String> characterUrls;

  final String uid;

  @override
  String toString() {
    return 'CharacterHomeRouteArgs{key: $key, characterUrls: $characterUrls, uid: $uid}';
  }
}

/// generated route for
/// [CharacterDetailPage]
class CharacterDetailRoute extends PageRouteInfo<CharacterDetailRouteArgs> {
  CharacterDetailRoute({
    Key? key,
    required Character character,
  }) : super(
          CharacterDetailRoute.name,
          path: '/character-detail-page',
          args: CharacterDetailRouteArgs(
            key: key,
            character: character,
          ),
        );

  static const String name = 'CharacterDetailRoute';
}

class CharacterDetailRouteArgs {
  const CharacterDetailRouteArgs({
    this.key,
    required this.character,
  });

  final Key? key;

  final Character character;

  @override
  String toString() {
    return 'CharacterDetailRouteArgs{key: $key, character: $character}';
  }
}
