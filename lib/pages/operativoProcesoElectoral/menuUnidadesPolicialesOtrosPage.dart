part of '../pages.dart';

class MenuUnidadesPolicialesOtrosPage extends StatefulWidget {
  @override
  _MenuUnidadesPolicialesOtrosPageState createState() => _MenuUnidadesPolicialesOtrosPageState();
}

class _MenuUnidadesPolicialesOtrosPageState extends State<MenuUnidadesPolicialesOtrosPage> {
  UserProvider _UserProvider;
  RecintoAbiertoProvider _RecintoProvider;
  bool peticionServer = false;
  bool cargaInicial = true;
  String estadoRecinto="";
  String totalPersonal="0";
  String totalNovedades="0";

  RecintosElectoralesApi _recintosElectoralesApi = new RecintosElectoralesApi();
  NovedadesElectoralesApi _novedadesElectoralesApi =new NovedadesElectoralesApi();

  String idDgoCreaOpReci='', nombreRecinto = "", encargadoRecinto, idDgoReciElect;

  double separacionBtnMenu = 1.5;
  Widget wgMenu = Container();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UtilidadesUtil
        .getTheme(); //cambia el color de texto de barra superios del telefono
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //Variable para obtener el tamaño de la pantalla

    final responsive = ResponsiveUtil(context);

    _UserProvider = UserProvider.of(context);
    _RecintoProvider = RecintoAbiertoProvider.of(context);



    String Bienvenido = _UserProvider.getUser.sexo == 'HOMBRE'
        ? VariablesUtil.Bienvenido
        : VariablesUtil.Bienvenida;

    _verificarPersonalEncargadoAsignadoRecElectPorIdGenPersona(
        _UserProvider.getUser.idGenPersona, responsive);
    return WorkAreaPageWidget(

      peticionServer: peticionServer,
      title: nombreRecinto != ""
          ? nombreRecinto
          : "MENÚ UNIDADES POLICIALES - OTROS",
      imgPerfil: _UserProvider.getUser.foto,
      contenido: <Widget>[
        MyUbicacionWidget(
          mostraUbicacion: false,
          callback:(_) {

          },),
        Container(
          padding: EdgeInsets.all(5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              Container(
                  decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.circular(AppConfig.radioBordecajas),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.blue.withOpacity(0.6),
                            blurRadius: 10)
                      ]),
                  child: Column(children: [
                          SizedBox(
                          height: responsive.altoP(1),
                          ),
                    Text(
                      Bienvenido + _UserProvider.getUser.apenom,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: responsive.anchoP(3.5)),
                    )
                    ],)
                  ),

              wgMenu
            ],
          ),
        ),
        SizedBox(
          height: responsive.altoP(1),
        ),
        Container(
          width: responsive.anchoP(30),
          child: BtnIconWidget(
            iconData: Icons.exit_to_app,
            title: VariablesUtil.Salir,
            colorTextoIcon: Colors.white,
            color: Colors.blue,
            onTap: () => _cerrarSession(),
          ),
        ),
        SizedBox(
          height: responsive.altoP(3.5),
        ),
      ],
    );
  }

