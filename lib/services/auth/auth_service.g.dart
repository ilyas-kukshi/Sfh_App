// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$signInHash() => r'a689f91e4cdcd4e5038abe7b442f165b3bce2c29';

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

/// See also [signIn].
@ProviderFor(signIn)
const signInProvider = SignInFamily();

/// See also [signIn].
class SignInFamily extends Family<AsyncValue<bool>> {
  /// See also [signIn].
  const SignInFamily();

  /// See also [signIn].
  SignInProvider call(
    AuthModel auth,
  ) {
    return SignInProvider(
      auth,
    );
  }

  @override
  SignInProvider getProviderOverride(
    covariant SignInProvider provider,
  ) {
    return call(
      provider.auth,
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
  String? get name => r'signInProvider';
}

/// See also [signIn].
class SignInProvider extends AutoDisposeFutureProvider<bool> {
  /// See also [signIn].
  SignInProvider(
    AuthModel auth,
  ) : this._internal(
          (ref) => signIn(
            ref as SignInRef,
            auth,
          ),
          from: signInProvider,
          name: r'signInProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$signInHash,
          dependencies: SignInFamily._dependencies,
          allTransitiveDependencies: SignInFamily._allTransitiveDependencies,
          auth: auth,
        );

  SignInProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.auth,
  }) : super.internal();

  final AuthModel auth;

  @override
  Override overrideWith(
    FutureOr<bool> Function(SignInRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SignInProvider._internal(
        (ref) => create(ref as SignInRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        auth: auth,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _SignInProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SignInProvider && other.auth == auth;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, auth.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SignInRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `auth` of this provider.
  AuthModel get auth;
}

class _SignInProviderElement extends AutoDisposeFutureProviderElement<bool>
    with SignInRef {
  _SignInProviderElement(super.provider);

  @override
  AuthModel get auth => (origin as SignInProvider).auth;
}

String _$getUserByTokenHash() => r'a7994ffd38e47b8276d0c9d5d85fc8a0c9a1dcdd';

/// See also [getUserByToken].
@ProviderFor(getUserByToken)
const getUserByTokenProvider = GetUserByTokenFamily();

/// See also [getUserByToken].
class GetUserByTokenFamily extends Family<AsyncValue<UserModel?>> {
  /// See also [getUserByToken].
  const GetUserByTokenFamily();

  /// See also [getUserByToken].
  GetUserByTokenProvider call(
    String token,
  ) {
    return GetUserByTokenProvider(
      token,
    );
  }

  @override
  GetUserByTokenProvider getProviderOverride(
    covariant GetUserByTokenProvider provider,
  ) {
    return call(
      provider.token,
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
  String? get name => r'getUserByTokenProvider';
}

/// See also [getUserByToken].
class GetUserByTokenProvider extends AutoDisposeFutureProvider<UserModel?> {
  /// See also [getUserByToken].
  GetUserByTokenProvider(
    String token,
  ) : this._internal(
          (ref) => getUserByToken(
            ref as GetUserByTokenRef,
            token,
          ),
          from: getUserByTokenProvider,
          name: r'getUserByTokenProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getUserByTokenHash,
          dependencies: GetUserByTokenFamily._dependencies,
          allTransitiveDependencies:
              GetUserByTokenFamily._allTransitiveDependencies,
          token: token,
        );

  GetUserByTokenProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.token,
  }) : super.internal();

  final String token;

  @override
  Override overrideWith(
    FutureOr<UserModel?> Function(GetUserByTokenRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetUserByTokenProvider._internal(
        (ref) => create(ref as GetUserByTokenRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        token: token,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<UserModel?> createElement() {
    return _GetUserByTokenProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetUserByTokenProvider && other.token == token;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, token.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetUserByTokenRef on AutoDisposeFutureProviderRef<UserModel?> {
  /// The parameter `token` of this provider.
  String get token;
}

class _GetUserByTokenProviderElement
    extends AutoDisposeFutureProviderElement<UserModel?>
    with GetUserByTokenRef {
  _GetUserByTokenProviderElement(super.provider);

  @override
  String get token => (origin as GetUserByTokenProvider).token;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
