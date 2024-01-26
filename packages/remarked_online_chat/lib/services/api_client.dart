import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:remarked_online_chat/models/message.dart';
import 'package:remarked_online_chat/services/credentials.dart';

class ApiClient {
  ApiClient({
    http.Client? httpClient,
  }) : this._(
          baseUrl: 'https://app.remarked.ru/api/v1/api',
          httpClient: httpClient,
        );
  Credentials? _credentials;

  set credentials(Credentials? value) {
    _credentials = value;
  }

  ApiClient._({
    required String baseUrl,
    http.Client? httpClient,
  })  : _baseUrl = baseUrl,
        _httpClient = httpClient ?? http.Client();
  final String _baseUrl;
  final http.Client _httpClient;

  Future<List<Message>> fetchMessages({int limit = 50}) async {
    final uri = Uri.parse(_baseUrl);
    try {
      Response response = await _httpClient.post(uri,
          body: jsonEncode({
            "jsonrpc": "2.0",
            "id": "1",
            "method": "GuestsChatsApi.GetGuestChats",
            "params": {
              "token": _credentials?.token,
              "point": _credentials?.point,
              "phone": _credentials?.phone,
              "limit": limit
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

  Future<List<Message>> fetchNewMessages(int? lastMessageId) async {
    if (lastMessageId == null) {
      return [];
    }
    final uri = Uri.parse(_baseUrl);
    try {
      Response response = await _httpClient.post(uri,
          body: jsonEncode({
            "jsonrpc": "2.0",
            "id": "1",
            "method": "GuestsChatsApi.getLastMessages",
            "params": {
              "token": _credentials?.token,
              "point": _credentials?.point,
              "remote_phone": _credentials?.phone,
              "id": lastMessageId,
            }
          }));
      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = json.decode(response.body);
        int newMessageCount = responseBody['result']['data']['msg_count'];
        if (newMessageCount == 0) {
          return [];
        }
        List<Message> newFetchedMessages =
            await fetchMessages(limit: newMessageCount);
        return newFetchedMessages;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  Future<int?> sendMessage(Message message) async {
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
              "token": _credentials?.token,
              "point": _credentials?.point,
              "remote_phone": _credentials?.phone,
              "local_phone": "1",
              "message_id": uuid,
              "date": date,
              "message": message.content,
              "channel": "onlinechat",
              "message_type": "chat",
              "direction": 0,
            }
          }));
      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = json.decode(response.body);
        int newMessageId = responseBody['result']['data']['msg_id'];
        return newMessageId;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
