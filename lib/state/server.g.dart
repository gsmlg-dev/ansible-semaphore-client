// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$serversHash() => r'768a9c5c0a46fdb8321c9c93751c9d219ba95fa7';

/// See also [Servers].
@ProviderFor(Servers)
final serversProvider =
    AutoDisposeNotifierProvider<Servers, List<SemaphoreServer>>.internal(
  Servers.new,
  name: r'serversProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$serversHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Servers = AutoDisposeNotifier<List<SemaphoreServer>>;
String _$serverFamilyHash() => r'671415d2297e02e61388481437a075f7118975e0';

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

abstract class _$ServerFamily
    extends BuildlessAutoDisposeNotifier<SemaphoreServer?> {
  late final int? serverId;

  SemaphoreServer? build(
    int? serverId,
  );
}

/// See also [ServerFamily].
@ProviderFor(ServerFamily)
const serverFamilyProvider = ServerFamilyFamily();

/// See also [ServerFamily].
class ServerFamilyFamily extends Family<SemaphoreServer?> {
  /// See also [ServerFamily].
  const ServerFamilyFamily();

  /// See also [ServerFamily].
  ServerFamilyProvider call(
    int? serverId,
  ) {
    return ServerFamilyProvider(
      serverId,
    );
  }

  @override
  ServerFamilyProvider getProviderOverride(
    covariant ServerFamilyProvider provider,
  ) {
    return call(
      provider.serverId,
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
  String? get name => r'serverFamilyProvider';
}

/// See also [ServerFamily].
class ServerFamilyProvider
    extends AutoDisposeNotifierProviderImpl<ServerFamily, SemaphoreServer?> {
  /// See also [ServerFamily].
  ServerFamilyProvider(
    int? serverId,
  ) : this._internal(
          () => ServerFamily()..serverId = serverId,
          from: serverFamilyProvider,
          name: r'serverFamilyProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$serverFamilyHash,
          dependencies: ServerFamilyFamily._dependencies,
          allTransitiveDependencies:
              ServerFamilyFamily._allTransitiveDependencies,
          serverId: serverId,
        );

  ServerFamilyProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.serverId,
  }) : super.internal();

  final int? serverId;

  @override
  SemaphoreServer? runNotifierBuild(
    covariant ServerFamily notifier,
  ) {
    return notifier.build(
      serverId,
    );
  }

  @override
  Override overrideWith(ServerFamily Function() create) {
    return ProviderOverride(
      origin: this,
      override: ServerFamilyProvider._internal(
        () => create()..serverId = serverId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        serverId: serverId,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<ServerFamily, SemaphoreServer?>
      createElement() {
    return _ServerFamilyProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ServerFamilyProvider && other.serverId == serverId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, serverId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ServerFamilyRef on AutoDisposeNotifierProviderRef<SemaphoreServer?> {
  /// The parameter `serverId` of this provider.
  int? get serverId;
}

class _ServerFamilyProviderElement
    extends AutoDisposeNotifierProviderElement<ServerFamily, SemaphoreServer?>
    with ServerFamilyRef {
  _ServerFamilyProviderElement(super.provider);

  @override
  int? get serverId => (origin as ServerFamilyProvider).serverId;
}

String _$serverFormStateHash() => r'7a9a36a1c72904724505ed90e1d68aa047e6f09d';

abstract class _$ServerFormState
    extends BuildlessAutoDisposeNotifier<SemaphoreServer> {
  late final SemaphoreServer? server;

  SemaphoreServer build(
    SemaphoreServer? server,
  );
}

/// See also [ServerFormState].
@ProviderFor(ServerFormState)
const serverFormStateProvider = ServerFormStateFamily();

/// See also [ServerFormState].
class ServerFormStateFamily extends Family<SemaphoreServer> {
  /// See also [ServerFormState].
  const ServerFormStateFamily();

  /// See also [ServerFormState].
  ServerFormStateProvider call(
    SemaphoreServer? server,
  ) {
    return ServerFormStateProvider(
      server,
    );
  }

  @override
  ServerFormStateProvider getProviderOverride(
    covariant ServerFormStateProvider provider,
  ) {
    return call(
      provider.server,
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
  String? get name => r'serverFormStateProvider';
}

/// See also [ServerFormState].
class ServerFormStateProvider
    extends AutoDisposeNotifierProviderImpl<ServerFormState, SemaphoreServer> {
  /// See also [ServerFormState].
  ServerFormStateProvider(
    SemaphoreServer? server,
  ) : this._internal(
          () => ServerFormState()..server = server,
          from: serverFormStateProvider,
          name: r'serverFormStateProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$serverFormStateHash,
          dependencies: ServerFormStateFamily._dependencies,
          allTransitiveDependencies:
              ServerFormStateFamily._allTransitiveDependencies,
          server: server,
        );

  ServerFormStateProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.server,
  }) : super.internal();

  final SemaphoreServer? server;

  @override
  SemaphoreServer runNotifierBuild(
    covariant ServerFormState notifier,
  ) {
    return notifier.build(
      server,
    );
  }

  @override
  Override overrideWith(ServerFormState Function() create) {
    return ProviderOverride(
      origin: this,
      override: ServerFormStateProvider._internal(
        () => create()..server = server,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        server: server,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<ServerFormState, SemaphoreServer>
      createElement() {
    return _ServerFormStateProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ServerFormStateProvider && other.server == server;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, server.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ServerFormStateRef on AutoDisposeNotifierProviderRef<SemaphoreServer> {
  /// The parameter `server` of this provider.
  SemaphoreServer? get server;
}

class _ServerFormStateProviderElement
    extends AutoDisposeNotifierProviderElement<ServerFormState, SemaphoreServer>
    with ServerFormStateRef {
  _ServerFormStateProviderElement(super.provider);

  @override
  SemaphoreServer? get server => (origin as ServerFormStateProvider).server;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
