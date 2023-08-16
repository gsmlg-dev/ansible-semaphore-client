// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'template_task.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$templateTaskListHash() => r'8a36e0ae050032f59129fd04b5fce194e371173e';

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

abstract class _$TemplateTaskList
    extends BuildlessAutoDisposeNotifier<TemplateTaskDataTable> {
  late final int templateId;

  TemplateTaskDataTable build({
    required int templateId,
  });
}

/// See also [TemplateTaskList].
@ProviderFor(TemplateTaskList)
const templateTaskListProvider = TemplateTaskListFamily();

/// See also [TemplateTaskList].
class TemplateTaskListFamily extends Family<TemplateTaskDataTable> {
  /// See also [TemplateTaskList].
  const TemplateTaskListFamily();

  /// See also [TemplateTaskList].
  TemplateTaskListProvider call({
    required int templateId,
  }) {
    return TemplateTaskListProvider(
      templateId: templateId,
    );
  }

  @override
  TemplateTaskListProvider getProviderOverride(
    covariant TemplateTaskListProvider provider,
  ) {
    return call(
      templateId: provider.templateId,
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
  String? get name => r'templateTaskListProvider';
}

/// See also [TemplateTaskList].
class TemplateTaskListProvider extends AutoDisposeNotifierProviderImpl<
    TemplateTaskList, TemplateTaskDataTable> {
  /// See also [TemplateTaskList].
  TemplateTaskListProvider({
    required this.templateId,
  }) : super.internal(
          () => TemplateTaskList()..templateId = templateId,
          from: templateTaskListProvider,
          name: r'templateTaskListProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$templateTaskListHash,
          dependencies: TemplateTaskListFamily._dependencies,
          allTransitiveDependencies:
              TemplateTaskListFamily._allTransitiveDependencies,
        );

  final int templateId;

  @override
  bool operator ==(Object other) {
    return other is TemplateTaskListProvider && other.templateId == templateId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, templateId.hashCode);

    return _SystemHash.finish(hash);
  }

  @override
  TemplateTaskDataTable runNotifierBuild(
    covariant TemplateTaskList notifier,
  ) {
    return notifier.build(
      templateId: templateId,
    );
  }
}

String _$runTaskFormDataHash() => r'298b708569ffc49b6b201c838063be7a135ea0e6';

/// See also [RunTaskFormData].
@ProviderFor(RunTaskFormData)
final runTaskFormDataProvider =
    AutoDisposeNotifierProvider<RunTaskFormData, RunTaskFormState>.internal(
  RunTaskFormData.new,
  name: r'runTaskFormDataProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$runTaskFormDataHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$RunTaskFormData = AutoDisposeNotifier<RunTaskFormState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member
