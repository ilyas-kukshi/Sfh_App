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

String _$getUserByNumberHash() => r'5fcc3a2126db048835e80a8eaa1ba653c2c8fce6';

/// See also [getUserByNumber].
@ProviderFor(getUserByNumber)
const getUserByNumberProvider = GetUserByNumberFamily();

/// See also [getUserByNumber].
class GetUserByNumberFamily extends Family<AsyncValue<UserModel?>> {
  /// See also [getUserByNumber].
  const GetUserByNumberFamily();

  /// See also [getUserByNumber].
  GetUserByNumberProvider call(
    String phoneNumber,
  ) {
    return GetUserByNumberProvider(
      phoneNumber,
    );
  }

  @override
  GetUserByNumberProvider getProviderOverride(
    covariant GetUserByNumberProvider provider,
  ) {
    return call(
      provider.phoneNumber,
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
  String? get name => r'getUserByNumberProvider';
}

/// See also [getUserByNumber].
class GetUserByNumberProvider extends AutoDisposeFutureProvider<UserModel?> {
  /// See also [getUserByNumber].
  GetUserByNumberProvider(
    String phoneNumber,
  ) : this._internal(
          (ref) => getUserByNumber(
            ref as GetUserByNumberRef,
            phoneNumber,
          ),
          from: getUserByNumberProvider,
          name: r'getUserByNumberProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getUserByNumberHash,
          dependencies: GetUserByNumberFamily._dependencies,
          allTransitiveDependencies:
              GetUserByNumberFamily._allTransitiveDependencies,
          phoneNumber: phoneNumber,
        );

  GetUserByNumberProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.phoneNumber,
  }) : super.internal();

  final String phoneNumber;

  @override
  Override overrideWith(
    FutureOr<UserModel?> Function(GetUserByNumberRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetUserByNumberProvider._internal(
        (ref) => create(ref as GetUserByNumberRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        phoneNumber: phoneNumber,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<UserModel?> createElement() {
    return _GetUserByNumberProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetUserByNumberProvider && other.phoneNumber == phoneNumber;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, phoneNumber.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetUserByNumberRef on AutoDisposeFutureProviderRef<UserModel?> {
  /// The parameter `phoneNumber` of this provider.
  String get phoneNumber;
}

class _GetUserByNumberProviderElement
    extends AutoDisposeFutureProviderElement<UserModel?>
    with GetUserByNumberRef {
  _GetUserByNumberProviderElement(super.provider);

  @override
  String get phoneNumber => (origin as GetUserByNumberProvider).phoneNumber;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
