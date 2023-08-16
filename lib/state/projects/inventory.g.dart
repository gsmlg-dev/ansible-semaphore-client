// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$inventoryHash() => r'ff17baa2556ce371b951219e4f1c59d232de0a6c';

/// See also [inventory].
@ProviderFor(inventory)
final inventoryProvider = AutoDisposeFutureProvider<List<Inventory>>.internal(
  inventory,
  name: r'inventoryProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$inventoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef InventoryRef = AutoDisposeFutureProviderRef<List<Inventory>>;
String _$inventoryListHash() => r'827dfadfd6ff8ec30eb196c1e709c29b26f19729';

/// See also [InventoryList].
@ProviderFor(InventoryList)
final inventoryListProvider =
    AutoDisposeNotifierProvider<InventoryList, InventoryDataTable>.internal(
  InventoryList.new,
  name: r'inventoryListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$inventoryListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$InventoryList = AutoDisposeNotifier<InventoryDataTable>;
String _$inventoryFormRequestHash() =>
    r'09be64cc4f308fa051ef42d3f0797ff37c51e213';

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

abstract class _$InventoryFormRequest
    extends BuildlessAutoDisposeNotifier<InventoryRequest> {
  late final Inventory? item;

  InventoryRequest build(
    Inventory? item,
  );
}

/// See also [InventoryFormRequest].
@ProviderFor(InventoryFormRequest)
const inventoryFormRequestProvider = InventoryFormRequestFamily();

/// See also [InventoryFormRequest].
class InventoryFormRequestFamily extends Family<InventoryRequest> {
  /// See also [InventoryFormRequest].
  const InventoryFormRequestFamily();

  /// See also [InventoryFormRequest].
  InventoryFormRequestProvider call(
    Inventory? item,
  ) {
    return InventoryFormRequestProvider(
      item,
    );
  }

  @override
  InventoryFormRequestProvider getProviderOverride(
    covariant InventoryFormRequestProvider provider,
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
  String? get name => r'inventoryFormRequestProvider';
}

/// See also [InventoryFormRequest].
class InventoryFormRequestProvider extends AutoDisposeNotifierProviderImpl<
    InventoryFormRequest, InventoryRequest> {
  /// See also [InventoryFormRequest].
  InventoryFormRequestProvider(
    this.item,
  ) : super.internal(
          () => InventoryFormRequest()..item = item,
          from: inventoryFormRequestProvider,
          name: r'inventoryFormRequestProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$inventoryFormRequestHash,
          dependencies: InventoryFormRequestFamily._dependencies,
          allTransitiveDependencies:
              InventoryFormRequestFamily._allTransitiveDependencies,
        );

  final Inventory? item;

  @override
  bool operator ==(Object other) {
    return other is InventoryFormRequestProvider && other.item == item;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, item.hashCode);

    return _SystemHash.finish(hash);
  }

  @override
  InventoryRequest runNotifierBuild(
    covariant InventoryFormRequest notifier,
  ) {
    return notifier.build(
      item,
    );
  }
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member
