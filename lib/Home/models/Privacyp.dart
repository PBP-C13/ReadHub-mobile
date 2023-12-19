// To parse this JSON data, do
//
//     final privacyp = privacypFromJson(jsonString);

import 'dart:convert';

Privacyp privacypFromJson(String str) => Privacyp.fromJson(json.decode(str));

String privacypToJson(Privacyp data) => json.encode(data.toJson());

class Privacyp {
    String privacyPolicy;

    Privacyp({
        required this.privacyPolicy,
    });

    factory Privacyp.fromJson(Map<String, dynamic> json) => Privacyp(
        privacyPolicy: json["privacy_policy"],
    );

    Map<String, dynamic> toJson() => {
        "privacy_policy": privacyPolicy,
    };
}
