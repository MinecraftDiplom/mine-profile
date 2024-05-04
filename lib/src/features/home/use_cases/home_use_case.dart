import 'package:dio/dio.dart';
import 'package:mine_profile/src/features/auth/models/user_data_entity.dart';

class HomeUseCase {
  final dio = Dio();

  Future<UserData> call(String username) async {
    try {
      final response =
          await dio.get('http://kissota.ru:9000/auth/data/$username');
      var data = UserData.fromJson(response.data);
      return data;
    } on ArgumentError catch (error) {
      throw Exception(error);
    } catch (error) {
      throw Exception(error);
    }
  }
}
