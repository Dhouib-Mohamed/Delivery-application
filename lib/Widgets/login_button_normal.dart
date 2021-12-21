import 'package:flutter/material.dart';

class LoginButtonNormal extends StatelessWidget {
  final String ?name ;
  final Type role;
  const LoginButtonNormal({Key? key,required this.name,required this.role}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(right:32,top: 10,left:32,bottom: 10),
      child: OutlinedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              fixedSize: MaterialStateProperty.all(const Size(322, 62)),
            shape: MaterialStateProperty.all(const RoundedRectangleBorder(side: BorderSide(
    color: Color(0xff8E8E93),
    width: 10,
    )))
          ),
          onPressed: () { role; },
          child: Text(
                  name!,
                  style: const TextStyle(
                      color: Color(0xff8E8E93),
                      fontSize: 17
                  ),

                )


          ),
    );
  }

}
