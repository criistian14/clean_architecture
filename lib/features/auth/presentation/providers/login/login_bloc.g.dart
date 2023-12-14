// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_bloc.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$LoginStateCWProxy {
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
  ///
  /// Usage
  /// ```dart
  /// LoginState(...).copyWith(id: 12, name: "My name")
  /// ````
  LoginState call({
    LoginStatus? status,
    Exception? error,
    String? emailSaved,
    String? passwordSaved,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfLoginState.copyWith(...)`.
class _$LoginStateCWProxyImpl implements _$LoginStateCWProxy {
  const _$LoginStateCWProxyImpl(this._value);

  final LoginState _value;

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored.
  ///
  /// Usage
  /// ```dart
  /// LoginState(...).copyWith(id: 12, name: "My name")
  /// ````
  LoginState call({
    Object? status = const $CopyWithPlaceholder(),
    Object? error = const $CopyWithPlaceholder(),
    Object? emailSaved = const $CopyWithPlaceholder(),
    Object? passwordSaved = const $CopyWithPlaceholder(),
  }) {
    return LoginState(
      status: status == const $CopyWithPlaceholder() || status == null
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as LoginStatus,
      error: error == const $CopyWithPlaceholder()
          ? _value.error
          // ignore: cast_nullable_to_non_nullable
          : error as Exception?,
      emailSaved: emailSaved == const $CopyWithPlaceholder()
          ? _value.emailSaved
          // ignore: cast_nullable_to_non_nullable
          : emailSaved as String?,
      passwordSaved: passwordSaved == const $CopyWithPlaceholder()
          ? _value.passwordSaved
          // ignore: cast_nullable_to_non_nullable
          : passwordSaved as String?,
    );
  }
}

extension $LoginStateCopyWith on LoginState {
  /// Returns a callable class that can be used as follows: `instanceOfLoginState.copyWith(...)`.
  // ignore: library_private_types_in_public_api
  _$LoginStateCWProxy get copyWith => _$LoginStateCWProxyImpl(this);

  /// Copies the object with the specific fields set to `null`. If you pass `false` as a parameter, nothing will be done and it will be ignored. Don't do it. Prefer `copyWith(field: null)`.
  ///
  /// Usage
  /// ```dart
  /// LoginState(...).copyWithNull(firstField: true, secondField: true)
  /// ````
  LoginState copyWithNull({
    bool error = false,
    bool emailSaved = false,
    bool passwordSaved = false,
  }) {
    return LoginState(
      status: status,
      error: error == true ? null : this.error,
      emailSaved: emailSaved == true ? null : this.emailSaved,
      passwordSaved: passwordSaved == true ? null : this.passwordSaved,
    );
  }
}
