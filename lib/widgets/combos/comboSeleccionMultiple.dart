part of 'combosWidget.dart';

class ComboSeleccionMultiple extends StatefulWidget {
  final String title;
  final ValueChanged<List<int>> complete;
  final List<String> datos;
  final String hint;
  final String searchHint;
  final List<int> selectedItems;

  const ComboSeleccionMultiple(
      {Key key,
      this.complete,
      @required this.datos,
      this.title = '',
      this.hint = 'Seleccione...',
      this.searchHint,
      this.selectedItems})
      : super(key: key);

  @override
  _ComboSeleccionMultipleState createState() => _ComboSeleccionMultipleState();
}

class _ComboSeleccionMultipleState extends State<ComboSeleccionMultiple> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtil(context);

    return Container(
      margin: EdgeInsets.only(
        bottom: 5,
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(color: AppConfig.colorBordecajas, blurRadius: 1)
          ]),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.white),
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(right: 5),
              width: responsive.anchoP(35),
              constraints: BoxConstraints(maxWidth: responsive.anchoP(30)),
              child: Text(
                widget.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: responsive.anchoP(AppConfig.tamTextoTitulo),
                  color: Colors.black,
                ),
              ),
            ),
            Expanded(
          /*  child: SearchableDropdown.multiple(

                clearIcon:Icon(Icons.clear,) ,
                iconDisabledColor: AppConfig.colorBordecajas.withOpacity(0.5),
                iconEnabledColor: AppConfig.colorBordecajas,


                displayItem: (item, selected) {
                    return (Row(children: [
                      selected
                          ? Icon(
                        Icons.check,
                        color: AppConfig.colorBordecajas,
                      )
                          : Icon(
                        Icons.check_box_outline_blank,
                        color: Colors.grey,
                      ),
                      SizedBox(width: 7),
                      Expanded(
                        child: item,
                      ),
                    ]));
                  },

                doneButton: (selectedItemsDone, doneContext) {
                  return BtnIconWidget(
                    iconData: Icons.check,

                    onTap: () {
                      Navigator.pop(doneContext);
                      setState(() {});
                    },
                  );

                },
                items: setDatos(widget.datos, responsive),
                selectedItems: widget.selectedItems,
                hint: Text(widget.hint,
                    style: TextStyle(
                      fontSize: responsive.anchoP(AppConfig.tamTextoTitulo),
                      color: Colors.black,
                    )),
                searchHint: SearchHintDesing(valor: widget.searchHint,),
                onChanged: (value) {},
                closeButton: (selectedItems) {

                    widget.complete(selectedItems);


                },
                isExpanded: true,
              ),*/
            )
          ],
        ),
      ),
    );
  }



  List<DropdownMenuItem> setDatos(
      List<String> datos, ResponsiveUtil responsive) {
    List<DropdownMenuItem> items = new List();

    for (int i = 0; i < datos.length; i++) {
      String valor = datos[i];
      items.add(DropdownMenuItem(
          child: DesingDatos(valor: valor,),
        value: valor,
      ));
    }

    return items;
  }
}


