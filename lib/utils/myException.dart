part of 'utils.dart';




class MyException {
  static void printMsjDebug({String tag,String message,String ambiente}){

    String msj = '';

    switch (ambiente) {

      case Host.hostDesarrollo:
        msj = tag + "  ${message}";

        break;

      case Host.hostPruebas:
        msj = tag + "  ${message}";

        break;

      case Host.hostProduccion:
        msj = '';

        break;
    }

    print(msj);

  }

}