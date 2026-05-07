class BlogModel {

  String id ,userId,title,des,status;
  DateTime createAt;

  BlogModel(this.id,this.userId,this.title,this.des,this.status,this.createAt);

  factory BlogModel.fromMap(map)=> BlogModel(
      map['id'],
      map['userId'],
      map['title'],
      map['des'],
      map['status'],
      DateTime.parse(map['createAt'])
  );

  Map<String,dynamic> toMap()=>{

    'id':id,
    'userId':userId,
    'title':title,
    'des':des,
    'status':status,
    'createAt': createAt.toString()
  };
}