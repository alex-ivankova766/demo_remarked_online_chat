class Message {
  Message(
      {required this.createdAt,
      required this.sender,
      required this.recipient,
      required this.point,
      required this.direction,
      required this.channel,
      required this.content,
      required this.uuid,
      this.id});
  final DateTime createdAt;
  final String sender;
  final String recipient;
  final int point;
  final MessageDirection direction;
  final MessageChannel channel;
  final String content;
  final String uuid;
  int? id;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
      createdAt: DateTime.now(),
      sender: json['from'] ?? '',
      recipient: json['to'] ?? '',
      point: json['point'] ?? '',
      direction: MessageDirectionExtension.fromJson(json['direction']),
      channel: MessageChannelExtension.fromJson(json['channel']),
      content: json['text'] ?? '',
      id: json['id'],
      uuid: json['message_id']);

  static Map<String, dynamic> toMap(Message message) => {
        "createdAt": message.createdAt,
        "sender": message.sender,
        "recipient": message.recipient,
        "point": message.point,
        "direction": message.direction.toJson(),
        "channel": message.channel.toJson(),
        "content": message.content,
        "message_id": message.uuid
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Message &&
          runtimeType == other.runtimeType &&
          uuid == other.uuid;

  @override
  int get hashCode => uuid.hashCode;
}

///!!!на сервере in - от поль-ля к рекмаркед, на клиенте наоборот!!!
enum MessageDirection { input, output }

extension MessageDirectionExtension on MessageDirection {
  String toJson() {
    switch (this) {
      case MessageDirection.output:
        return 'in';
      case MessageDirection.input:
        return 'out';
      default:
        return 'Unknown message direction';
    }
  }

  static MessageDirection fromJson(String value) {
    switch (value) {
      case 'in':
        return MessageDirection.output;
      case 'out':
        return MessageDirection.input;
      default:
        throw ArgumentError('Unknown message direction: $value');
    }
  }
}

enum MessageChannel { whatsapp, telegram, onlinechat }

extension MessageChannelExtension on MessageChannel {
  String toJson() {
    switch (this) {
      case MessageChannel.whatsapp:
        return 'whatsapp';
      case MessageChannel.onlinechat:
        return 'onlinechat';
      case MessageChannel.telegram:
        return 'telegram';
      default:
        return 'Unknown message channel';
    }
  }

  static MessageChannel fromJson(String value) {
    switch (value) {
      case 'whatsapp':
        return MessageChannel.whatsapp;
      case 'onlinechat':
        return MessageChannel.onlinechat;
      case 'telegram':
        return MessageChannel.telegram;
      default:
        throw ArgumentError('Unknown message channel: $value');
    }
  }
}
