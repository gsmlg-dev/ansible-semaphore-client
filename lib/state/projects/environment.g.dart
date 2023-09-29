// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'environment.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$environmentHash() => r'2fa364d38b230eada5dd38e31dbae91da61c5e23';

/// See also [environment].
@ProviderFor(environment)
final environmentProvider =
    AutoDisposeFutureProvider<List<Environment>>.internal(
  environment,
  name: r'environmentProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$environmentHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef EnvironmentRef = AutoDisposeFutureProviderRef<List<Environment>>;
String _$environmentListHash() => r'204289c91c5c128d818cb4bfaa503d523cab3cc8';

/// See also [EnvironmentList].
@ProviderFor(EnvironmentList)
final environmentListProvider =
    AutoDisposeNotifierProvider<EnvironmentList, EnvironmentDataTable>.internal(
  EnvironmentList.new,
  name: r'environmentListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$environmentListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$EnvironmentList = AutoDisposeNotifier<EnvironmentDataTable>;
String _$environmentFormRequestHash() =>
    r'49fc9877ce5154d3b7ac9b9929c12a43dff7ee85';

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

abstract class _$EnvironmentFormRequest
    extends BuildlessAutoDisposeNotifier<EnvironmentRequest> {
  late final Environment? item;

  EnvironmentRequest build(
    Environment? item,
  );
}

/// See also [EnvironmentFormRequest].
@ProviderFor(EnvironmentFormRequest)
const environmentFormRequestProvider = EnvironmentFormRequestFamily();

/// See also [EnvironmentFormRequest].
class EnvironmentFormRequestFamily extends Family<EnvironmentRequest> {
  /// See also [EnvironmentFormRequest].
  const EnvironmentFormRequestFamily();

  /// See also [EnvironmentFormRequest].
  EnvironmentFormRequestProvider call(
    Environment? item,
  ) {
    return EnvironmentFormRequestProvider(
      item,
    );
  }

  @override
  EnvironmentFormRequestProvider getProviderOverride(
    covariant EnvironmentFormRequestProvider provider,
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
  String? get name => r'environmentFormRequestProvider';
}

/// See also [EnvironmentFormRequest].
class EnvironmentFormRequestProvider extends AutoDisposeNotifierProviderImpl<
    EnvironmentFormRequest, EnvironmentRequest> {
  /// See also [EnvironmentFormRequest].
  EnvironmentFormRequestProvider(
    Environment? item,
  ) : this._internal(
          () => EnvironmentFormRequest()..item = item,
          from: environmentFormRequestProvider,
          name: r'environmentFormRequestProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$environmentFormRequestHash,
          dependencies: EnvironmentFormRequestFamily._dependencies,
          allTransitiveDependencies:
              EnvironmentFormRequestFamily._allTransitiveDependencies,
          item: item,
        );

  EnvironmentFormRequestProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.item,
  }) : super.internal();

  final Environment? item;

  @override
  EnvironmentRequest runNotifierBuild(
    covariant EnvironmentFormRequest notifier,
  ) {
    return notifier.build(
      item,
    );
  }

  @override
  Override overrideWith(EnvironmentFormRequest Function() create) {
    return ProviderOverride(
      origin: this,
      override: EnvironmentFormRequestProvider._internal(
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
  AutoDisposeNotifierProviderElement<EnvironmentFormRequest, EnvironmentRequest>
      createElement() {
    return _EnvironmentFormRequestProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is EnvironmentFormRequestProvider && other.item == item;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, item.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin EnvironmentFormRequestRef
    on AutoDisposeNotifierProviderRef<EnvironmentRequest> {
  /// The parameter `item` of this provider.
  Environment? get item;
}

class _EnvironmentFormRequestProviderElement
    extends AutoDisposeNotifierProviderElement<EnvironmentFormRequest,
        EnvironmentRequest> with EnvironmentFormRequestRef {
  _EnvironmentFormRequestProviderElement(super.provider);

  @override
  Environment? get item => (origin as EnvironmentFormRequestProvider).item;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
