// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$taskFamilyHash() => r'e5344773489d4c1260ed7db0c9ad78edba0cd7f8';

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

typedef TaskFamilyRef = AutoDisposeFutureProviderRef<Task>;

/// See also [taskFamily].
@ProviderFor(taskFamily)
const taskFamilyProvider = TaskFamilyFamily();

/// See also [taskFamily].
class TaskFamilyFamily extends Family<AsyncValue<Task>> {
  /// See also [taskFamily].
  const TaskFamilyFamily();

  /// See also [taskFamily].
  TaskFamilyProvider call(
    int id,
  ) {
    return TaskFamilyProvider(
      id,
    );
  }

  @override
  TaskFamilyProvider getProviderOverride(
    covariant TaskFamilyProvider provider,
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
  String? get name => r'taskFamilyProvider';
}

/// See also [taskFamily].
class TaskFamilyProvider extends AutoDisposeFutureProvider<Task> {
  /// See also [taskFamily].
  TaskFamilyProvider(
    this.id,
  ) : super.internal(
          (ref) => taskFamily(
            ref,
            id,
          ),
          from: taskFamilyProvider,
          name: r'taskFamilyProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$taskFamilyHash,
          dependencies: TaskFamilyFamily._dependencies,
          allTransitiveDependencies:
              TaskFamilyFamily._allTransitiveDependencies,
        );

  final int id;

  @override
  bool operator ==(Object other) {
    return other is TaskFamilyProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$taskOutputHash() => r'941cc24b5817823d370bc488d41106103efcc45d';
typedef TaskOutputRef = AutoDisposeFutureProviderRef<List<TaskOutput>>;

/// See also [taskOutput].
@ProviderFor(taskOutput)
const taskOutputProvider = TaskOutputFamily();

/// See also [taskOutput].
class TaskOutputFamily extends Family<AsyncValue<List<TaskOutput>>> {
  /// See also [taskOutput].
  const TaskOutputFamily();

  /// See also [taskOutput].
  TaskOutputProvider call(
    int id,
  ) {
    return TaskOutputProvider(
      id,
    );
  }

  @override
  TaskOutputProvider getProviderOverride(
    covariant TaskOutputProvider provider,
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
  String? get name => r'taskOutputProvider';
}

/// See also [taskOutput].
class TaskOutputProvider extends AutoDisposeFutureProvider<List<TaskOutput>> {
  /// See also [taskOutput].
  TaskOutputProvider(
    this.id,
  ) : super.internal(
          (ref) => taskOutput(
            ref,
            id,
          ),
          from: taskOutputProvider,
          name: r'taskOutputProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$taskOutputHash,
          dependencies: TaskOutputFamily._dependencies,
          allTransitiveDependencies:
              TaskOutputFamily._allTransitiveDependencies,
        );

  final int id;

  @override
  bool operator ==(Object other) {
    return other is TaskOutputProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$taskOutputStreamHash() => r'ad50955a6d358fefb5877a09754050c445cad475';
typedef TaskOutputStreamRef = AutoDisposeStreamProviderRef<List<TaskOutput>>;

/// See also [taskOutputStream].
@ProviderFor(taskOutputStream)
const taskOutputStreamProvider = TaskOutputStreamFamily();

/// See also [taskOutputStream].
class TaskOutputStreamFamily extends Family<AsyncValue<List<TaskOutput>>> {
  /// See also [taskOutputStream].
  const TaskOutputStreamFamily();

  /// See also [taskOutputStream].
  TaskOutputStreamProvider call(
    int taskId,
  ) {
    return TaskOutputStreamProvider(
      taskId,
    );
  }

  @override
  TaskOutputStreamProvider getProviderOverride(
    covariant TaskOutputStreamProvider provider,
  ) {
    return call(
      provider.taskId,
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
  String? get name => r'taskOutputStreamProvider';
}

/// See also [taskOutputStream].
class TaskOutputStreamProvider
    extends AutoDisposeStreamProvider<List<TaskOutput>> {
  /// See also [taskOutputStream].
  TaskOutputStreamProvider(
    this.taskId,
  ) : super.internal(
          (ref) => taskOutputStream(
            ref,
            taskId,
          ),
          from: taskOutputStreamProvider,
          name: r'taskOutputStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$taskOutputStreamHash,
          dependencies: TaskOutputStreamFamily._dependencies,
          allTransitiveDependencies:
              TaskOutputStreamFamily._allTransitiveDependencies,
        );

  final int taskId;

  @override
  bool operator ==(Object other) {
    return other is TaskOutputStreamProvider && other.taskId == taskId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, taskId.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$taskListHash() => r'117a7f642010f111b30261e917874e02a8f4c3a7';

/// See also [TaskList].
@ProviderFor(TaskList)
final taskListProvider =
    AutoDisposeNotifierProvider<TaskList, TaskDataTable>.internal(
  TaskList.new,
  name: r'taskListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$taskListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TaskList = AutoDisposeNotifier<TaskDataTable>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member
