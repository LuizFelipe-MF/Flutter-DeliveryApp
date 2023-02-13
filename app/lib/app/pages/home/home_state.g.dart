// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_state.dart';

// **************************************************************************
// MatchExtensionGenerator
// **************************************************************************

extension HomeStateStatusMatch on HomeStateStatus {
  T match<T>(
      {required T Function() initial,
      required T Function() loading,
      required T Function() loaded,
      required T Function() error}) {
    final v = this;
    if (v == HomeStateStatus.initial) {
      return initial();
    }

    if (v == HomeStateStatus.loading) {
      return loading();
    }

    if (v == HomeStateStatus.loaded) {
      return loaded();
    }

    if (v == HomeStateStatus.error) {
      return error();
    }

    throw Exception('HomeStateStatus.match failed, found no match for: $this');
  }

  T matchAny<T>(
      {required T Function() any,
      T Function()? initial,
      T Function()? loading,
      T Function()? loaded,
      T Function()? error}) {
    final v = this;
    if (v == HomeStateStatus.initial && initial != null) {
      return initial();
    }

    if (v == HomeStateStatus.loading && loading != null) {
      return loading();
    }

    if (v == HomeStateStatus.loaded && loaded != null) {
      return loaded();
    }

    if (v == HomeStateStatus.error && error != null) {
      return error();
    }

    return any();
  }
}
