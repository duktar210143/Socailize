// Mocks generated by Mockito 5.4.4 from annotations
// in discussion_forum/test/unit_test/mock_test/login_mock_unit_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i8;
import 'dart:io' as _i11;

import 'package:dartz/dartz.dart' as _i4;
import 'package:discussion_forum/core/failure/failure.dart' as _i9;
import 'package:discussion_forum/core/shared_pref/user_shared_prefs.dart'
    as _i3;
import 'package:discussion_forum/features/authentication/data/data_source/auth_remote_data_source.dart'
    as _i14;
import 'package:discussion_forum/features/authentication/domain/entity/user_entity.dart'
    as _i10;
import 'package:discussion_forum/features/authentication/domain/repository/auth_repository.dart'
    as _i2;
import 'package:discussion_forum/features/authentication/domain/use_case/auth_usecase.dart'
    as _i7;
import 'package:discussion_forum/features/authentication/domain/use_case/login_usecase.dart'
    as _i13;
import 'package:flutter/foundation.dart' as _i6;
import 'package:flutter/src/widgets/framework.dart' as _i5;
import 'package:flutter/src/widgets/notification_listener.dart' as _i12;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeIAuthRepository_0 extends _i1.SmartFake
    implements _i2.IAuthRepository {
  _FakeIAuthRepository_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeUserSharedPrefs_1 extends _i1.SmartFake
    implements _i3.UserSharedPrefs {
  _FakeUserSharedPrefs_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeEither_2<L, R> extends _i1.SmartFake implements _i4.Either<L, R> {
  _FakeEither_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeWidget_3 extends _i1.SmartFake implements _i5.Widget {
  _FakeWidget_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );

  @override
  String toString({_i6.DiagnosticLevel? minLevel = _i6.DiagnosticLevel.info}) =>
      super.toString();
}

class _FakeInheritedWidget_4 extends _i1.SmartFake
    implements _i5.InheritedWidget {
  _FakeInheritedWidget_4(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );

  @override
  String toString({_i6.DiagnosticLevel? minLevel = _i6.DiagnosticLevel.info}) =>
      super.toString();
}

class _FakeDiagnosticsNode_5 extends _i1.SmartFake
    implements _i6.DiagnosticsNode {
  _FakeDiagnosticsNode_5(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );

  @override
  String toString({
    _i6.TextTreeConfiguration? parentConfiguration,
    _i6.DiagnosticLevel? minLevel = _i6.DiagnosticLevel.info,
  }) =>
      super.toString();
}

/// A class which mocks [AuthUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockAuthUseCase extends _i1.Mock implements _i7.AuthUseCase {
  @override
  _i2.IAuthRepository get authRepository => (super.noSuchMethod(
        Invocation.getter(#authRepository),
        returnValue: _FakeIAuthRepository_0(
          this,
          Invocation.getter(#authRepository),
        ),
        returnValueForMissingStub: _FakeIAuthRepository_0(
          this,
          Invocation.getter(#authRepository),
        ),
      ) as _i2.IAuthRepository);

  @override
  _i3.UserSharedPrefs get userSharedPrefs => (super.noSuchMethod(
        Invocation.getter(#userSharedPrefs),
        returnValue: _FakeUserSharedPrefs_1(
          this,
          Invocation.getter(#userSharedPrefs),
        ),
        returnValueForMissingStub: _FakeUserSharedPrefs_1(
          this,
          Invocation.getter(#userSharedPrefs),
        ),
      ) as _i3.UserSharedPrefs);

  @override
  _i8.Future<_i4.Either<_i9.Failure, bool>> signUpUser(_i10.AuthEntity? user) =>
      (super.noSuchMethod(
        Invocation.method(
          #signUpUser,
          [user],
        ),
        returnValue: _i8.Future<_i4.Either<_i9.Failure, bool>>.value(
            _FakeEither_2<_i9.Failure, bool>(
          this,
          Invocation.method(
            #signUpUser,
            [user],
          ),
        )),
        returnValueForMissingStub:
            _i8.Future<_i4.Either<_i9.Failure, bool>>.value(
                _FakeEither_2<_i9.Failure, bool>(
          this,
          Invocation.method(
            #signUpUser,
            [user],
          ),
        )),
      ) as _i8.Future<_i4.Either<_i9.Failure, bool>>);

  @override
  _i8.Future<_i4.Either<_i9.Failure, _i10.AuthEntity>> uploadProfile(
          _i11.File? image) =>
      (super.noSuchMethod(
        Invocation.method(
          #uploadProfile,
          [image],
        ),
        returnValue: _i8.Future<_i4.Either<_i9.Failure, _i10.AuthEntity>>.value(
            _FakeEither_2<_i9.Failure, _i10.AuthEntity>(
          this,
          Invocation.method(
            #uploadProfile,
            [image],
          ),
        )),
        returnValueForMissingStub:
            _i8.Future<_i4.Either<_i9.Failure, _i10.AuthEntity>>.value(
                _FakeEither_2<_i9.Failure, _i10.AuthEntity>(
          this,
          Invocation.method(
            #uploadProfile,
            [image],
          ),
        )),
      ) as _i8.Future<_i4.Either<_i9.Failure, _i10.AuthEntity>>);

  @override
  _i8.Future<_i4.Either<bool, _i10.AuthEntity>> getUserData() =>
      (super.noSuchMethod(
        Invocation.method(
          #getUserData,
          [],
        ),
        returnValue: _i8.Future<_i4.Either<bool, _i10.AuthEntity>>.value(
            _FakeEither_2<bool, _i10.AuthEntity>(
          this,
          Invocation.method(
            #getUserData,
            [],
          ),
        )),
        returnValueForMissingStub:
            _i8.Future<_i4.Either<bool, _i10.AuthEntity>>.value(
                _FakeEither_2<bool, _i10.AuthEntity>(
          this,
          Invocation.method(
            #getUserData,
            [],
          ),
        )),
      ) as _i8.Future<_i4.Either<bool, _i10.AuthEntity>>);
}

/// A class which mocks [BuildContext].
///
/// See the documentation for Mockito's code generation for more information.
class MockBuildContext extends _i1.Mock implements _i5.BuildContext {
  @override
  _i5.Widget get widget => (super.noSuchMethod(
        Invocation.getter(#widget),
        returnValue: _FakeWidget_3(
          this,
          Invocation.getter(#widget),
        ),
        returnValueForMissingStub: _FakeWidget_3(
          this,
          Invocation.getter(#widget),
        ),
      ) as _i5.Widget);

  @override
  bool get mounted => (super.noSuchMethod(
        Invocation.getter(#mounted),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);

  @override
  bool get debugDoingBuild => (super.noSuchMethod(
        Invocation.getter(#debugDoingBuild),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);

  @override
  _i5.InheritedWidget dependOnInheritedElement(
    _i5.InheritedElement? ancestor, {
    Object? aspect,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #dependOnInheritedElement,
          [ancestor],
          {#aspect: aspect},
        ),
        returnValue: _FakeInheritedWidget_4(
          this,
          Invocation.method(
            #dependOnInheritedElement,
            [ancestor],
            {#aspect: aspect},
          ),
        ),
        returnValueForMissingStub: _FakeInheritedWidget_4(
          this,
          Invocation.method(
            #dependOnInheritedElement,
            [ancestor],
            {#aspect: aspect},
          ),
        ),
      ) as _i5.InheritedWidget);

  @override
  void visitAncestorElements(_i5.ConditionalElementVisitor? visitor) =>
      super.noSuchMethod(
        Invocation.method(
          #visitAncestorElements,
          [visitor],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void visitChildElements(_i5.ElementVisitor? visitor) => super.noSuchMethod(
        Invocation.method(
          #visitChildElements,
          [visitor],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void dispatchNotification(_i12.Notification? notification) =>
      super.noSuchMethod(
        Invocation.method(
          #dispatchNotification,
          [notification],
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i6.DiagnosticsNode describeElement(
    String? name, {
    _i6.DiagnosticsTreeStyle? style = _i6.DiagnosticsTreeStyle.errorProperty,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #describeElement,
          [name],
          {#style: style},
        ),
        returnValue: _FakeDiagnosticsNode_5(
          this,
          Invocation.method(
            #describeElement,
            [name],
            {#style: style},
          ),
        ),
        returnValueForMissingStub: _FakeDiagnosticsNode_5(
          this,
          Invocation.method(
            #describeElement,
            [name],
            {#style: style},
          ),
        ),
      ) as _i6.DiagnosticsNode);

  @override
  _i6.DiagnosticsNode describeWidget(
    String? name, {
    _i6.DiagnosticsTreeStyle? style = _i6.DiagnosticsTreeStyle.errorProperty,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #describeWidget,
          [name],
          {#style: style},
        ),
        returnValue: _FakeDiagnosticsNode_5(
          this,
          Invocation.method(
            #describeWidget,
            [name],
            {#style: style},
          ),
        ),
        returnValueForMissingStub: _FakeDiagnosticsNode_5(
          this,
          Invocation.method(
            #describeWidget,
            [name],
            {#style: style},
          ),
        ),
      ) as _i6.DiagnosticsNode);

  @override
  List<_i6.DiagnosticsNode> describeMissingAncestor(
          {required Type? expectedAncestorType}) =>
      (super.noSuchMethod(
        Invocation.method(
          #describeMissingAncestor,
          [],
          {#expectedAncestorType: expectedAncestorType},
        ),
        returnValue: <_i6.DiagnosticsNode>[],
        returnValueForMissingStub: <_i6.DiagnosticsNode>[],
      ) as List<_i6.DiagnosticsNode>);

  @override
  _i6.DiagnosticsNode describeOwnershipChain(String? name) =>
      (super.noSuchMethod(
        Invocation.method(
          #describeOwnershipChain,
          [name],
        ),
        returnValue: _FakeDiagnosticsNode_5(
          this,
          Invocation.method(
            #describeOwnershipChain,
            [name],
          ),
        ),
        returnValueForMissingStub: _FakeDiagnosticsNode_5(
          this,
          Invocation.method(
            #describeOwnershipChain,
            [name],
          ),
        ),
      ) as _i6.DiagnosticsNode);
}

/// A class which mocks [LoginUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockLoginUseCase extends _i1.Mock implements _i13.LoginUseCase {
  @override
  _i2.IAuthRepository get authRepository => (super.noSuchMethod(
        Invocation.getter(#authRepository),
        returnValue: _FakeIAuthRepository_0(
          this,
          Invocation.getter(#authRepository),
        ),
        returnValueForMissingStub: _FakeIAuthRepository_0(
          this,
          Invocation.getter(#authRepository),
        ),
      ) as _i2.IAuthRepository);

  @override
  _i3.UserSharedPrefs get userSharedPrefs => (super.noSuchMethod(
        Invocation.getter(#userSharedPrefs),
        returnValue: _FakeUserSharedPrefs_1(
          this,
          Invocation.getter(#userSharedPrefs),
        ),
        returnValueForMissingStub: _FakeUserSharedPrefs_1(
          this,
          Invocation.getter(#userSharedPrefs),
        ),
      ) as _i3.UserSharedPrefs);

  @override
  _i8.Future<_i4.Either<_i9.Failure, _i14.AuthData>> login(
    String? userName,
    String? password,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #login,
          [
            userName,
            password,
          ],
        ),
        returnValue: _i8.Future<_i4.Either<_i9.Failure, _i14.AuthData>>.value(
            _FakeEither_2<_i9.Failure, _i14.AuthData>(
          this,
          Invocation.method(
            #login,
            [
              userName,
              password,
            ],
          ),
        )),
        returnValueForMissingStub:
            _i8.Future<_i4.Either<_i9.Failure, _i14.AuthData>>.value(
                _FakeEither_2<_i9.Failure, _i14.AuthData>(
          this,
          Invocation.method(
            #login,
            [
              userName,
              password,
            ],
          ),
        )),
      ) as _i8.Future<_i4.Either<_i9.Failure, _i14.AuthData>>);
}
