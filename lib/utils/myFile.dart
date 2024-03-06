part of 'utils.dart';

class MyFile{


  static Future<File> getFile(String name) async {
    final path = await UtilidadesUtil.getLocalPath;
    String file='$path/'+name+'.txt';
    return File(file);
  }

  static Future<File> writeFile({String name='File',@required String palabra}) async {
    final file = await getFile(name);
    // Escribir el archivo
    return file.writeAsString('$palabra');
  }


}