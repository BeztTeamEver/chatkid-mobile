class Endpoint {
  // infor
  static const memberEnpoint = "/api/member";
  static const memberLoginEnpoint = "/api/member/login";
  static const memberRefreshTokenEnpoint = "/api/member/refresh-token";
  // Family
  static const familyUsersEndPoint = "/api/families/family";
  static const familiesEndPoint = "/api/families";
  static const familyChannelsEndPoint = "/api/families/{id}/channels";
  static const ownFamilyEndpoint = "/api/families/own-family";

  // Auth
  static const googleEndPoint = "/api/auth/login";
  static const regisEndPoint = "/api/auth/register";
  static const verifyOtpEndPoint = "/api/auth/verify-OTP";
  static const resendOtp = "/api/auth/otp";
  static const infoEndpoint = "/api/auth/info";

  static const refreshTokenEndPoint = "/api/auth/refresh-token";
  // User
  static const userEndPoint = "/api/profiles";
  static const profileUserEndpoint = "/api/member";
  static const transferDiamondEndpoint = "/api/wallet/transfer";

  // Bot
  static const botAssetEndPoint = "/api/assets";
  static const storeAssetEndPoint = "/api/assets/me?isOwned=false";
  static const botAssetSelectedEndPoint = "/api/assets/skin";
  static const buyBotAssetEndPoint = "/api/assets/buy/{id}";
  static const selectBotAssetEndPoint = "/api/assets/equip/{id}";
  static const unselectBotAssetEndPoint = "/api/assets/unequip/{id}";

  //Blog
  static const blogEndPoint = "/api/blogs";
  static const blogTypeEndPoint = "/api/blog-types";
  static const blogTypeEndPointById = "/api/blog-types/{id}/blogs";

  // GPT chat
  static const gptChatEndPoint = "/api/gpt/chat";

  //Subcription
  static const packageEndPoint = "/api/packages";
  static const createZaloPayOrderEndPoint = "/api/packages/{id}";
  static const listTransactionTransferEndPoint = "/api/application-transactions";

  // Message
  static const messagesEndPoint = "/api/chat/recent";
  static const channelMessagesEndPoint = "/api/chat/channels";

  // Transaction 
  static const createTransactionEndPoint = "/api/payment-transaction";
  static const getPaymentTransactionEndPoint = "/api/payment-transaction";

  //Notification
  static const notificationEndPoint = "/api/history";

  //History
  static const historyEndPoint = "/api/history";

  // file
  static const fileUploadEndPoint = "/api/file-upload/upload";
  static const avatarEndpoint = "/api/file-upload/avatar";
  // Chat service emit

  static const joinChannelEndPoint = "joinChannel";
  static const sendMessageEndPoint = "createMessage";
  static const leaveChannelEndPoint = "leaveChannel";
  static const createGroupEndPoint = "createGroup";
  static const joinGroupEndPoint = "joinGroup";
  static const leaveGroupEndPoint = "leaveGroup";
  // Chat service on
  static const onMessageEndPoint = "onMessage";
  static const onGroupCreateEndPoint = "onGroupCreate";
  static const onGroupJoinEndPoint = "onGroupJoin";
  static const onGroupLeaveEndPoint = "onGroupLeave";

  // Task category
  static const taskCategoryEndPoint = "/api/task-categories";
  static const taskMemberEndpoint = "/api/tasks/member";
  static const favoriteTaskTypeEndPoint = "/api/favorite-task-type";
  static const taskEmojiEndpoint = "/api/tasks/emoji";

  // Tasks
  static const taskEndPoint = "/api/tasks";

  // Target
  static const targetEndpoint = "/api/targets";
  static const myTargetEndpoint = "/api/targets/me";
  static const memberTargetEndpoint = "/api/targets/member";
}
