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

  // Paypal
  static const paypalEndPoint = "/api/paypal/create-paypal-order";
  static const capturePaypalEndPoint = "/api/paypal/capture";

  //Notification
  static const notificationEndPoint = "/api/notifications";

  //History
  static const historyEndPoint = "/api/history";
}