/*  _cerrarSession() {
    //Aquí (Route <dynamic> route) => false se asegurará de que se eliminen todas las rutas antes de hacer push de la ruta .
    Navigator.of(context).pushNamedAndRemoveUntil(AppConfig.pantallaLogin, (Route<dynamic> route) => false);

    //Navigator.pushReplacementNamed(context, AppConfig.pantallaLogin);
  }*/
  _cerrarSession() {
    //Aquí (Route <dynamic> route) => false se asegurará de que se eliminen todas las rutas antes de hacer push de la ruta .
    Navigator.of(context).pushNamedAndRemoveUntil(
        AppConfig.pantallaInicioRapido, (Route<dynamic> route) => false);
  }


  _getMenuJefe(ResponsiveUtil responsive) {
    return Column(
      children: [
        _wgCodigoRecinto(responsive),
        BtnMenuWidget(
            img: AppConfig.icon_agregar_personal,
            titlte: VariablesUtil.recElecAgregarpersonal,
            onTap: () {
              _consultaRecintoAbierto(_UserProvider.getUser.idGenPersona,'personal','agregar personal al Operativo.',responsive);
            /*  Navigator.pushNamed(
                  context, AppConfig.pantallaRecElecAddPersonal);*/
            }),
        SizedBox(
          height: responsive.altoP(separacionBtnMenu),
        ),
        BtnMenuWidget(
            img: AppConfig.icon_registrar_novedades_rec_elec,
            titlte: VariablesUtil.recElecRegistrarNovedades,
            onTap: () {
              _consultaRecintoAbierto(_UserProvider.getUser.idGenPersona,'novedades','registrar Novedades.',responsive);
                }),
        SizedBox(
          height: responsive.altoP(separacionBtnMenu),
        ),
        BtnMenuWidget(
            img: AppConfig.icon_finalizar_rec_elec,
            titlte: VariablesUtil.FinalizarOperativo,
            onTap: (){
                     _getReporteFinal(responsive);
                    }),

        SizedBox(
          height: responsive.altoP(separacionBtnMenu),
        ),
        BtnMenuWidget(
            img: AppConfig.icon_eliminar_rec_elec,
            titlte: VariablesUtil.EliminarOperativo,
            onTap: () {

              _consultaRecintoAbierto(_UserProvider.getUser.idGenPersona,'eliminar','eliminar el Operativo. El Operativo Finalizará Automaticamente',responsive);
          /*    DialogosWidget.alertSiNo(context,
                  title: VariablesUtil.EliminarOperativo,
                  message:
                  "Si abrió por error el Operativo se recomienda eliminarlo.  "
                      "\n\nRecuerde todo será registrado para verificar el correcto uso del aplicativo."
                      "\n\n¿Esta seguro que desea eliminar el Operativo.?",
                  onTap: () {
                    Navigator.of(context).pop();
                    _EliminarRecintoElectoral(
                        usuario: _UserProvider.getUser.idGenUsuario,
                        idDgoCreaOpReci:
                        _RecintoProvider.getRecintoAbierto.idDgoCreaOpReci);
                  });*/
            }),
      ],
    );
  }

  _getMenuNoJefe(ResponsiveUtil responsive) {
    return Column(
      children: [
        _wgCodigoRecinto(responsive),
        BtnMenuWidget(
            img: AppConfig.icon_registrar_novedades_rec_elec,
            titlte: VariablesUtil.recElecRegistrarNovedades,
            onTap: () {
              _consultaRecintoAbierto(_UserProvider.getUser.idGenPersona,'novedades','registrar Novedades.',responsive);
              /* Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => VerificarGpsPage(
                        pantalla: registrarNovedadesPage())));
              */
            }),
        SizedBox(
          height: responsive.altoP(separacionBtnMenu),
        ),
        BtnMenuWidget(
            img: AppConfig.icon_abandonar_rec_elec,
            titlte: VariablesUtil.AbandonarOperativo,
            onTap: () {

              _consultaRecintoAbierto(_UserProvider.getUser.idGenPersona,'abandonar','abandonar el Operativo. El operativo finalizará automáticamente',responsive);


              /*DialogosWidget.alertSiNo(context,
                  title: "Abandonar Operativo",
                  message:
                  "¿Esta seguro que desea abandonar el Operativo.?",
                  onTap: () {
                    Navigator.of(context).pop();
                    _AbandonarRecintoElectoral(
                        usuario: _UserProvider.getUser.idGenUsuario,
                        idDgoPerAsigOpe:
                        _RecintoProvider.getRecintoAbierto.idDgoPerAsigOpe);
                  });*/
            }),
      ],
    );
  }

  _wgCodigoRecinto(ResponsiveUtil responsive) {
    return Column(
      children: [
        Container(
            decoration: BoxDecoration(
                borderRadius:
                BorderRadius.circular(AppConfig.radioBordecajas),
                boxShadow: [
                  BoxShadow(
                      color: Colors.white60.withOpacity(0.3),
                      blurRadius: 10)
                ]),
            child: Text(
              _RecintoProvider.getRecintoAbierto.descProcElecc,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: responsive.anchoP(3.5)),
            )),

        Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppConfig.radioBordecajas),
                boxShadow: [
                  BoxShadow(
                      color: Colors.white12.withOpacity(0.5), blurRadius: 10)
                ]),
            child:Column(
              children: [
                SizedBox(
                  height: responsive.altoP(1.0),
                ),
                Text(
                  "CÓDIGO DEL OPERATIVO:",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: responsive.anchoP(4.5)),
                )
              ],
            ),
            ),
        Container(
          width: responsive.anchoP(30),
          child: BtnIconWidget(
            title: idDgoCreaOpReci,
            colorTextoIcon: Colors.white,
            color: Colors.blue.withOpacity(0.70),
          ),
        ),
        SizedBox(
          height: responsive.altoP(1.5),
        ),
        SizedBox(
          height: responsive.altoP(separacionBtnMenu),
        ),
      ],
    );
  }

