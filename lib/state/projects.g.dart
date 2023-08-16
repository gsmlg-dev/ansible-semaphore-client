// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'projects.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$projectsHash() => r'5a9ad436846c3f134f8bd59d340e7aa547212f6f';

/// See also [Projects].
@ProviderFor(Projects)
final projectsProvider =
    AutoDisposeAsyncNotifierProvider<Projects, List<Project>>.internal(
  Projects.new,
  name: r'projectsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$projectsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Projects = AutoDisposeAsyncNotifier<List<Project>>;
String _$currentProjectHash() => r'877cb7e32abb685ec867da4a009e58b097e80ff0';

/// See also [CurrentProject].
@ProviderFor(CurrentProject)
final currentProjectProvider =
    AutoDisposeAsyncNotifierProvider<CurrentProject, Project?>.internal(
  CurrentProject.new,
  name: r'currentProjectProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentProjectHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CurrentProject = AutoDisposeAsyncNotifier<Project?>;
String _$projectFamilyHash() => r'56565a73dd8d77cca0c78238f491876ae9516653';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$ProjectFamily
    extends BuildlessAutoDisposeAsyncNotifier<Project?> {
  late final int projectId;

  Future<Project?> build(
    int projectId,
  );
}

/// See also [ProjectFamily].
@ProviderFor(ProjectFamily)
const projectFamilyProvider = ProjectFamilyFamily();

/// See also [ProjectFamily].
class ProjectFamilyFamily extends Family<AsyncValue<Project?>> {
  /// See also [ProjectFamily].
  const ProjectFamilyFamily();

  /// See also [ProjectFamily].
  ProjectFamilyProvider call(
    int projectId,
  ) {
    return ProjectFamilyProvider(
      projectId,
    );
  }

  @override
  ProjectFamilyProvider getProviderOverride(
    covariant ProjectFamilyProvider provider,
  ) {
    return call(
      provider.projectId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'projectFamilyProvider';
}

/// See also [ProjectFamily].
class ProjectFamilyProvider
    extends AutoDisposeAsyncNotifierProviderImpl<ProjectFamily, Project?> {
  /// See also [ProjectFamily].
  ProjectFamilyProvider(
    this.projectId,
  ) : super.internal(
          () => ProjectFamily()..projectId = projectId,
          from: projectFamilyProvider,
          name: r'projectFamilyProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$projectFamilyHash,
          dependencies: ProjectFamilyFamily._dependencies,
          allTransitiveDependencies:
              ProjectFamilyFamily._allTransitiveDependencies,
        );

  final int projectId;

  @override
  bool operator ==(Object other) {
    return other is ProjectFamilyProvider && other.projectId == projectId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, projectId.hashCode);

    return _SystemHash.finish(hash);
  }

  @override
  Future<Project?> runNotifierBuild(
    covariant ProjectFamily notifier,
  ) {
    return notifier.build(
      projectId,
    );
  }
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member
