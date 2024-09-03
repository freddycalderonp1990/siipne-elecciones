part of 'providers.dart';

class RecintoAbiertoProvider extends ChangeNotifier{

  RecintosElectoralesAbiertos _RecintosElectoralesAbiertos;

  RecintosElectoralesAbiertos get getRecintoAbierto=>_RecintosElectoralesAbiertos;

   setRecinto(RecintosElectoralesAbiertos recintosElectoralesAbiertos){
    this._RecintosElectoralesAbiertos=recintosElectoralesAbiertos;
    //cuando cambia el dato hay que notificar a todos que este usando esta clase que este dato cambio
    notifyListeners();
  }



  static RecintoAbiertoProvider of(BuildContext context)=> Provider.of<RecintoAbiertoProvider>(context);

}