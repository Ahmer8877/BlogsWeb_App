//user auth model

class UserModel {

  String? id;
  String name,email,password;

  UserModel(this.id,this.name,this.email,this.password);

  //factory cons..
  factory UserModel.fromMap(map) => UserModel(
      map['id'],
      map['name'],
      map['email'],
      map['password']
  );

  //Map...
  Map<String ,dynamic> toMap()=>{
    'id':id,
    'name':name,
    'email':email,
    'password':password,
    'role':'user'
  };
}