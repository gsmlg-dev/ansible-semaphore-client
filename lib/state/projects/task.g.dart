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
    int id,
  ) : this._internal(
          (ref) => taskFamily(
            ref as TaskFamilyRef,
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
          id: id,
        );

  TaskFamilyProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final int id;

  @override
  Override overrideWith(
    FutureOr<Task> Function(TaskFamilyRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TaskFamilyProvider._internal(
        (ref) => create(ref as TaskFamilyRef),
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
  AutoDisposeFutureProviderElement<Task> createElement() {
    return _TaskFamilyProviderElement(this);
  }

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

mixin TaskFamilyRef on AutoDisposeFutureProviderRef<Task> {
  /// The parameter `id` of this provider.
  int get id;
}

class _TaskFamilyProviderElement extends AutoDisposeFutureProviderElement<Task>
    with TaskFamilyRef {
  _TaskFamilyProviderElement(super.provider);

  @override
  int get id => (origin as TaskFamilyProvider).id;
}

String _$taskOutputHash() => r'941cc24b5817823d370bc488d41106103efcc45d';

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
    int id,
  ) : this._internal(
          (ref) => taskOutput(
            ref as TaskOutputRef,
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
          id: id,
        );

  TaskOutputProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final int id;

  @override
  Override overrideWith(
    FutureOr<List<TaskOutput>> Function(TaskOutputRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TaskOutputProvider._internal(
        (ref) => create(ref as TaskOutputRef),
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
  AutoDisposeFutureProviderElement<List<TaskOutput>> createElement() {
    return _TaskOutputProviderElement(this);
  }

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

mixin TaskOutputRef on AutoDisposeFutureProviderRef<List<TaskOutput>> {
  /// The parameter `id` of this provider.
  int get id;
}

class _TaskOutputProviderElement
    extends AutoDisposeFutureProviderElement<List<TaskOutput>>
    with TaskOutputRef {
  _TaskOutputProviderElement(super.provider);

  @override
  int get id => (origin as TaskOutputProvider).id;
}

String _$taskOutputStreamHash() => r'bbdffab0b83bbd4824ad3cbca5d2e16bf3343c18';

/// See also [taskOutputStream].
@ProviderFor(taskOutputStream)
const taskOutputStreamProvider = TaskOutputStreamFamily();

/// See also [taskOutputStream].
class TaskOutputStreamFamily
    extends Family<AsyncValue<(Task, List<TaskOutput>)>> {
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
    extends AutoDisposeStreamProvider<(Task, List<TaskOutput>)> {
  /// See also [taskOutputStream].
  TaskOutputStreamProvider(
    int taskId,
  ) : this._internal(
          (ref) => taskOutputStream(
            ref as TaskOutputStreamRef,
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
          taskId: taskId,
        );

  TaskOutputStreamProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.taskId,
  }) : super.internal();

  final int taskId;

  @override
  Override overrideWith(
    Stream<(Task, List<TaskOutput>)> Function(TaskOutputStreamRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TaskOutputStreamProvider._internal(
        (ref) => create(ref as TaskOutputStreamRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        taskId: taskId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<(Task, List<TaskOutput>)> createElement() {
    return _TaskOutputStreamProviderElement(this);
  }

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

mixin TaskOutputStreamRef
    on AutoDisposeStreamProviderRef<(Task, List<TaskOutput>)> {
  /// The parameter `taskId` of this provider.
  int get taskId;
}

class _TaskOutputStreamProviderElement
    extends AutoDisposeStreamProviderElement<(Task, List<TaskOutput>)>
    with TaskOutputStreamRef {
  _TaskOutputStreamProviderElement(super.provider);

  @override
  int get taskId => (origin as TaskOutputStreamProvider).taskId;
}

String _$taskListHash() => r'c953051e136b9c07dbae4ad7ae793949f2220095';

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
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
