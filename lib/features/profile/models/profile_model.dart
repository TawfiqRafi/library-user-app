class ProfileModel {
  String? responseCode;
  String? message;
  Content? content;

  ProfileModel({this.responseCode, this.message, this.content});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    message = json['message'];
    content = json['content'] != null ? Content.fromJson(json['content']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['response_code'] = responseCode;
    data['message'] = message;
    if (content != null) {
      data['content'] = content!.toJson();
    }
    return data;
  }
}

class Content {
  int? id;
  String? firstName;
  String? fcmToken;
  String? lastName;
  String? username;
  String? email;
  String? phone;
  String? image;
  String? userType;
  String? address;
  String? city;
  String? state;
  String? zipCode;
  int? status;
  int? emailVerified;
  int? smsVerified;
  String? verCode;
  String? verCodeSendAt;
  String? createdAt;
  String? updatedAt;

  Content({
    this.id,
    this.firstName,
    this.fcmToken,
    this.lastName,
    this.username,
    this.email,
    this.phone,
    this.image,
    this.userType,
    this.address,
    this.city,
    this.state,
    this.zipCode,
    this.status,
    this.emailVerified,
    this.smsVerified,
    this.verCode,
    this.verCodeSendAt,
    this.createdAt,
    this.updatedAt,
  });

  Content.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    fcmToken = json['fcm_token'];
    lastName = json['last_name'];
    username = json['username'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    userType = json['user_type'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    zipCode = json['zip_code'];
    status = json['status'];
    emailVerified = json['email_verified'];
    smsVerified = json['sms_verified'];
    verCode = json['ver_code'];
    verCodeSendAt = json['ver_code_send_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['fcm_token'] = fcmToken;
    data['last_name'] = lastName;
    data['username'] = username;
    data['email'] = email;
    data['phone'] = phone;
    data['image'] = image;
    data['user_type'] = userType;
    data['address'] = address;
    data['city'] = city;
    data['state'] = state;
    data['zip_code'] = zipCode;
    data['status'] = status;
    data['email_verified'] = emailVerified;
    data['sms_verified'] = smsVerified;
    data['ver_code'] = verCode;
    data['ver_code_send_at'] = verCodeSendAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
