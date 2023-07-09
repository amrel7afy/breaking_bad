import 'package:breaking_bad/constants/strings.dart';
import 'package:dio/dio.dart';

class CharacterWebServices {
  late Dio dio;

  CharacterWebServices() {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: 10 * 1000,
      receiveTimeout: 10 * 1000,
      receiveDataWhenStatusError: true,
    );
    dio = Dio(baseOptions);
  }

  Future<List<dynamic>> getAllCharacters() async {
    try {
      Response response = await dio.get('characters');

      return response.data;
    } catch (error) {
      print(error);
      return [];
    }
  }

  Future<List<dynamic>> getAllQuotes(String name) async {
    try {
      Response response =
          await dio.get('quote', queryParameters: {'author': name});

      return response.data;
    } catch (error) {
      print('web services error: ' + error.toString());
      return [];
    }
  }



  
  
  
  
  
  
 Future <List<dynamic>> getBetterCallSaulCharacters()async {
    try{
      Response response=await dio.get('characters',queryParameters: {
        'category':'Better Call Saul'
      });

      return response.data;

    }catch(error){
      print('getBetterCallSaulCharacters Error'+error.toString());
      return [];
    }
    
}

}
