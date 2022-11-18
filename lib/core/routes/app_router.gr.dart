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
          characterUrls: args.characterUrls,
          key: args.key,
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
          id: args.id,
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
    required List<String> characterUrls,
    Key? key,
  }) : super(
          CharacterHomeRoute.name,
          path: '/character-home-page',
          args: CharacterHomeRouteArgs(
            characterUrls: characterUrls,
            key: key,
          ),
        );

  static const String name = 'CharacterHomeRoute';
}

class CharacterHomeRouteArgs {
  const CharacterHomeRouteArgs({
    required this.characterUrls,
    this.key,
  });

  final List<String> characterUrls;

  final Key? key;

  @override
  String toString() {
    return 'CharacterHomeRouteArgs{characterUrls: $characterUrls, key: $key}';
  }
}

/// generated route for
/// [CharacterDetailPage]
class CharacterDetailRoute extends PageRouteInfo<CharacterDetailRouteArgs> {
  CharacterDetailRoute({
    Key? key,
    required String id,
  }) : super(
          CharacterDetailRoute.name,
          path: '/character-detail-page',
          args: CharacterDetailRouteArgs(
            key: key,
            id: id,
          ),
        );

  static const String name = 'CharacterDetailRoute';
}

class CharacterDetailRouteArgs {
  const CharacterDetailRouteArgs({
    this.key,
    required this.id,
  });

  final Key? key;

  final String id;

  @override
  String toString() {
    return 'CharacterDetailRouteArgs{key: $key, id: $id}';
  }
}
