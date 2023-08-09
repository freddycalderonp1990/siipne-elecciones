part of  'miUpcCustomWidgets.dart';

class ImagenesWidget extends StatefulWidget {
  final String imgString;
  final double altoP;
  final double anchoP;
  final bool isImg;

  const ImagenesWidget({Key key, @required this.imgString, this.altoP=8, this.anchoP=8, this.isImg=true}) : super(key: key);

  @override
  _ImagenesWidgetState createState() => _ImagenesWidgetState();
}

class _ImagenesWidgetState extends State<ImagenesWidget> {
  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtil(context);
    return Container(

      width: responsive.altoP(widget.anchoP),
      height: responsive.altoP(widget.altoP),
      child:FadeInImage(
        imageErrorBuilder: (BuildContext context, Object exception, StackTrace stackTrace) {
          print('Error Handler');

          var wgImg=Image.asset('assets/img/img_no_disponible.png');
          if(!widget.isImg){
            wgImg=Image.asset('assets/img/video_no_diponible.png');
          }
          return Container(

            child:wgImg ,
          );
        },
        placeholder: AssetImage("assets/miUpc/img/load.gif"),
        image: getImg(widget.imgString),
        fit: BoxFit.cover,

      ),


    );
  }

  ImageProvider getImg(String imgString) {

    String Img='assets/img/img_no_disponible.png';
    if(!widget.isImg){
      Img='assets/img/video_no_diponible.png';
    }

    ImageProvider img = AssetImage(Img);
    if (imgString != null && imgString.length > 0) {
      imgString = MiUpcUrlApi.pathImagen + imgString;

      try {
        img = NetworkImage(imgString);



        return img;
      }
      catch(e){

        img = AssetImage("assets/img/img_no_disponible.png");
        return img;

      }

    }

    return img;
  }
}
