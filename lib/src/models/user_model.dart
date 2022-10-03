import 'package:cloud_firestore/cloud_firestore.dart';


class UserModel {
  final String? uid;
  final bool? isVerified;
  final String? email;
  String? password;
  final String? displayName;
  final int? age;
  final String? fatherName;
  final String? motherName;
  final String? userType;
  final String? dateOfBirth;
  final String? phone;
  TraineeModel? traineeModel;
  TrainerModel? trainerModel;
  HRModel? hrModel;

  UserModel(
      {this.phone,
      this.uid,
      this.email,
      this.password,
      this.displayName,
      this.age,
      this.isVerified,
      this.dateOfBirth,
      this.fatherName,
      this.motherName,
      this.userType,
      this.trainerModel,
      this.traineeModel,
      this.hrModel});

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'displayName': displayName,
      'age': age,
      'uid': uid,
      'isVerified': isVerified,
      'fatherName': fatherName,
      'motherName': motherName,
      'userType': userType,
      'dateOfBirth': dateOfBirth,
      'phone': phone,
      'TrainerModel': TrainerModel().toMap(),
      'TraineeModel': TraineeModel().toMap(),
      'HRModel': HRModel().toMap()
    };
  }

  UserModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : uid = doc.id,
        email = doc.data()!["email"],
        age = doc.data()!["age"],
        displayName = doc.data()!["displayName"],
        isVerified = doc.data()!["isVerified"],
        fatherName = doc.data()!["fatherName"],
        motherName = doc.data()!["motherName"],
        userType = doc.data()!["userType"],
        dateOfBirth = doc.data()!["dateOfBirth"],
        phone = doc.data()!["phone"],
        trainerModel =
            TrainerModel.fromJson(doc.data()!["TrainerModel"]),
        traineeModel =
            TraineeModel.fromJson(doc.data()!["TraineeModel"]),
        hrModel = HRModel.fromJson(doc.data()!["HRModel"]);

  UserModel copyWith(
      {bool? isVerified,
      String? uid,
      String? email,
      String? password,
      String? displayName,
      int? age,
      String? motherName,
      String? fatherName,
      String? userType,
      String? dateOfBirth,
      String? phone,
      TraineeModel? traineeModel,
      TrainerModel? trainerModel,
      HRModel? hrModel}) {
    return UserModel(
        uid: uid ?? this.uid,
        email: email ?? this.email,
        password: password ?? this.password,
        displayName: displayName ?? this.displayName,
        age: age ?? this.age,
        isVerified: isVerified ?? this.isVerified,
        motherName: motherName ?? this.motherName,
        fatherName: fatherName ?? this.fatherName,
        userType: userType ?? this.userType,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        phone: phone ?? this.phone,
        trainerModel: trainerModel ?? this.trainerModel,
        traineeModel: traineeModel ?? this.traineeModel,
        hrModel: hrModel ?? this.hrModel);
  }
}

class HRModel {
  int? status;
  HRModel({this.status=0});

  HRModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc):
  status = doc.get(['status'])
  ;
  Map<String, dynamic> toMap() {
    return {
      'status':status
    };
  }

  HRModel.fromJson(Map<String, dynamic> json) {
    status = json['status']?? '';
  }
}

class TrainerModel {
  int? status;

  TrainerModel({this.status = 0});

  TrainerModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      :status = doc.get(['status']);
  TrainerModel.fromJson(Map<String, dynamic> json) {
    status = json['status']?? '';
  }
  Map<String, dynamic> toMap() {
    return {
      'status': status
    };
  }
}

class TraineeModel {
  int? status;

  TraineeModel({this.status = 0});
  TraineeModel.fromJson(Map<String, dynamic> json) {
    status = json['status']?? '';
  }
  TraineeModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      :status = doc.get(['status']);

  Map<String, dynamic> toMap() {
    return {
      'status': status
    };
  }
}
