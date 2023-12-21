
class RoleController{

  static final RoleController _roleController = RoleController._internal();

  String? role;

  factory RoleController(){
    return _roleController;
  }

  RoleController._internal();

}