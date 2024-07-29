import 'package:chatkid_mobile/enum/role.dart';
import 'package:chatkid_mobile/models/emoji_model.dart';

final FeedbackEmojiList = [
  EmojiModel(url: 'emoji/hard', name: "Rất khó"),
  EmojiModel(url: 'emoji/semi_hard', name: "Khó"),
  EmojiModel(url: 'emoji/normal', name: "Bình thường"),
  EmojiModel(url: 'emoji/semi_easy', name: "Dễ"),
  EmojiModel(url: 'emoji/easy', name: "Rất dễ"),
];

final BotFeedBackMessage = [
  "Bạn cảm thấy công việc được giao có dễ không?",
  "Cảm xúc của bạn như thế nào đối với công việc được giao?",
  "Bạn hãy chụp ngay chiến tích để khoe ngay cho ba mẹ nào",
  "Gửi thêm vài dòng cảm xúc để ba mẹ có thể hiểu thêm về bạn nhé",
  ""
];

class FeedbackConstants {
  static final String NORMAL = "normal";
  static final String EASY = "easy";
  static final String VERY_EASY = "very_easy";
  static final String HARD = "hard";
  static final String VERY_HARD = "very_hard";
}

final FeedbackMap = {
  FeedbackConstants.NORMAL: "Bình thường",
  FeedbackConstants.EASY: "Dễ",
  FeedbackConstants.VERY_EASY: "Rất dễ",
  FeedbackConstants.HARD: "Khó",
  FeedbackConstants.VERY_HARD: "Rất khó",
};

class StickerList {
  static const _boySticker = [];
  static const _girlSticker = [];

  static List getSticker(String gender) {
    return gender == Gender.male.name ? _boySticker : _girlSticker;
  }
}
