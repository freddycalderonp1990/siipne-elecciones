part of 'providers.dart';

class UserProvider extends ChangeNotifier{

  Usuario _user;

  Usuario get getUser=>_user;

   set setUser(Usuario user){
    this._user=user;
    //cuando cambia el dato hay que notificar a todos que este usando esta clase que este dato cambio
    notifyListeners();
  }

  static UserProvider of(BuildContext context)=> Provider.of<UserProvider>(context);

}