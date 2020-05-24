class RegisterResponseModel {
  String id;
  String publicKey;
  String token;
  String refreshToken;

  RegisterResponseModel({
    this.id,
    this.publicKey,
    this.token,
    this.refreshToken,
  });

  RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    publicKey = json['public_key'];
    token = json['token'];
    refreshToken = json['refresh_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['public_key'] = this.publicKey;
    data['token'] = this.token;
    data['refresh_token'] = this.refreshToken;
    return data;
  }
}
