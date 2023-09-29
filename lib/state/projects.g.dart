// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'projects.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$projectsHash() => r'889889fcb788d623124c27b47758156b6ece81be';

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
String _$currentProjectHash() => r'2b96a611a187845786d53b7708e15b9194c572b1';

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
String _$projectFamilyHash() => r'09db0c3cc30e2233da78d1020ca278a244c82b54';

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
  late final int? projectId;

  Future<Project?> build(
    int? projectId,
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
    int? projectId,
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
    int? projectId,
  ) : this._internal(
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
          projectId: projectId,
        );

  ProjectFamilyProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.projectId,
  }) : super.internal();

  final int? projectId;

  @override
  Future<Project?> runNotifierBuild(
    covariant ProjectFamily notifier,
  ) {
    return notifier.build(
      projectId,
    );
  }

  @override
  Override overrideWith(ProjectFamily Function() create) {
    return ProviderOverride(
      origin: this,
      override: ProjectFamilyProvider._internal(
        () => create()..projectId = projectId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        projectId: projectId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<ProjectFamily, Project?>
      createElement() {
    return _ProjectFamilyProviderElement(this);
  }

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
}

mixin ProjectFamilyRef on AutoDisposeAsyncNotifierProviderRef<Project?> {
  /// The parameter `projectId` of this provider.
  int? get projectId;
}

class _ProjectFamilyProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<ProjectFamily, Project?>
    with ProjectFamilyRef {
  _ProjectFamilyProviderElement(super.provider);

  @override
  int? get projectId => (origin as ProjectFamilyProvider).projectId;
}

String _$projectFormStateHash() => r'1591ff1ccf537f8a328a13617bd558ae7322d192';

abstract class _$ProjectFormState
    extends BuildlessAutoDisposeNotifier<Project> {
  late final Project? project;

  Project build(
    Project? project,
  );
}

/// See also [ProjectFormState].
@ProviderFor(ProjectFormState)
const projectFormStateProvider = ProjectFormStateFamily();

/// See also [ProjectFormState].
class ProjectFormStateFamily extends Family<Project> {
  /// See also [ProjectFormState].
  const ProjectFormStateFamily();

  /// See also [ProjectFormState].
  ProjectFormStateProvider call(
    Project? project,
  ) {
    return ProjectFormStateProvider(
      project,
    );
  }

  @override
  ProjectFormStateProvider getProviderOverride(
    covariant ProjectFormStateProvider provider,
  ) {
    return call(
      provider.project,
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
  String? get name => r'projectFormStateProvider';
}

/// See also [ProjectFormState].
class ProjectFormStateProvider
    extends AutoDisposeNotifierProviderImpl<ProjectFormState, Project> {
  /// See also [ProjectFormState].
  ProjectFormStateProvider(
    Project? project,
  ) : this._internal(
          () => ProjectFormState()..project = project,
          from: projectFormStateProvider,
          name: r'projectFormStateProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$projectFormStateHash,
          dependencies: ProjectFormStateFamily._dependencies,
          allTransitiveDependencies:
              ProjectFormStateFamily._allTransitiveDependencies,
          project: project,
        );

  ProjectFormStateProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.project,
  }) : super.internal();

  final Project? project;

  @override
  Project runNotifierBuild(
    covariant ProjectFormState notifier,
  ) {
    return notifier.build(
      project,
    );
  }

  @override
  Override overrideWith(ProjectFormState Function() create) {
    return ProviderOverride(
      origin: this,
      override: ProjectFormStateProvider._internal(
        () => create()..project = project,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        project: project,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<ProjectFormState, Project>
      createElement() {
    return _ProjectFormStateProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProjectFormStateProvider && other.project == project;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, project.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ProjectFormStateRef on AutoDisposeNotifierProviderRef<Project> {
  /// The parameter `project` of this provider.
  Project? get project;
}

class _ProjectFormStateProviderElement
    extends AutoDisposeNotifierProviderElement<ProjectFormState, Project>
    with ProjectFormStateRef {
  _ProjectFormStateProviderElement(super.provider);

  @override
  Project? get project => (origin as ProjectFormStateProvider).project;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
