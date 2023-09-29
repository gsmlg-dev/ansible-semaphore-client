// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$systemUserHash() => r'aeb37a69ab6d4694db195c16707d985c8e06c086';

/// See also [systemUser].
@ProviderFor(systemUser)
final systemUserProvider = AutoDisposeFutureProvider<List<User>>.internal(
  systemUser,
  name: r'systemUserProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$systemUserHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SystemUserRef = AutoDisposeFutureProviderRef<List<User>>;
String _$systemUserFamilyHash() => r'ec7a6bdf7b372d63be25a51887470ed3aef615d2';

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

/// See also [systemUserFamily].
@ProviderFor(systemUserFamily)
const systemUserFamilyProvider = SystemUserFamilyFamily();

/// See also [systemUserFamily].
class SystemUserFamilyFamily extends Family<AsyncValue<User>> {
  /// See also [systemUserFamily].
  const SystemUserFamilyFamily();

  /// See also [systemUserFamily].
  SystemUserFamilyProvider call(
    int? id,
  ) {
    return SystemUserFamilyProvider(
      id,
    );
  }

  @override
  SystemUserFamilyProvider getProviderOverride(
    covariant SystemUserFamilyProvider provider,
  ) {
    return call(
      provider.id,
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
  String? get name => r'systemUserFamilyProvider';
}

/// See also [systemUserFamily].
class SystemUserFamilyProvider extends AutoDisposeFutureProvider<User> {
  /// See also [systemUserFamily].
  SystemUserFamilyProvider(
    int? id,
  ) : this._internal(
          (ref) => systemUserFamily(
            ref as SystemUserFamilyRef,
            id,
          ),
          from: systemUserFamilyProvider,
          name: r'systemUserFamilyProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$systemUserFamilyHash,
          dependencies: SystemUserFamilyFamily._dependencies,
          allTransitiveDependencies:
              SystemUserFamilyFamily._allTransitiveDependencies,
          id: id,
        );

  SystemUserFamilyProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final int? id;

  @override
  Override overrideWith(
    FutureOr<User> Function(SystemUserFamilyRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SystemUserFamilyProvider._internal(
        (ref) => create(ref as SystemUserFamilyRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<User> createElement() {
    return _SystemUserFamilyProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SystemUserFamilyProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SystemUserFamilyRef on AutoDisposeFutureProviderRef<User> {
  /// The parameter `id` of this provider.
  int? get id;
}

class _SystemUserFamilyProviderElement
    extends AutoDisposeFutureProviderElement<User> with SystemUserFamilyRef {
  _SystemUserFamilyProviderElement(super.provider);

  @override
  int? get id => (origin as SystemUserFamilyProvider).id;
}

String _$systemUserListHash() => r'85b2a9caee165f5d29c1f7b5b63e8178230e9302';

/// See also [SystemUserList].
@ProviderFor(SystemUserList)
final systemUserListProvider =
    AutoDisposeNotifierProvider<SystemUserList, SystemUserDataTable>.internal(
  SystemUserList.new,
  name: r'systemUserListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$systemUserListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SystemUserList = AutoDisposeNotifier<SystemUserDataTable>;
String _$systemUserFormRequestHash() =>
    r'1cf111985ec80aaef1e85429e46e4a567e0bc55a';

abstract class _$SystemUserFormRequest
    extends BuildlessAutoDisposeNotifier<UserPutRequest> {
  late final User? item;

  UserPutRequest build(
    User? item,
  );
}

/// See also [SystemUserFormRequest].
@ProviderFor(SystemUserFormRequest)
const systemUserFormRequestProvider = SystemUserFormRequestFamily();

/// See also [SystemUserFormRequest].
class SystemUserFormRequestFamily extends Family<UserPutRequest> {
  /// See also [SystemUserFormRequest].
  const SystemUserFormRequestFamily();

  /// See also [SystemUserFormRequest].
  SystemUserFormRequestProvider call(
    User? item,
  ) {
    return SystemUserFormRequestProvider(
      item,
    );
  }

  @override
  SystemUserFormRequestProvider getProviderOverride(
    covariant SystemUserFormRequestProvider provider,
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
  String? get name => r'systemUserFormRequestProvider';
}

/// See also [SystemUserFormRequest].
class SystemUserFormRequestProvider extends AutoDisposeNotifierProviderImpl<
    SystemUserFormRequest, UserPutRequest> {
  /// See also [SystemUserFormRequest].
  SystemUserFormRequestProvider(
    User? item,
  ) : this._internal(
          () => SystemUserFormRequest()..item = item,
          from: systemUserFormRequestProvider,
          name: r'systemUserFormRequestProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$systemUserFormRequestHash,
          dependencies: SystemUserFormRequestFamily._dependencies,
          allTransitiveDependencies:
              SystemUserFormRequestFamily._allTransitiveDependencies,
          item: item,
        );

  SystemUserFormRequestProvider._internal(
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
  UserPutRequest runNotifierBuild(
    covariant SystemUserFormRequest notifier,
  ) {
    return notifier.build(
      item,
    );
  }

  @override
  Override overrideWith(SystemUserFormRequest Function() create) {
    return ProviderOverride(
      origin: this,
      override: SystemUserFormRequestProvider._internal(
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
  AutoDisposeNotifierProviderElement<SystemUserFormRequest, UserPutRequest>
      createElement() {
    return _SystemUserFormRequestProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SystemUserFormRequestProvider && other.item == item;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, item.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SystemUserFormRequestRef
    on AutoDisposeNotifierProviderRef<UserPutRequest> {
  /// The parameter `item` of this provider.
  User? get item;
}

class _SystemUserFormRequestProviderElement
    extends AutoDisposeNotifierProviderElement<SystemUserFormRequest,
        UserPutRequest> with SystemUserFormRequestRef {
  _SystemUserFormRequestProviderElement(super.provider);

  @override
  User? get item => (origin as SystemUserFormRequestProvider).item;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
