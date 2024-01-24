class Endpoint {
  // infor

  // Family
  static const familyUsersEndPoint = "/api/families/family";
  static const familiesEndPoint = "/api/families";

  // Auth
  static const googleEndPoint = "/api/auth/login";
  static const regisEndPoint = "/api/auth/register";
  static const verifyOtpEndPoint = "/api/auth/otp";
  static const resendOtp = "/api/auth/otp";
  static const infoEndpoint = "/api/auth/info";

  static const refreshTokenEndPoint = "/api/auth/refresh-token";
  // User
  static const userEndPoint = "/api/profiles";

  //Blog
  static const blogEndPoint = "/api/blogs";
  static const blogTypeEndPoint = "/api/blog-types";

  // GPT chat
  static const gptChatEndPoint = "/api/gpt/chat";

  //Subcription
  static const subcriptionEndPoint = "/api/subcriptions";

  // Message
  static const messagesEndPoint = "/api/chat/recent";
  static const channelMessagesEndPoint = "/api/chat/channel";

  // Paypal
  static const paypalEndPoint = "/api/paypal/create-paypal-order";
  static const capturePaypalEndPoint = "/api/paypal/capture";

  //Notification
  static const notificationEndPoint = "/api/notifications";

  //History
  static const historyEndPoint = "/api/history";

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
}
