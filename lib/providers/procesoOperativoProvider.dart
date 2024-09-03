part of 'providers.dart';



class ProcesoOperativoProvider extends ChangeNotifier{

  ProcesosOperativo _procesosOperativos;

  ProcesosOperativo get getProcesosOperativo=>_procesosOperativos;

  setProcesoOperativo(ProcesosOperativo procesosOperativo){
    this._procesosOperativos=procesosOperativo;
    //cuando cambia el dato hay que notificar a todos que este usando esta clase que este dato cambio
    notifyListeners();
  }




  static ProcesoOperativoProvider of(BuildContext context)=> Provider.of<ProcesoOperativoProvider>(context);

}