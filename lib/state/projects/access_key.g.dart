// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'access_key.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$accessKeyHash() => r'958afabe0c0d03cc9bf04d5e0d3a208bfe2c7981';

/// See also [accessKey].
@ProviderFor(accessKey)
final accessKeyProvider = AutoDisposeFutureProvider<List<AccessKey>>.internal(
  accessKey,
  name: r'accessKeyProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$accessKeyHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AccessKeyRef = AutoDisposeFutureProviderRef<List<AccessKey>>;
String _$accessKeyListHash() => r'23862c96cb86600539e754c09071c94b816fe1ac';

/// See also [AccessKeyList].
@ProviderFor(AccessKeyList)
final accessKeyListProvider =
    AutoDisposeNotifierProvider<AccessKeyList, AccessKeyDataTable>.internal(
  AccessKeyList.new,
  name: r'accessKeyListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$accessKeyListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AccessKeyList = AutoDisposeNotifier<AccessKeyDataTable>;
String _$accessKeyFormRequestHash() =>
    r'39f3a8ece0813f2a2662efe9d3984711ff83a3ce';

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

abstract class _$AccessKeyFormRequest
    extends BuildlessAutoDisposeNotifier<AccessKeyRequest> {
  late final AccessKey? item;

  AccessKeyRequest build(
    AccessKey? item,
  );
}

/// See also [AccessKeyFormRequest].
@ProviderFor(AccessKeyFormRequest)
const accessKeyFormRequestProvider = AccessKeyFormRequestFamily();

/// See also [AccessKeyFormRequest].
class AccessKeyFormRequestFamily extends Family<AccessKeyRequest> {
  /// See also [AccessKeyFormRequest].
  const AccessKeyFormRequestFamily();

  /// See also [AccessKeyFormRequest].
  AccessKeyFormRequestProvider call(
    AccessKey? item,
  ) {
    return AccessKeyFormRequestProvider(
      item,
    );
  }

  @override
  AccessKeyFormRequestProvider getProviderOverride(
    covariant AccessKeyFormRequestProvider provider,
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
  String? get name => r'accessKeyFormRequestProvider';
}

/// See also [AccessKeyFormRequest].
class AccessKeyFormRequestProvider extends AutoDisposeNotifierProviderImpl<
    AccessKeyFormRequest, AccessKeyRequest> {
  /// See also [AccessKeyFormRequest].
  AccessKeyFormRequestProvider(
    AccessKey? item,
  ) : this._internal(
          () => AccessKeyFormRequest()..item = item,
          from: accessKeyFormRequestProvider,
          name: r'accessKeyFormRequestProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$accessKeyFormRequestHash,
          dependencies: AccessKeyFormRequestFamily._dependencies,
          allTransitiveDependencies:
              AccessKeyFormRequestFamily._allTransitiveDependencies,
          item: item,
        );

  AccessKeyFormRequestProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.item,
  }) : super.internal();

  final AccessKey? item;

  @override
  AccessKeyRequest runNotifierBuild(
    covariant AccessKeyFormRequest notifier,
  ) {
    return notifier.build(
      item,
    );
  }

  @override
  Override overrideWith(AccessKeyFormRequest Function() create) {
    return ProviderOverride(
      origin: this,
      override: AccessKeyFormRequestProvider._internal(
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
  AutoDisposeNotifierProviderElement<AccessKeyFormRequest, AccessKeyRequest>
      createElement() {
    return _AccessKeyFormRequestProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AccessKeyFormRequestProvider && other.item == item;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, item.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin AccessKeyFormRequestRef
    on AutoDisposeNotifierProviderRef<AccessKeyRequest> {
  /// The parameter `item` of this provider.
  AccessKey? get item;
}

class _AccessKeyFormRequestProviderElement
    extends AutoDisposeNotifierProviderElement<AccessKeyFormRequest,
        AccessKeyRequest> with AccessKeyFormRequestRef {
  _AccessKeyFormRequestProviderElement(super.provider);

  @override
  AccessKey? get item => (origin as AccessKeyFormRequestProvider).item;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
