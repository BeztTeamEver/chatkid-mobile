import 'package:chatkid_mobile/enum/role.dart';

class EmojiModel {
  final String emoji;
  final String label;

  EmojiModel({required this.emoji, required this.label});
}

final FeedbackEmojiList = [
  EmojiModel(emoji: 'emoji/hard', label: "Rất khó"),
  EmojiModel(emoji: 'emoji/semi_hard', label: "Khó"),
  EmojiModel(emoji: 'emoji/normal', label: "Bình thường"),
  EmojiModel(emoji: 'emoji/semi_easy', label: "Dễ"),
  EmojiModel(emoji: 'emoji/easy', label: "Rất dễ"),
];

final BotFeedBackMessage = [
  "Bạn cảm thấy công việc được giao có dễ không?",
  "Cảm xúc của bạn như thế nào đối với công việc được giao?",
  "Bạn hãy chụp ngay chiến tích để khoe ngay cho ba mẹ nào",
  "Gửi thêm vài dòng cảm xúc để ba mẹ có thể hiểu thêm về bạn nhé",
  ""
];

class StickerList {
  static const _boySticker = [];
  static const _girlSticker = [];

  static List getSticker(String gender) {
    return gender == Gender.male.name ? _boySticker : _girlSticker;
  }
}
