import 'package:flutter/material.dart';

class RegisterResponseModel {
  String id;
  String publicKey;
  String token;

  RegisterResponseModel({this.id, this.publicKey, this.token});

  RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    publicKey = json['public_key'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['public_key'] = this.publicKey;
    data['token'] = this.token;
    return data;
  }
}

class RegisterRequestModel {
  String publicKey;

  RegisterRequestModel({@required this.publicKey});

  RegisterRequestModel.fromJson(Map<String, dynamic> json) {
    publicKey = json['public_key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['public_key'] = this.publicKey;
    return data;
  }
}
