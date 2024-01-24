import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:remarked_online_chat/models/message.dart';

class ApiClient {
  ApiClient({
    http.Client? httpClient,
  }) : this._(
          baseUrl: 'https://app.remarked.ru/api/v1/api',
          httpClient: httpClient,
        );

  ApiClient._({
    required String baseUrl,
    http.Client? httpClient,
  })  : _baseUrl = baseUrl,
        _httpClient = httpClient ?? http.Client();
  final String _baseUrl;
  final http.Client _httpClient;

  Future<List<Message>> fetchMessages(
      String token, String phone, int point) async {
    final uri = Uri.parse(_baseUrl);
    try {
      Response response = await _httpClient.post(uri,
          body: jsonEncode({
            "jsonrpc": "2.0",
            "id": "1",
            "method": "GuestsChatsApi.GetGuestChats",
            "params": {
              "token": token,
              "point": point,
              "phone": phone,
              "limit": 50
            }
          }));
      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = json.decode(response.body);
        List<Message> fetchedMessages =
            (responseBody['result']['data']['chats'] as List<dynamic>?)
                    ?.map((chat) => Message.fromJson(chat))
                    .toList() ??
                [];
        return fetchedMessages;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  Future<bool> sendMessage(
      Message message, String token, String phone, int point) async {
    final uri = Uri.parse(_baseUrl);
    String uuid = message.uuid;
    int date = message.createdAt.millisecondsSinceEpoch ~/ 1000;
    try {
      Response response = await _httpClient.post(uri,
          body: jsonEncode({
            "jsonrpc": "2.0",
            "id": "1",
            "method": "GuestsChatsApi.SaveChatMessage",
            "params": {
              "token": token,
              "point": point,
              "local_phone": "1",
              "remote_phone": phone,
              "message_id": uuid,
              "date": date,
              "message": message.content,
              "channel": "onlinechat",
              "message_type": "chat",
              "direction": 0,
            }
          }));
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
