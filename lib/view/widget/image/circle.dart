import 'package:flutter/material.dart';

//ignore: must_be_immutable
class ImageCircleWidget extends StatefulWidget {
  ImageCircleWidget({super.key,required this.path,this.link});
  String path;
  Widget? link;
  @override
  State<ImageCircleWidget> createState() => _ImageCircleWidgetState();
}

class _ImageCircleWidgetState extends State<ImageCircleWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if(widget.path.isNotEmpty){
          Navigator.pushNamed(context, '/$widget.path');
        }
      },
      child: Container(
        height: 120,
        width: 120,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: Image.asset(
            widget.path,
            fit: BoxFit.cover,
            // loadingBuilder: (BuildContext context, Widget child,
            //     ImageChunkEvent? loadingProgress) {
            //   if (loadingProgress == null) return child;
            //   return Center(
            //     child: CircularProgressIndicator(
            //       value: loadingProgress.expectedTotalBytes != null
            //           ? loadingProgress.cumulativeBytesLoaded /
            //           loadingProgress.expectedTotalBytes!
            //           : null,
            //     ),
            //   );
            // },
          ),
        ),
      ),
    );
  }
}
