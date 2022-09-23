import 'package:fkbn_flutter/utils/style.dart';
import 'package:flutter/cupertino.dart';

class PageTwo extends StatelessWidget {
  const PageTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenHeigh = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          Image.asset("assets/images/morningrun.png"),
          SizedBox(height: screenHeigh * 0.032),
          Text(
            "Lihat berita terbaru FKBN",
            style: TextStyle(fontSize: screenWidth * 0.05, color: whiteColor),
          ),
          SizedBox(height: screenHeigh * 0.032),
          Text(
            "Dengan Fansnya FKBN, berita maupun dokumentasi kagiatan terbaru FKBN didapatkan dengan mudah dan lengkap!",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: screenWidth * 0.035, color: whiteColor),
          ),
        ],
      ),
    );
  }
}
