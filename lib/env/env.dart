import 'package:meta/meta.dart';

enum BuildFlavor { production, development }

BuildEnvironment? get env => _env;
BuildEnvironment? _env;

class BuildEnvironment {
  /// The backend server.
  final String baseUrl;
  final String rpcUrl;
  final BuildFlavor flavor;
  final String deployHashExplorer;

  BuildEnvironment._init(
      {required this.flavor,
      required this.rpcUrl,
      required this.baseUrl,
      required this.deployHashExplorer});

  /// Sets up the top-level [env] getter on the first call only.
  static void init(
          {@required flavor,
          @required baseUrl,
          @required rpcUrl,
          @required deployHashExplorer}) =>
      _env ??= BuildEnvironment._init(
          flavor: flavor,
          rpcUrl: rpcUrl,
          baseUrl: baseUrl,
          deployHashExplorer: deployHashExplorer);
}
