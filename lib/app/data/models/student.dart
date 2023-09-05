class Student {
  String? studentId;
  String? countryId;
  String? freeTrialDate;
  bool? isFreeTrial;
  bool? isSubscribed;
  String? name;
  String? nickName;
  String? mobile;
  String? email;
  String? sectionName;
  String? stageName;
  String? gradeName;
  bool? isActive;
  bool? premiumSubscription;
  String? sectionId;
  String? stageId;
  String? gradeId;
  String? profileImage;

  Student({
    this.studentId,
    this.countryId,
    this.freeTrialDate,
    this.isFreeTrial,
    this.isSubscribed,
    this.name,
    this.nickName,
    this.mobile,
    this.email,
    this.isActive,
    this.premiumSubscription,
    this.sectionId,
    this.stageId,
    this.gradeId,
    this.profileImage,
  });

  void setSectionStageGradeNameManually(
      String sectionName, String stageName, String gradeName) {
    this.sectionName = sectionName;
    this.stageName = stageName;
    this.gradeName = gradeName;
  }

  Student.fromRegisterJson(Map<String, dynamic> json) {
    studentId = json['studentId'];
    countryId = json['countryId'];
    freeTrialDate = json['freeTrialDate'];
    isFreeTrial = json['isFreeTrial'];
    isSubscribed = json['isSubscriped'];
    name = json['name'];
    nickName = json['nickName'];
    mobile = json['mobile'];
    email = json['email'];
    isActive = json['isActive'];
    premiumSubscription = json['premiumSubscription'];
    sectionId = json['sectionId'];
    stageId = json['stageId'];
    gradeId = json['gradeId'];
    profileImage = json['profileImage'];
  }

  Student.fromProfileJson(Map<String, dynamic> json) {
    studentId = json['studentId'];
    countryId = json['countryId'];
    freeTrialDate = json['freeTrialDate'];
    isFreeTrial = json['isFreeTrial'];
    isSubscribed = json['isSubscriped'];
    name = json['name'];
    nickName = json['nickName'];
    mobile = json['mobile'];
    email = json['email'];
    sectionName = json['sectionName'];
    stageName = json['stageName'];
    gradeName = json['gradeName'];
    isActive = json['isActive'];
    premiumSubscription = json['premiumSubscription'];
    sectionId = json['sectionId'];
    stageId = json['stageId'];
    gradeId = json['gradeId'];
    profileImage = json['profileImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['studentId'] = studentId;
    data['countryId'] = countryId;
    data['freeTrialDate'] = freeTrialDate;
    data['isFreeTrial'] = isFreeTrial;
    data['isSubscriped'] = isSubscribed;
    data['name'] = name;
    data['nickName'] = nickName;
    data['mobile'] = mobile;
    data['email'] = email;
    data['isActive'] = isActive;
    data['premiumSubscription'] = premiumSubscription;
    data['sectionId'] = sectionId;
    data['stageId'] = stageId;
    data['gradeId'] = gradeId;
    data['profileImage'] = profileImage;
    return data;
  }
}
