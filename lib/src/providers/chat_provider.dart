import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../api/environment.dart';
import '../models/chat.dart';
import '../models/response_api.dart';
import '../models/user.dart';

class ChatsProvider extends GetConnect {
  String url = Environment.API_CHAT + 'api/chats';

  User user = User.fromJson(GetStorage().read('user') ?? {});

  Future<List<Chat>> getChats()  async {
    Response response = await get(
        '$url/findByIdUser/${user.id}',
        headers: {
          'Content-Type': 'application/json',
          'Authorization' : user.sessionToken!
        }
    );

    if (response.statusCode == 401){
      Get.snackbar('Acceso denegado', 'No tiene permiso para realizar esta operacion');
      return [];
    }
    List<Chat> chats = Chat.fromJsonList(response.body);

    return chats;
  }

  Future<ResponseApi> create(Chat chat) async {
    Response response = await post(
        '$url/create',
        chat.toJson(),
        headers: {
          'Content-Type': 'application/json',
          'Authorization' : user.sessionToken!
        }
    ); // ESTA LINEA

    if(response.body == null){
      Get.snackbar('Error en la peticion', 'Error al Crear el chat');
      return ResponseApi();
    }

     return ResponseApi.fromJson(response.body);

  }

}