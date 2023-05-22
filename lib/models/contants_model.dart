

class Contact_Model{

  int? _id;
  String? _name;
  String? _number;

  Contact_Model(this._name,this._number);
  Contact_Model.withId(this._id,this._name,this._number);

  // getter

  int get id => _id!;
  String get name => _name!;
  String get number => _number!;

  @override
  String toString(){
    return 'Contact: {id: $_id, name: $_name, number: $_number}';
  }

  //  setter
    set number(String newNumber) => this._number = newNumber;
    set name(String newName) => this._name = newName;



  //convert a Contact object to a Map object
  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    map['id'] = this._id;
    map['number'] = this._number;
    map['name'] = this._name;

    return map;
  }

  //Extract a Contact Object from a Map object
  Contact_Model.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._number = map['number'];
    this._name = map['name'];
  }

}