//Metodo para saber si el usuario esta asignado a un recinto electoral
  //en caso de true es personal asignado y no jefe
  _verificarPersonalEncargadoAsignadoRecElectPorIdGenPersona(
      String idGenPersona, ResponsiveUtil responsive) async {
    try {
      if (!cargaInicial) return;
      if (peticionServer) return;

      setState(() {
        peticionServer = true;
      });
      RecintosElectoralesAbiertos _RecintosElectoralesAbiertos =_RecintoProvider.getRecintoAbierto;
      idDgoCreaOpReci=_RecintosElectoralesAbiertos.idDgoCreaOpReci;
      nombreRecinto=_RecintosElectoralesAbiertos.nomRecintoElec;

      if (_RecintosElectoralesAbiertos.isJefe) {
        wgMenu = _getMenuJefe(responsive);
      } else {
        wgMenu = _getMenuNoJefe(responsive);
      }

      setState(() {
        peticionServer = false;
        cargaInicial = false;
      });
    } catch (e) {
      setState(() {
        peticionServer = false;
        cargaInicial = false;
      });
    }
  }

  _EliminarRecintoElectoral(
      {@required String usuario, @required String idDgoCreaOpReci}) async {
    try {
      if (peticionServer) return;

      setState(() {
        peticionServer = true;
      });

      bool res = await _recintosElectoralesApi.eliminarRecintoElectoralAbierto(
        context: context,
        idDgoCreaOpReci: idDgoCreaOpReci,
        usuario: usuario,
        msj1: 'Operativo eliminado con éxito!. ',
          title: 'OPERATIVO'
      );

      setState(() {
        peticionServer = false;
      });
    } catch (e) {
      setState(() {
        peticionServer = false;
      });
    }
  }

  _AbandonarRecintoElectoral(
      {@required String usuario, @required String idDgoPerAsigOpe, }) async {
    try {
      if (peticionServer) return;

      setState(() {
        peticionServer = true;
      });
      String latitud =
      _UserProvider.getUser.ubicacionSeleccionada.latitude.toString();
      String longitud =
      _UserProvider.getUser.ubicacionSeleccionada.longitude.toString();


      bool res = await _recintosElectoralesApi.abandonarRecintoElectoral(
        context: context,
        idDgoPerAsigOpe: idDgoPerAsigOpe,
        usuario: usuario,
        latitud: latitud,
        longitud: longitud,
        title: 'OPERATIVO',
          msj1:'Usted Abandonó con éxito el Operativo!'
      );

      setState(() {
        peticionServer = false;
      });
    } catch (e) {
      setState(() {
        peticionServer = false;
      });
    }
  }

  _getReporteFinal(ResponsiveUtil responsive) async{

    await _ConusltarPersonalAsignado(responsive);

    /* DialogosWidget.alertSiNo(context,
                  title: "Finaliza Proceso Electoral",
                  message:
                  "¿Esta seguro que desea finalizar el proceso electoral.?",
                  onTap: () {
                    Navigator.of(context).pop();
                    _FinalizarRecintoElectoral(usuario: _UserProvider.getUser.idGenUsuario,idDgoCreaOpReci: _RecintoProvider.getRecintoAbierto.idDgoCreaOpReci);
                  });*/
  }

  _FinalizarRecintoElectoral(
      {@required String usuario, @required String idDgoCreaOpReci}) async {
    try {
      if (peticionServer) return;

      setState(() {
        peticionServer = true;
      });

      bool res = await _recintosElectoralesApi.finalizarRecintoElectoral(
          context: context,
          idDgoCreaOpReci: idDgoCreaOpReci,
          usuario: usuario,
          idDgoPerAsigOpe: _RecintoProvider.getRecintoAbierto.idDgoPerAsigOpe,
          title: 'OPERATIVO',
          msj1: 'Usted finalizó con éxito el Operativo!.',
          idDgoTipoEje:  _RecintoProvider.getRecintoAbierto.idDgoTipoEje
      );

      setState(() {
        peticionServer = false;
      });
    } catch (e) {
      setState(() {
        peticionServer = false;
      });
    }
  }


  _ConusltarPersonalAsignado(ResponsiveUtil responsive) async {
    try {

      if (peticionServer) return;

      setState(() {
        peticionServer = true;
      });

      List<PersonalRecintoElectoral>  _ListPersonalRecintoElectoral = await _recintosElectoralesApi
          .consultarDatosPersonalAsignadoRecintoElectoral(
        context: context,
        idDgoCreaOpReci: _RecintoProvider.getRecintoAbierto.idDgoCreaOpReci,
      );
      totalPersonal=_ListPersonalRecintoElectoral.length.toString();

      setState(() {
        peticionServer = false;

      });

      _ConusltarNovedadesRecinto(responsive);
    } catch (e) {
      print("un error ${e.toString()}");
      setState(() {
        peticionServer = false;

      });
    }
  }

  _ConusltarNovedadesRecinto(ResponsiveUtil responsive) async {
    try {

      if (peticionServer) return;

      setState(() {
        peticionServer = true;
      });

      List<NovedadesElectoralesDetalle> _ListNovedadesRecinto = await _novedadesElectoralesApi
          .getDetalleNovedadesPorRecinto(
        mostrarMsj: false,
        context: context,
        idDgoCreaOpReci: _RecintoProvider.getRecintoAbierto.idDgoCreaOpReci,
      );
      totalNovedades=_ListNovedadesRecinto.length.toString();

      print("termina consulta");
      setState(() {
        peticionServer = false;

      });
      _consultaRecintoAbierto(_UserProvider.getUser.idGenPersona,'finalizar','finalizar el Operativo. El Operativo finalizará automaticamente',responsive);
   /*   print("ahora dibujp consulta");
      Widget wg=Column(
        children: [
          Container(
            width: responsive.anchoP(70),
            child: TituloTextWidget(
              textAlign: TextAlign.center,
              title:
              _RecintoProvider.getRecintoAbierto.nomRecintoElec,
            ),
          ),
          TituloDetalleTextWidget(
            title: "Total Personal",
            detalle: totalPersonal,
            mostrarBorder: true,
          ),
          TituloDetalleTextWidget(
            title: "Total Novedades",
            detalle: totalNovedades,
            mostrarBorder: true,
          ),
          DialogosWidget.getDialogoMsj(
              "¿Esta seguro que desea finalizar el Operativo.?")
        ],
      );


      DialogosWidget.alertPersonalizableSiNo(context,
          title: "Finalizar Operativo",
          widget: wg,
          onPress: (){

            Navigator.of(context).pop();
            _FinalizarRecintoElectoral(usuario: _UserProvider.getUser.idGenUsuario,idDgoCreaOpReci: _RecintoProvider.getRecintoAbierto.idDgoCreaOpReci);
          });*/
    } catch (e) {
      print("un error ${e.toString()}");
      setState(() {
        peticionServer = false;

      });
    }
  }

   Future<void> _consultaRecintoAbierto(String idGenPersona,String tipo,String texto,ResponsiveUtil responsive) async {
    try {
      if (peticionServer) return;
      setState(() {
        peticionServer = true;
      });
      RecintosElectoralesAbiertos _RecintosElectoralesAbiertos =
          await _recintosElectoralesApi
          .verificarPersonalEncargadoAsignadoRecElectPorIdGenPersona(
          context: context, idGenPersona: idGenPersona);

      if (_RecintosElectoralesAbiertos.idDgoCreaOpReci == "0") {
        //NOS DIRIGUIMOS AL MENU DE SELECCIONAR OPERATIVO
        setState(() {
          print(estadoRecinto);
          String msjMostrar='El Proceso Electoral ha Finalizado.\n\nUsted ya no puede '+texto,titleMostrar='Procesos Electorales';
          DialogosWidget.alert(context,
              title: titleMostrar,
              message: msjMostrar,
          onTap: _cerrarSession);
//
        });
        peticionServer = false;

      } else {
        //Existe un Operativo Abierto
        setState(() {
          print(estadoRecinto);
          if (tipo=='novedades'){
            print('TIPO-------'+tipo);
           Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => VerificarGpsPage(
                        pantalla: registrarNovedadesPage())));
          }
          if (tipo=='personal'){
            print('TIPO-------'+tipo);
            Navigator.pushNamed(
                context, AppConfig.pantallaRecElecAddPersonal);
          }
          if (tipo=='eliminar'){
            print('TIPO-------'+tipo);
            DialogosWidget.alertSiNo(context,
                title: VariablesUtil.EliminarOperativo,
                message:
                "Si abrió por error el Operativo se recomienda eliminarlo.  "
                    "\n\nRecuerde todo será registrado para verificar el correcto uso del aplicativo."
                    "\n\n¿Esta seguro que desea eliminar el Operativo.?",
                onTap: () {
                  Navigator.of(context).pop();
                  _EliminarRecintoElectoral(
                      usuario: _UserProvider.getUser.idGenUsuario,
                      idDgoCreaOpReci:
                      _RecintoProvider.getRecintoAbierto.idDgoCreaOpReci);
                });
          }
         if (tipo=='finalizar'){
            print('TIPO-------'+tipo);
            print("ahora dibujp consulta");
            Widget wg=Column(
              children: [
                Container(
                  width: responsive.anchoP(70),
                  child: TituloTextWidget(
                    textAlign: TextAlign.center,
                    title:
                    _RecintoProvider.getRecintoAbierto.nomRecintoElec,
                  ),
                ),
                TituloDetalleTextWidget(
                  title: "Total Personal",
                  detalle: totalPersonal,
                  mostrarBorder: true,
                ),
                TituloDetalleTextWidget(
                  title: "Total Novedades",
                  detalle: totalNovedades,
                  mostrarBorder: true,
                ),
                DialogosWidget.getDialogoMsj(
                    "¿Esta seguro que desea finalizar el Operativo.?")
              ],
            );


            DialogosWidget.alertPersonalizableSiNo(context,
                title: "Finalizar Operativo",
                widget: wg,
                onPress: (){

                  Navigator.of(context).pop();
                  _FinalizarRecintoElectoral(usuario: _UserProvider.getUser.idGenUsuario,idDgoCreaOpReci: _RecintoProvider.getRecintoAbierto.idDgoCreaOpReci);
                });
          }
          if (tipo=='abandonar'){
            print('TIPO-------'+tipo);
            DialogosWidget.alertSiNo(context,
                title: "Abandonar Operativo",
                message:
                "¿Esta seguro que desea abandonar el Operativo.?",
                onTap: () {
                  Navigator.of(context).pop();
                  _AbandonarRecintoElectoral(
                      usuario: _UserProvider.getUser.idGenUsuario,
                      idDgoPerAsigOpe:
                      _RecintoProvider.getRecintoAbierto.idDgoPerAsigOpe);
                });

          }
          peticionServer = false;

        });
      }
    } catch (e) {}
  }

}
