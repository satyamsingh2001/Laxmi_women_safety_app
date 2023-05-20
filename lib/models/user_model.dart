

class User_Model{

  String? name;
  String? id;
  String? phone;
  String? childemail;
  String? parentemail;
  String? type;

  User_Model({  this.name,  this.id,  this.phone,  this.childemail,  this.parentemail, required type});

  Map<String,dynamic> toJson()=>{
    'name':name,
    'id':id,
    'phone':phone,
    'childemail':childemail,
    'parentemail':parentemail,
    'type':type,
  };
}