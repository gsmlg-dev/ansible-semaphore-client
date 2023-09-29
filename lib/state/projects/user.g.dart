// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userHash() => r'0112859846fd9e59a5133158de85b53176e6b784';

/// See also [user].
@ProviderFor(user)
final userProvider = AutoDisposeFutureProvider<List<User>>.internal(
  user,
  name: r'userProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$userHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UserRef = AutoDisposeFutureProviderRef<List<User>>;
String _$userListHash() => r'818d35c52b1a950977aa6e51abe1f7ecc1d18e3f';

/// See also [UserList].
@ProviderFor(UserList)
final userListProvider =
    AutoDisposeNotifierProvider<UserList, UserDataTable>.internal(
  UserList.new,
  name: r'userListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$userListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$UserList = AutoDisposeNotifier<UserDataTable>;
String _$projectUserFormRequestHash() =>
    r'359460a585923c9f31310aea0c84bfbda3ad9a33';

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

abstract class _$ProjectUserFormRequest
    extends BuildlessAutoDisposeNotifier<ProjectProjectIdUsersPostRequest> {
  late final User? item;

  ProjectProjectIdUsersPostRequest build(
    User? item,
  );
}

/// See also [ProjectUserFormRequest].
@ProviderFor(ProjectUserFormRequest)
const projectUserFormRequestProvider = ProjectUserFormRequestFamily();

/// See also [ProjectUserFormRequest].
class ProjectUserFormRequestFamily
    extends Family<ProjectProjectIdUsersPostRequest> {
  /// See also [ProjectUserFormRequest].
  const ProjectUserFormRequestFamily();

  /// See also [ProjectUserFormRequest].
  ProjectUserFormRequestProvider call(
    User? item,
  ) {
    return ProjectUserFormRequestProvider(
      item,
    );
  }

  @override
  ProjectUserFormRequestProvider getProviderOverride(
    covariant ProjectUserFormRequestProvider provider,
  ) {
    return call(
      provider.item,
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
  String? get name => r'projectUserFormRequestProvider';
}

/// See also [ProjectUserFormRequest].
class ProjectUserFormRequestProvider extends AutoDisposeNotifierProviderImpl<
    ProjectUserFormRequest, ProjectProjectIdUsersPostRequest> {
  /// See also [ProjectUserFormRequest].
  ProjectUserFormRequestProvider(
    User? item,
  ) : this._internal(
          () => ProjectUserFormRequest()..item = item,
          from: projectUserFormRequestProvider,
          name: r'projectUserFormRequestProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$projectUserFormRequestHash,
          dependencies: ProjectUserFormRequestFamily._dependencies,
          allTransitiveDependencies:
              ProjectUserFormRequestFamily._allTransitiveDependencies,
          item: item,
        );

  ProjectUserFormRequestProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.item,
  }) : super.internal();

  final User? item;

  @override
  ProjectProjectIdUsersPostRequest runNotifierBuild(
    covariant ProjectUserFormRequest notifier,
  ) {
    return notifier.build(
      item,
    );
  }

  @override
  Override overrideWith(ProjectUserFormRequest Function() create) {
    return ProviderOverride(
      origin: this,
      override: ProjectUserFormRequestProvider._internal(
        () => create()..item = item,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        item: item,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<ProjectUserFormRequest,
      ProjectProjectIdUsersPostRequest> createElement() {
    return _ProjectUserFormRequestProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProjectUserFormRequestProvider && other.item == item;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, item.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ProjectUserFormRequestRef
    on AutoDisposeNotifierProviderRef<ProjectProjectIdUsersPostRequest> {
  /// The parameter `item` of this provider.
  User? get item;
}

class _ProjectUserFormRequestProviderElement
    extends AutoDisposeNotifierProviderElement<ProjectUserFormRequest,
        ProjectProjectIdUsersPostRequest> with ProjectUserFormRequestRef {
  _ProjectUserFormRequestProviderElement(super.provider);

  @override
  User? get item => (origin as ProjectUserFormRequestProvider).item;
}

String _$projectUserRoleFormRequestHash() =>
    r'ca8240353300e363b4f65670f824f2eb04c7321b';

abstract class _$ProjectUserRoleFormRequest
    extends BuildlessAutoDisposeNotifier<
        ProjectProjectIdUsersUserIdPutRequest> {
  late final User? item;

  ProjectProjectIdUsersUserIdPutRequest build(
    User? item,
  );
}

/// See also [ProjectUserRoleFormRequest].
@ProviderFor(ProjectUserRoleFormRequest)
const projectUserRoleFormRequestProvider = ProjectUserRoleFormRequestFamily();

/// See also [ProjectUserRoleFormRequest].
class ProjectUserRoleFormRequestFamily
    extends Family<ProjectProjectIdUsersUserIdPutRequest> {
  /// See also [ProjectUserRoleFormRequest].
  const ProjectUserRoleFormRequestFamily();

  /// See also [ProjectUserRoleFormRequest].
  ProjectUserRoleFormRequestProvider call(
    User? item,
  ) {
    return ProjectUserRoleFormRequestProvider(
      item,
    );
  }

  @override
  ProjectUserRoleFormRequestProvider getProviderOverride(
    covariant ProjectUserRoleFormRequestProvider provider,
  ) {
    return call(
      provider.item,
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
  String? get name => r'projectUserRoleFormRequestProvider';
}

/// See also [ProjectUserRoleFormRequest].
class ProjectUserRoleFormRequestProvider
    extends AutoDisposeNotifierProviderImpl<ProjectUserRoleFormRequest,
        ProjectProjectIdUsersUserIdPutRequest> {
  /// See also [ProjectUserRoleFormRequest].
  ProjectUserRoleFormRequestProvider(
    User? item,
  ) : this._internal(
          () => ProjectUserRoleFormRequest()..item = item,
          from: projectUserRoleFormRequestProvider,
          name: r'projectUserRoleFormRequestProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$projectUserRoleFormRequestHash,
          dependencies: ProjectUserRoleFormRequestFamily._dependencies,
          allTransitiveDependencies:
              ProjectUserRoleFormRequestFamily._allTransitiveDependencies,
          item: item,
        );

  ProjectUserRoleFormRequestProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.item,
  }) : super.internal();

  final User? item;

  @override
  ProjectProjectIdUsersUserIdPutRequest runNotifierBuild(
    covariant ProjectUserRoleFormRequest notifier,
  ) {
    return notifier.build(
      item,
    );
  }

  @override
  Override overrideWith(ProjectUserRoleFormRequest Function() create) {
    return ProviderOverride(
      origin: this,
      override: ProjectUserRoleFormRequestProvider._internal(
        () => create()..item = item,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        item: item,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<ProjectUserRoleFormRequest,
      ProjectProjectIdUsersUserIdPutRequest> createElement() {
    return _ProjectUserRoleFormRequestProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProjectUserRoleFormRequestProvider && other.item == item;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, item.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ProjectUserRoleFormRequestRef
    on AutoDisposeNotifierProviderRef<ProjectProjectIdUsersUserIdPutRequest> {
  /// The parameter `item` of this provider.
  User? get item;
}

class _ProjectUserRoleFormRequestProviderElement
    extends AutoDisposeNotifierProviderElement<ProjectUserRoleFormRequest,
        ProjectProjectIdUsersUserIdPutRequest>
    with ProjectUserRoleFormRequestRef {
  _ProjectUserRoleFormRequestProviderElement(super.provider);

  @override
  User? get item => (origin as ProjectUserRoleFormRequestProvider).item;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
