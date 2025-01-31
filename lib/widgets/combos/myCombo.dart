import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:siipnemovil2/config/appConfig.dart';
import 'package:siipnemovil2/config/app_colors.dart';
import 'package:siipnemovil2/utils/utils.dart';
import 'package:siipnemovil2/widgets/customWidgets.dart';

class ComboConBusqueda extends StatefulWidget {
  final String title;
  final List<String> datos;
  final ValueChanged<String> complete;
  final String selectValue;

  final String searchHint;

  const ComboConBusqueda({
    Key key,
    @required this.datos,
    @required this.complete,
    this.title = '',
    this.searchHint = 'Seleccione...', this.selectValue,
  }) : super(key: key);

  @override
  _ComboConBusquedaState createState() => _ComboConBusquedaState();
}

class _ComboConBusquedaState extends State<ComboConBusqueda> {
  TextEditingController _controller = TextEditingController();
  List<String> _filteredItems = [];
  String _selectedItem;

  @override
  void initState() {
    super.initState();
    _filteredItems = widget.datos;
  }

  void _filterItems(String query) {
    setState(() {
      _filteredItems = widget.datos
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _showDropdownDialog() {
    final responsibe = ResponsiveUtil(context);

    _controller.clear();
    _filteredItems=widget.datos;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {


            return AlertDialog(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Text(widget.title, overflow: TextOverflow.ellipsis)),
                  IconButton(
                    icon: Icon(Icons.close, color: Colors.red),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _controller,
                      onChanged: (query) {
                        setStateDialog(() {
                          _filteredItems = widget.datos
                              .where((item) => item.toLowerCase().contains(query.toLowerCase()))
                              .toList();
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Buscar...',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: responsibe.altoP(50),
                      width: responsibe.anchoP(90),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: _filteredItems.length,
                        itemBuilder: (context, index) {
                          return Column(children: [

                            ListTile(
                              title: Text(_filteredItems[index],),
                              selected: _filteredItems[index] == _selectedItem,
                              selectedTileColor:AppColors.colorAzul_1,
                              selectedColor:Colors.white ,
                              onTap: () {
                                setState(() {
                                  _selectedItem = _filteredItems[index];
                                  _controller.text = _selectedItem; // Mantener seleccionado
                                });

                                Navigator.pop(context);
                                widget.complete(_filteredItems[index]);

                              },
                            ),
                            Container(height: 0.5,color: AppColors.colorAzul_1,)
                          ],);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    
    
    return GestureDetector(
      onTap: _showDropdownDialog,
      child: desing(Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        decoration: BoxDecoration(
          color: Colors.white,

        ),
        child: Row(

          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          Flexible(child:   Text(
            widget.selectValue!=null?widget.selectValue: _selectedItem ?? widget.searchHint,
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),),
            Icon(Icons.arrow_drop_down, color: Colors.black),
          ],
        ),
      )),
    );
  }
  
  Widget desing (Widget _widget){
    final responsive = ResponsiveUtil(context);
    return Container(
      margin: EdgeInsets.all(
       5
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
            widget.datos.length>0? Flexible(
                child:_widget
                    

            ):Container()
          ],
        ),
      ),
    );
  }
}
