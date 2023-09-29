// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$repositoryHash() => r'0b318197af37afaa3d5c64a1474fd3ebd587ccfb';

/// See also [repository].
@ProviderFor(repository)
final repositoryProvider = AutoDisposeFutureProvider<List<Repository>>.internal(
  repository,
  name: r'repositoryProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$repositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef RepositoryRef = AutoDisposeFutureProviderRef<List<Repository>>;
String _$repositoryListHash() => r'1f04293b4e524da846ca0604cb2df5729b8fa892';

/// See also [RepositoryList].
@ProviderFor(RepositoryList)
final repositoryListProvider =
    AutoDisposeNotifierProvider<RepositoryList, RepositoryDataTable>.internal(
  RepositoryList.new,
  name: r'repositoryListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$repositoryListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$RepositoryList = AutoDisposeNotifier<RepositoryDataTable>;
String _$repositoryFormRequestHash() =>
    r'5b2d55d183d0bd023628eb1cd953cf0f8f27d9f2';

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

abstract class _$RepositoryFormRequest
    extends BuildlessAutoDisposeNotifier<RepositoryRequest> {
  late final Repository? item;

  RepositoryRequest build(
    Repository? item,
  );
}

/// See also [RepositoryFormRequest].
@ProviderFor(RepositoryFormRequest)
const repositoryFormRequestProvider = RepositoryFormRequestFamily();

/// See also [RepositoryFormRequest].
class RepositoryFormRequestFamily extends Family<RepositoryRequest> {
  /// See also [RepositoryFormRequest].
  const RepositoryFormRequestFamily();

  /// See also [RepositoryFormRequest].
  RepositoryFormRequestProvider call(
    Repository? item,
  ) {
    return RepositoryFormRequestProvider(
      item,
    );
  }

  @override
  RepositoryFormRequestProvider getProviderOverride(
    covariant RepositoryFormRequestProvider provider,
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
  String? get name => r'repositoryFormRequestProvider';
}

/// See also [RepositoryFormRequest].
class RepositoryFormRequestProvider extends AutoDisposeNotifierProviderImpl<
    RepositoryFormRequest, RepositoryRequest> {
  /// See also [RepositoryFormRequest].
  RepositoryFormRequestProvider(
    Repository? item,
  ) : this._internal(
          () => RepositoryFormRequest()..item = item,
          from: repositoryFormRequestProvider,
          name: r'repositoryFormRequestProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$repositoryFormRequestHash,
          dependencies: RepositoryFormRequestFamily._dependencies,
          allTransitiveDependencies:
              RepositoryFormRequestFamily._allTransitiveDependencies,
          item: item,
        );

  RepositoryFormRequestProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.item,
  }) : super.internal();

  final Repository? item;

  @override
  RepositoryRequest runNotifierBuild(
    covariant RepositoryFormRequest notifier,
  ) {
    return notifier.build(
      item,
    );
  }

  @override
  Override overrideWith(RepositoryFormRequest Function() create) {
    return ProviderOverride(
      origin: this,
      override: RepositoryFormRequestProvider._internal(
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
  AutoDisposeNotifierProviderElement<RepositoryFormRequest, RepositoryRequest>
      createElement() {
    return _RepositoryFormRequestProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RepositoryFormRequestProvider && other.item == item;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, item.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin RepositoryFormRequestRef
    on AutoDisposeNotifierProviderRef<RepositoryRequest> {
  /// The parameter `item` of this provider.
  Repository? get item;
}

class _RepositoryFormRequestProviderElement
    extends AutoDisposeNotifierProviderElement<RepositoryFormRequest,
        RepositoryRequest> with RepositoryFormRequestRef {
  _RepositoryFormRequestProviderElement(super.provider);

  @override
  Repository? get item => (origin as RepositoryFormRequestProvider).item;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
