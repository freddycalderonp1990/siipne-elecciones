
part of 'customWidgets.dart';

class CircleWidget extends StatelessWidget{
  
  final double radio;
  final List<Color> ColoresUtil;

  const CircleWidget({Key key, this.radio, this.ColoresUtil}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: radio*2,
      height: radio*2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(this.radio),
        gradient: LinearGradient(
          colors: this.ColoresUtil,
              begin: Alignment.topRight,
            end: Alignment.bottomRight
        )
      ),
    );
  }

}