
import 'dart:convert';
import 'dart:io';

import 'package:chat_udemy/src/pages/messages/message_controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../api/environment.dart';

import '../models/message.dart';
import '../models/response_api.dart';
import '../models/user.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class MessagesProvider extends GetConnect {
  String url = Environment.API_CHAT + 'api/messages';

  User user = User.fromJson(GetStorage().read('user') ?? {});

  Future<List<Message>> getMessagesByChat(String idChat) async {
    Response response = await get(
        '$url/findByChat/$idChat',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': user.sessionToken!
        }
    );

    if (response.statusCode == 401) {
      Get.snackbar('Peticion denegada', 'tu usuario no tiene permitido obtener esta informacion');
      return [];
    }

    List<Message> messages = Message.fromJsonList(response.body);

    return messages;
  }

  Future<Stream> createWithImage(Message message, File image) async {

    Uri url = Uri.http(Environment.API_CHAT_OLD, '/api/messages/createWithImage');

    final request = http.MultipartRequest('POST', url);

    request.headers['Authorization'] = user.sessionToken ?? '';
    request.files.add(http.MultipartFile(
        'image',
        http.ByteStream(image.openRead().cast()),
        await image.length(),
        filename: basename(image.path)
    ));
    request.fields['message'] = json.encode(message);
    final response = await request.send();
    return response.stream.transform(utf8.decoder);
  }

  Future<Stream> createWithVideo(Message message, File video) async {

    Uri url = Uri.http(Environment.API_CHAT_OLD, '/api/messages/createWithVideo');

    final request = http.MultipartRequest('POST', url);

    request.headers['Authorization'] = user.sessionToken ?? '';
    request.files.add(http.MultipartFile(
        'video',
        http.ByteStream(video.openRead().cast()),
        await video.length(),
        filename: basename(video.path)
    ));
    request.fields['message'] = json.encode(message);
    final response = await request.send();
    return response.stream.transform(utf8.decoder);
  }

  Future<ResponseApi> create(Message message) async {
    Response response = await post(
        '$url/create',
        message.toJson(),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': user.sessionToken!
        }
    ); // ESTA LINEA

    if (response.body == null) {
      Get.snackbar('Error en la peticion', 'No se pudo actualizar el usuario');
      return ResponseApi();
    }

    ResponseApi responseApi = ResponseApi.fromJson(response.body);
    return responseApi;
  }

  Future<ResponseApi> updateToSeen(String idMessage) async {
    Response response = await put(
        '$url/updateToSeen',
        { 'id' : idMessage},
        headers: {
          'Content-Type': 'application/json',
          'Authorization': user.sessionToken!
        }
    ); // ESTA LINEA

    if (response.body == null) {
      Get.snackbar('Error en la peticion', 'No se pudo actualizar el usuario');
      return ResponseApi();
    }

    ResponseApi responseApi = ResponseApi.fromJson(response.body);
    return responseApi;
  }

  Future<ResponseApi> updateToReceived(String idMessage) async {
    Response response = await put(
        '$url/updateToReceived',
        { 'id' : idMessage},
        headers: {
          'Content-Type': 'application/json',
          'Authorization': user.sessionToken!
        }
    ); // ESTA LINEA

    if (response.body == null) {
      Get.snackbar('Error en la peticion', 'No se pudo actualizar el usuario');
      return ResponseApi();
    }

    ResponseApi responseApi = ResponseApi.fromJson(response.body);
    return responseApi;
  }

}