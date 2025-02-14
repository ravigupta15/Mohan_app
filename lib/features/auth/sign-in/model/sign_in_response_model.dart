// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);



class LoginResponseModel {
    bool status;
    String message;
    List<Datum> data;

    LoginResponseModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    String accessToken;
    String fullName;
    String employeeId;
    int expiresIn;
    String role;

    Datum({
        required this.accessToken,
        required this.fullName,
        required this.employeeId,
        required this.expiresIn,
        required this.role,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        accessToken: json["access_token"],
        fullName: json["full_name"],
        employeeId: json["employee_id"],
        expiresIn: json["expires_in"],
        role: json["role"],
    );

    Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "full_name": fullName,
        "employee_id": employeeId,
        "expires_in": expiresIn,
        "role": role,
    };
}
