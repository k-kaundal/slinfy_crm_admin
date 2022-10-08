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
  Map<String, dynamic>? traineeModuleMap;

  Map<String, dynamic>? trainerModuleMap;

  Map<String, dynamic>? hrModuleMap;

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
      this.hrModel,
      this.hrModuleMap,
      this.traineeModuleMap,
      this.trainerModuleMap});

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
      'TrainerModel': trainerModuleMap ?? TrainerModel().toMap(),
      'TraineeModel': traineeModuleMap ?? TraineeModel().toMap(),
      'HRModel': hrModuleMap ?? HRModel().toMap()
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
        trainerModel = TrainerModel.fromJson(doc.data()!["TrainerModel"]),
        traineeModel = TraineeModel.fromJson(doc.data()!["TraineeModel"]),
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

  HRModel({this.status = 0});

  HRModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : status = doc.get(['status']);

  Map<String, dynamic> toMap() {
    return {'status': status};
  }

  HRModel.fromJson(Map<String, dynamic> json) {
    status = json['status'] ?? '';
  }
}

class TrainerModel {
  int? status;
  List? technology;
  String? id;

  TrainerModel({this.status = 0, this.technology, this.id});

  TrainerModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : status = doc.get(['status']);

  TrainerModel.fromJson(Map<String, dynamic> json) {
    status = json['status'] ?? '';
    technology = json['technology'] ?? [];
    id = json['id'] ?? '';
  }

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'technology': technology,
    };
  }
}

class TraineeModel {
  int? status;
  String? name;
  String? email;
  String? id;
  String? college;
  String? dateOfJoining;
  String? enrollmentDate;
  String? endDate;
  List? technology;
  Map<String, dynamic>? feeDetailsModelMap;
  FeeDetailsModel? feeDetailsModel;

  TraineeModel(
      {this.status = 0,
      this.name,
      this.email,
      this.id,
      this.college,
      this.dateOfJoining,
      this.enrollmentDate,
      this.endDate,
      this.technology,
      this.feeDetailsModelMap});

  TraineeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'] ?? '';
    name = json['name'] ?? '';
    email = json['email'] ?? '';
    id = json['id'] ?? '';
    college = json['college'] ?? '';
    dateOfJoining = json['dateOfJoining'] ?? '';
    enrollmentDate = json['enrollmentDate'] ?? '';
    endDate = json['endDate'] ?? '';
    technology = json['technology'] ?? [];
    // feeDetailsModel = FeeDetailsModel.fromDocumentSnapshot(json['feeDetailsModel']);
  }

  TraineeModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : status = doc.get(['status']);

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'name': name,
      'email': email,
      'id': id,
      'college': college,
      'dateOfJoining': dateOfJoining,
      'enrollmentDate': enrollmentDate,
      'endDate': endDate,
      'technology': technology,
      'feeDetailsModel': feeDetailsModelMap??FeeDetailsModel().toMap()
    };
  }
}

class FeeDetailsModel {
  int? status;
  String? totalFee;
  String? registrationFee;
  String? dueFee;
  String? pendingFee;
  String? nextDueDate;

  FeeDetailsModel(
      {this.status = 0,
      this.totalFee,
      this.registrationFee,
      this.dueFee,
      this.pendingFee='0',
      this.nextDueDate});

  FeeDetailsModel.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> doc)
      : status = doc.get(['status']),
        totalFee = doc.get(['totalFee']);

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'totalFee': totalFee,
      'registrationFee': registrationFee,
      'dueFee': dueFee,
      'pendingFee': pendingFee,
      'nextDueDate': nextDueDate
    };
  }

  FeeDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'] ?? '';
  }
}
