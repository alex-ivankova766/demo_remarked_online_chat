import 'dart:convert';

import 'package:remarked_online_chat/models/message.dart';

List<dynamic> json = jsonDecode('''[{
                    "date": "2022-06-22 13:48:36",
                    "direction": "out",
                    "from": "",
                    "to": "",
                    "point": 0,
                    "channel": "whatsapp",
                    "source_type": "",
                    "text": "Для вас забронировано посещение бани Усадьба, на 4-х человек. Дата: 20.06.2022. Время: 00:15-02:15. Адрес: г. Нур-Султан, проспект Тұран, 99. По любым вопросам: +7 (700) 716-66-66",
                    "media": "",
                    "content": "text"
                },
                {
                    "date": "2022-06-22 16:03:37",
                    "direction": "in",
                    "from": "",
                    "to": "",
                    "point": 0,
                    "channel": "whatsapp",
                    "source_type": "",
                    "text": "Спасибо!",
                    "media": "",
                    "content": "text"
                },
                {
                    "date": "2022-06-22 16:03:40",
                    "direction": "out",
                    "from": "",
                    "to": "",
                    "point": 0,
                    "channel": "whatsapp",
                    "source_type": "",
                    "text": "Оцените, пожалуйста, от 1 до 5 качество обслуживания",
                    "media": "",
                    "content": "text"
                },
                {
                    "date": "2022-06-22 17:00:23",
                    "direction": "in",
                    "from": "",
                    "to": "",
                    "point": 0,
                    "channel": "whatsapp",
                    "source_type": "",
                    "text": "5",
                    "media": "",
                    "content": "text"
                },
                {
                    "date": "2022-06-22 17:00:26",
                    "direction": "out",
                    "from": "",
                    "to": "",
                    "point": 0,
                    "channel": "whatsapp",
                    "source_type": "",
                    "text": "Большое спасибо за Вашую высокую оценку! Будем рады, если в поделитесь своим отзывом с другими жителями и гостями нашего города. Ваш отзыв Вы можете отправить ответом на данное сообщение или оставить свой телефон и удобное время, в которое наш сотрудник может с Вами связаться.",
                    "media": "",
                    "content": "text"
                }
                ]''');

List<Message> exampleMessages = json.map((e) => Message.fromJson(e)).toList();
