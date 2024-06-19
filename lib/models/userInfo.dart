class MyUserInfo {
  final String disabilty;
  final String hobbies;
  final String edad;
  final String study;
  final String interests;

  MyUserInfo(this.disabilty, this.hobbies, this.edad, this.study, this.interests);

  Map<String, dynamic> toJson(){
    return {
      "disability": disabilty,
      "hobbies": hobbies,
      "age": edad,
      "studies": study,
      "interests": interests
    };
  }

  
}