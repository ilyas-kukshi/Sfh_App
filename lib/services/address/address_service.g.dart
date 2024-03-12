// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getAddressesHash() => r'456b95b748c4f1360f72d6f7dbbcabfecd00e814';

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

/// See also [getAddresses].
@ProviderFor(getAddresses)
const getAddressesProvider = GetAddressesFamily();

/// See also [getAddresses].
class GetAddressesFamily extends Family<AsyncValue<List<AddressModel>>> {
  /// See also [getAddresses].
  const GetAddressesFamily();

  /// See also [getAddresses].
  GetAddressesProvider call(
    String token,
  ) {
    return GetAddressesProvider(
      token,
    );
  }

  @override
  GetAddressesProvider getProviderOverride(
    covariant GetAddressesProvider provider,
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
  String? get name => r'getAddressesProvider';
}

/// See also [getAddresses].
class GetAddressesProvider
    extends AutoDisposeFutureProvider<List<AddressModel>> {
  /// See also [getAddresses].
  GetAddressesProvider(
    String token,
  ) : this._internal(
          (ref) => getAddresses(
            ref as GetAddressesRef,
            token,
          ),
          from: getAddressesProvider,
          name: r'getAddressesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getAddressesHash,
          dependencies: GetAddressesFamily._dependencies,
          allTransitiveDependencies:
              GetAddressesFamily._allTransitiveDependencies,
          token: token,
        );

  GetAddressesProvider._internal(
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
    FutureOr<List<AddressModel>> Function(GetAddressesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetAddressesProvider._internal(
        (ref) => create(ref as GetAddressesRef),
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
  AutoDisposeFutureProviderElement<List<AddressModel>> createElement() {
    return _GetAddressesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetAddressesProvider && other.token == token;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, token.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetAddressesRef on AutoDisposeFutureProviderRef<List<AddressModel>> {
  /// The parameter `token` of this provider.
  String get token;
}

class _GetAddressesProviderElement
    extends AutoDisposeFutureProviderElement<List<AddressModel>>
    with GetAddressesRef {
  _GetAddressesProviderElement(super.provider);

  @override
  String get token => (origin as GetAddressesProvider).token;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
