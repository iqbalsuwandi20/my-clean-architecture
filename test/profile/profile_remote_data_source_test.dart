import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:my_clean_architecture/core/error/exception.dart';
import 'package:my_clean_architecture/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:my_clean_architecture/features/profile/data/models/profile_model.dart';

@GenerateNiceMocks(
    [MockSpec<ProfileRemoteDataSource>(), MockSpec<http.Client>()])
import 'profile_remote_data_source_test.mocks.dart';

void main() {
  var profileRemoteDataSource = MockProfileRemoteDataSource();
  MockClient mockClient = MockClient();
  var profileRemoteDataSourceImplementation =
      ProfileRemoteDataSourceImplementation(client: mockClient);

  const int userId = 1;
  const int page = 1;
  Uri uriGetAllUser = Uri.parse('https://reqres.in/api/users?page=$page');
  Uri uriGetUser = Uri.parse('https://reqres.in/api/users/$userId');

  Map<String, dynamic> fakeDataJson = {
    "id": userId,
    "email": "user1@gmail.com",
    "first_name": "user",
    "last_name": "$userId",
    "avatar": "https://image.com/$userId",
  };

  ProfileModel fakeProfileModel = ProfileModel.fromJson(fakeDataJson);

  group('Profile Remote Data Source', () {
    group('getUser()', () {
      test('SUCCESS', () async {
        when(profileRemoteDataSource.getUser(userId)).thenAnswer(
          (_) async => fakeProfileModel,
        );

        try {
          var response = await profileRemoteDataSource.getUser(userId);
          expect(response, fakeProfileModel);
        } catch (e) {
          fail('NOT POSSIBLE - getUser() Success');
        }
      });

      test('FAILED', () async {
        when(profileRemoteDataSource.getUser(userId)).thenThrow(Exception());

        try {
          fail('NOT POSSIBLE - getUser() Failed');
        } catch (e) {
          expect(e, isException);
        }
      });
    });

    group('getAllUser()', () {
      test('SUCCESS', () async {
        when(profileRemoteDataSource.getAllUser(page)).thenAnswer(
          (_) async => [fakeProfileModel],
        );

        try {
          var response = await profileRemoteDataSource.getAllUser(page);
          expect(response, [fakeProfileModel]);
        } catch (e) {
          fail('NOT POSSIBLE - getAllUser() Success');
        }
      });

      test('FAILED', () async {
        when(profileRemoteDataSource.getAllUser(page)).thenThrow(Exception());

        try {
          fail('NOT POSSIBLE - getAllUser() Failed');
        } catch (e) {
          expect(e, isException);
        }
      });
    });
  });

  group('Profile Remote Data Source Implementation', () {
    group('getUser()', () {
      group('SUCCESS 200', () async {
        when(mockClient.get(uriGetUser)).thenAnswer((_) async => http.Response(
              jsonEncode({
                "data": fakeDataJson,
              }),
              200,
            ));

        try {
          var response =
              await profileRemoteDataSourceImplementation.getUser(userId);
          expect(response, fakeProfileModel);
        } catch (e) {
          fail('NOT POSSIBLE - getUser() Success Implementation (200)');
        }
      });

      group('FAILED 404', () async {
        when(mockClient.get(uriGetUser)).thenAnswer((_) async => http.Response(
              jsonEncode({}),
              404,
            ));

        try {
          await profileRemoteDataSourceImplementation.getUser(userId);
          fail('NOT POSSIBLE - getUser() Success Failed (404)');
        } on EmptyException catch (e) {
          expect(e, isException);
        } catch (e) {
          fail('NOT POSSIBLE');
        }
      });

      group('FAILED 500', () async {
        when(mockClient.get(uriGetUser)).thenAnswer((_) async => http.Response(
              jsonEncode({}),
              500,
            ));

        try {
          await profileRemoteDataSourceImplementation.getUser(userId);
          fail('NOT POSSIBLE - getUser() Success Failed (500)');
        } on EmptyException catch (e) {
          fail(e.toString());
        } catch (e) {
          expect(e, isException);
        }
      });
    });

    group('getAllUser()', () {
      group('SUCCESS 200', () async {
        when(mockClient.get(uriGetAllUser))
            .thenAnswer((_) async => http.Response(
                  jsonEncode({
                    "data": [fakeDataJson],
                  }),
                  200,
                ));

        try {
          var response =
              await profileRemoteDataSourceImplementation.getAllUser(page);
          expect(response, [fakeProfileModel]);
        } on EmptyException catch (e) {
          fail(e.toString());
        } on StatusCodeException catch (e) {
          fail(e.toString());
        } catch (e) {
          fail('NOT POSSIBLE - getUser() Success Implementation (200)');
        }
      });

      group('FAILED EMPTY', () async {
        when(mockClient.get(uriGetAllUser))
            .thenAnswer((_) async => http.Response(
                  jsonEncode({
                    'data': [],
                  }),
                  200,
                ));

        try {
          await profileRemoteDataSourceImplementation.getAllUser(page);
          fail('NOT POSSIBLE - getUser() Success Failed (EMPTY)');
        } on EmptyException catch (e) {
          expect(e, isException);
        } on StatusCodeException catch (e) {
          fail(e.toString());
        } catch (e) {
          fail('NOT POSSIBLE');
        }
      });

      group('FAILED 404', () async {
        when(mockClient.get(uriGetAllUser))
            .thenAnswer((_) async => http.Response(
                  jsonEncode({}),
                  404,
                ));

        try {
          await profileRemoteDataSourceImplementation.getAllUser(page);
          fail('NOT POSSIBLE - getUser() Success Failed 404');
        } on EmptyException catch (e) {
          fail(e.toString());
        } on StatusCodeException catch (e) {
          expect(e, isException);
        } catch (e) {
          fail('NOT POSSIBLE');
        }
      });

      group('FAILED 500', () async {
        when(mockClient.get(uriGetAllUser))
            .thenAnswer((_) async => http.Response(
                  jsonEncode({}),
                  500,
                ));

        try {
          await profileRemoteDataSourceImplementation.getAllUser(page);
          fail('NOT POSSIBLE - getUser() Success Failed (500)');
        } on EmptyException catch (e) {
          fail(e.toString());
        } on StatusCodeException catch (e) {
          fail(e.toString());
        } catch (e) {
          expect(e, isException);
        }
      });
    });
  });
}
