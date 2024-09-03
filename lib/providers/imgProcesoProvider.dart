part of 'providers.dart';

class ImgProcesoProvider extends ChangeNotifier{

  DatosProcesoImg _procesoImg;

  DatosProcesoImg get getProcesoImg=>_procesoImg;

  set setProcesoImg(DatosProcesoImg data){
    this._procesoImg=data;
    //cuando cambia el dato hay que notificar a todos que este usando esta clase que este dato cambio
    notifyListeners();
  }

  static ImgProcesoProvider of(BuildContext context)=> Provider.of<ImgProcesoProvider>(context);

}