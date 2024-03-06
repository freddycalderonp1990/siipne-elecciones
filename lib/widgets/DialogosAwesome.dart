part of 'customWidgets.dart';

class DialogosAwesome {
  static getConTextImput(
      {String title = 'ERROR', String descripcion, BuildContext context}) {
    AwesomeDialog dialog;
    dialog = AwesomeDialog(
      dismissOnTouchOutside: false,
      dismissOnBackKeyPress: false,
      context: context,
      animType: AnimType.SCALE,
      dialogType: DialogType.INFO,
      keyboardAware: true,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Text(
              'Form Data',
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(
              height: 10,
            ),
            Material(
              elevation: 0,
              color: Colors.blueGrey.withAlpha(40),
              child: TextFormField(
                autofocus: true,
                minLines: 1,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  labelText: 'Title',
                  prefixIcon: Icon(Icons.text_fields),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Material(
              elevation: 0,
              color: Colors.blueGrey.withAlpha(40),
              child: TextFormField(
                autofocus: true,
                keyboardType: TextInputType.multiline,
                minLines: 2,
                maxLines: null,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  labelText: 'Description',
                  prefixIcon: Icon(Icons.text_fields),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            AnimatedButton(
                isFixedHeight: false,
                text: 'Close',
                pressEvent: () {
                  dialog.dissmiss();
                })
          ],
        ),
      ),
    )..show();
  }

  static getError(
      {String title = 'ERROR',
      BuildContext context,
      String descripcion,
      Function() btnOkOnPress}) {
    AwesomeDialog(
            dismissOnTouchOutside: false,
            dismissOnBackKeyPress: false,
            context: context,
            dialogType: DialogType.ERROR,
            animType: AnimType.RIGHSLIDE,
            headerAnimationLoop: false,
            title: title,
            desc: descripcion,
            btnOkText: "Ok",
            btnOkOnPress: btnOkOnPress ?? () {},
            btnOkIcon: Icons.cancel,
            btnOkColor: Colors.red)
        .show();
  }

  static getSucess(
      {String title = 'ÉXITO',
      BuildContext context,
      String descripcion,
      Function() btnOkOnPress}) {
    AwesomeDialog(
      dismissOnTouchOutside: false,
      dismissOnBackKeyPress: false,
      context: context,
      animType: AnimType.TOPSLIDE,
      dialogType: DialogType.SUCCES,
      title: title,
      headerAnimationLoop: false,
      desc: descripcion,
      btnOkText: "Ok",
      btnOkIcon: Icons.check_circle,
      btnOkOnPress: btnOkOnPress ??
          () {
            //  Get.back();
          },
    ).show();
  }

  static getWarning(
      {String title = 'Advertencia',
      BuildContext context,
      String descripcion,
      Function() btnOkOnPress}) {
    AwesomeDialog(
            dismissOnTouchOutside: false,
            dismissOnBackKeyPress: false,
            context: context,
            dialogType: DialogType.WARNING,
            headerAnimationLoop: false,
            animType: AnimType.TOPSLIDE,
            title: title,
            desc: descripcion,
            btnCancelIcon: Icons.cancel_rounded,
            btnOkIcon: Icons.check_circle,
            btnCancelText: "No",
            btnOkColor: Colors.deepOrangeAccent,
            btnOkText: "Ok",
            btnOkOnPress: btnOkOnPress ??
                () {
                  // Get.back();
                })
        .show();
  }

  static getWarningFoto(
      {String title = 'Advertencia',
      BuildContext context,
      String descripcion,
      Function() btnOkOnPress}) {
    AwesomeDialog(
            dismissOnTouchOutside: false,
            dismissOnBackKeyPress: false,
            context: context,
            dialogType: DialogType.WARNING,
            headerAnimationLoop: false,
            animType: AnimType.TOPSLIDE,
            title: title,
            desc: descripcion,
            btnCancelIcon: Icons.cancel_rounded,
            btnOkIcon: Icons.check_circle,
            btnCancelText: "No",
            btnOkColor: Colors.deepOrangeAccent,
            btnOkText: "Ok",
            btnOkOnPress: btnOkOnPress ?? () {})
        .show();
  }

  static getWarningSiNo(
      {String title = 'ADVERTENCIA',
      String descripcion,
      BuildContext context,
      Function() btnOkOnPress,
      Function() btnCancelOnPress}) {
    AwesomeDialog(
            dismissOnTouchOutside: false,
            dismissOnBackKeyPress: false,
            context: context,
            dialogType: DialogType.WARNING,
            headerAnimationLoop: false,
            animType: AnimType.TOPSLIDE,
            title: title,
            desc: descripcion,
            btnCancelText: "No",
            btnCancelIcon: Icons.cancel_rounded,
            btnOkIcon: Icons.check_circle,
            btnOkColor: Colors.blue,
            btnOkText: "Si",
            btnCancelOnPress: btnCancelOnPress ??
                () {
                  //Get.back();
                },
            btnOkOnPress: btnOkOnPress)
        .show();
  }

  static getInformation(
      {String title = 'Información',
      BuildContext context,
      String descripcion}) {
    if(descripcion=="noExiste"){
      descripcion="Sin datos que mostrar. Vuelva a intentar";
    }

    AwesomeDialog(
            dismissOnTouchOutside: false,
            dismissOnBackKeyPress: false,
            context: context,
            dialogType: DialogType.INFO,
            headerAnimationLoop: false,
            animType: AnimType.TOPSLIDE,
            title: title,
            desc: descripcion,
            btnCancelText: "Aceptar",
            btnCancelIcon: Icons.cancel_rounded,
            btnOkIcon: Icons.check_circle,
            btnOkOnPress: () {
              // Get.back();
            })
        .show();
  }

  static getInformationAceptar({
    String title = 'Información',
    BuildContext context,
    String descripcion,
    Function() btnOkOnPress,
  }) {
    if(descripcion=="noExiste"){
      descripcion="Sin datos que mostrar. Vuelva a intentar";
    }
    AwesomeDialog(
            dismissOnTouchOutside: false,
            dismissOnBackKeyPress: false,
            context: context,
            dialogType: DialogType.INFO,
            headerAnimationLoop: false,
            animType: AnimType.TOPSLIDE,
            title: title,
            desc: descripcion,
            btnCancelText: "Aceptar",
            btnCancelIcon: Icons.cancel_rounded,
            btnOkIcon: Icons.check_circle,
            btnOkOnPress: btnOkOnPress)
        .show();
  }

  static getInformationSiNo(
      {String title = 'INFORMACIÓN',
      BuildContext context,
      String descripcion,
      Function() btnOkOnPress,
      Function() btnCancelOnPress}) {
    if(descripcion=="noExiste"){
      descripcion="Sin datos que mostrar. Vuelva a intentar";
    }
    AwesomeDialog(
            dismissOnTouchOutside: false,
            dismissOnBackKeyPress: false,
            context: context,
            dialogType: DialogType.INFO,
            headerAnimationLoop: false,
            animType: AnimType.TOPSLIDE,
            title: title,
            btnCancelIcon: Icons.cancel_rounded,
            btnOkIcon: Icons.check_circle,
            desc: descripcion,
            btnCancelText: "No",
            btnOkText: "Si",
            btnCancelOnPress: btnCancelOnPress ??
                () {
                  // Get.back();
                },
            btnOkOnPress: btnOkOnPress)
        .show();
  }

  static getInformationSi({
    String title = 'INFORMACIÓN',
    BuildContext context,
    String descripcion,
    Function() btnOkOnPress,
  }) {
    if(descripcion=="noExiste"){
      descripcion="Sin datos que mostrar. Vuelva a intentar";
    }
    AwesomeDialog(
            dismissOnTouchOutside: false,
            dismissOnBackKeyPress: false,
            context: context,
            dialogType: DialogType.INFO,
            headerAnimationLoop: false,
            animType: AnimType.TOPSLIDE,
            title: title,
            btnCancelIcon: Icons.cancel_rounded,
            btnOkIcon: Icons.check_circle,
            desc: descripcion,
            btnCancelText: "No",
            btnOkText: "Ok",
            btnOkOnPress: btnOkOnPress)
        .show();
  }

  static getPersonalizado(
      {String title = 'Información',
      BuildContext context,
      String descripcion}) {
    if(descripcion=="noExiste"){
      descripcion="Sin datos que mostrar. Vuelva a intentar";
    }
    AwesomeDialog(
      dismissOnTouchOutside: false,
      dismissOnBackKeyPress: false,
      context: context,
      animType: AnimType.SCALE,
      customHeader: const Icon(
        Icons.face,
        size: 50,
        color: Colors.black,
      ),
      title: 'This is Custom Dialod',
      desc: 'Confirm or cancel the deletion process',
      btnOk: TextButton(
        child: const Text('Cancel Button'),
        onPressed: () {
          // Get.back();
        },
      ),
      //this is ignored
      btnOkOnPress: () {},
    ).show();
  }

  static getCamaraGallery(
      {@required String title,
      @required BuildContext context,
      @required String descripcion,
      @required ResponsiveUtil responsive,
      Function() btnOkOnPress,
      Function() btnCancelOnPress}) {
    AwesomeDialog(
      dismissOnTouchOutside: false,
      dismissOnBackKeyPress: false,
      context: context,
      dialogType: DialogType.INFO,
      headerAnimationLoop: false,
      customHeader: Container(
        child: Image.asset(AppConfig.imgIconD),
      ),
      animType: AnimType.SCALE,
      title: title,
      btnCancel: btnGaleria(responsive, btnCancelOnPress),
      btnOk: btnCamara(responsive, btnOkOnPress),
      desc: descripcion,
      showCloseIcon: true,
    ).show();
  }

  static Widget btnCamara(ResponsiveUtil responsive, Function() btnOkOnPress) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppConfig.radioBordecajas),
          boxShadow: [
            BoxShadow(
                color: AppConfig.colorBordecajas,
                blurRadius: AppConfig.sobraBordecajas)
          ]),
      child: Material(
        shadowColor: Colors.black12 != null ? Colors.black12 : Colors.white,
        borderRadius: BorderRadius.circular(20),
        elevation: 2,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            btnOkOnPress();
          },
          // handle your onTap here
          child: Container(
            margin:
                EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: responsive.anchoP(12),
                  height: responsive.anchoP(12),
                  child: Image.asset(
                    AppConfig.imgCamaraD,
                  ),
                ),
                SizedBox(
                  width: responsive.altoP(1),
                ),
                Container(
                    child: Text(
                  "Cámara",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: responsive.anchoP(AppConfig.tamTextoTitulo)),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Widget btnGaleria(ResponsiveUtil responsive, Function() btnOkOnPress) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppConfig.radioBordecajas),
          boxShadow: [
            BoxShadow(
                color: AppConfig.colorBordecajas,
                blurRadius: AppConfig.sobraBordecajas)
          ]),
      child: Material(
        shadowColor: Colors.black12 != null ? Colors.black12 : Colors.white,
        borderRadius: BorderRadius.circular(20),
        elevation: 2,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            btnOkOnPress();
          },
          // handle your onTap here
          child: Container(
            margin:
                EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: responsive.anchoP(12),
                  height: responsive.anchoP(12),
                  child: Image.asset(
                    AppConfig.imgFotosD,
                  ),
                ),
                SizedBox(
                  width: responsive.altoP(1),
                ),
                Container(
                    child: Text(
                  "Galeria",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: responsive.anchoP(AppConfig.tamTextoTitulo)),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
