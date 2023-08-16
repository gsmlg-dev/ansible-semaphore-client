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
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member
