// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$signInStateHash() => r'0fdac377ebb85a07ca2b820dc9a07dee88b7e248';

/// See also [SignInState].
@ProviderFor(SignInState)
final signInStateProvider =
    AutoDisposeNotifierProvider<SignInState, bool>.internal(
  SignInState.new,
  name: r'signInStateProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$signInStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SignInState = AutoDisposeNotifier<bool>;
String _$signInFormHash() => r'206e34dd0a7e83b9ced25226fa85fc207d24c4e4';

/// See also [SignInForm].
@ProviderFor(SignInForm)
final signInFormProvider =
    AutoDisposeNotifierProvider<SignInForm, Login>.internal(
  SignInForm.new,
  name: r'signInFormProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$signInFormHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SignInForm = AutoDisposeNotifier<Login>;
String _$signInFormErrorHash() => r'9ba978fbe09e61a58d48ba94a70ae4752ed272f5';

/// See also [SignInFormError].
@ProviderFor(SignInFormError)
final signInFormErrorProvider =
    AutoDisposeNotifierProvider<SignInFormError, DioException?>.internal(
  SignInFormError.new,
  name: r'signInFormErrorProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$signInFormErrorHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SignInFormError = AutoDisposeNotifier<DioException?>;
String _$userTokenHash() => r'9aca14876a842af0f074e70fa46b4d231227e453';

/// See also [UserToken].
@ProviderFor(UserToken)
final userTokenProvider =
    AutoDisposeNotifierProvider<UserToken, String?>.internal(
  UserToken.new,
  name: r'userTokenProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$userTokenHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$UserToken = AutoDisposeNotifier<String?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member
