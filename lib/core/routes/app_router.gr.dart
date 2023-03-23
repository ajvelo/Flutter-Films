// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  _$AppRouter([GlobalKey<NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomePage(),
      );
    },
    CharacterDetailRoute.name: (routeData) {
      final args = routeData.argsAs<CharacterDetailRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CharacterDetailPage(
          id: args.id,
          key: args.key,
          character: args.character,
        ),
      );
    },
    CharacterHomeRoute.name: (routeData) {
      final args = routeData.argsAs<CharacterHomeRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CharacterHomePage(
          args.episodeNo,
          key: args.key,
          characterUrls: args.characterUrls,
          uid: args.uid,
        ),
      );
    },
  };
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CharacterDetailPage]
class CharacterDetailRoute extends PageRouteInfo<CharacterDetailRouteArgs> {
  CharacterDetailRoute({
    required String id,
    Key? key,
    required Character character,
    List<PageRouteInfo>? children,
  }) : super(
          CharacterDetailRoute.name,
          args: CharacterDetailRouteArgs(
            id: id,
            key: key,
            character: character,
          ),
          rawPathParams: {'id': id},
          initialChildren: children,
        );

  static const String name = 'CharacterDetailRoute';

  static const PageInfo<CharacterDetailRouteArgs> page =
      PageInfo<CharacterDetailRouteArgs>(name);
}

class CharacterDetailRouteArgs {
  const CharacterDetailRouteArgs({
    required this.id,
    this.key,
    required this.character,
  });

  final String id;

  final Key? key;

  final Character character;

  @override
  String toString() {
    return 'CharacterDetailRouteArgs{id: $id, key: $key, character: $character}';
  }
}

/// generated route for
/// [CharacterHomePage]
class CharacterHomeRoute extends PageRouteInfo<CharacterHomeRouteArgs> {
  CharacterHomeRoute({
    required String episodeNo,
    Key? key,
    required List<String> characterUrls,
    required String uid,
    List<PageRouteInfo>? children,
  }) : super(
          CharacterHomeRoute.name,
          args: CharacterHomeRouteArgs(
            episodeNo: episodeNo,
            key: key,
            characterUrls: characterUrls,
            uid: uid,
          ),
          initialChildren: children,
        );

  static const String name = 'CharacterHomeRoute';

  static const PageInfo<CharacterHomeRouteArgs> page =
      PageInfo<CharacterHomeRouteArgs>(name);
}

class CharacterHomeRouteArgs {
  const CharacterHomeRouteArgs({
    required this.episodeNo,
    this.key,
    required this.characterUrls,
    required this.uid,
  });

  final String episodeNo;

  final Key? key;

  final List<String> characterUrls;

  final String uid;

  @override
  String toString() {
    return 'CharacterHomeRouteArgs{episodeNo: $episodeNo, key: $key, characterUrls: $characterUrls, uid: $uid}';
  }
}
