import 'package:flutter/material.dart';

class LoginButtonColored extends StatelessWidget {
  final IconData ?icon ;
  final String ?name ;
  final Color ?c ;
  final Type role;
  const LoginButtonColored({Key? key,required this.name,required this.icon,required this.c,required this.role}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(right:32,top: 10,left:32,bottom: 10),
      child: TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(c!),
            fixedSize: MaterialStateProperty.all(const Size(322, 62))
          ),
          onPressed: () { role; },
        child: Row(
          mainAxisAlignment : MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(
                icon,
                color: Colors.white,
                size: 30,
              ),
            ),
            Text(
              name!,
              style: const TextStyle(
                color:Colors.white,
                fontSize: 17
              ),

            )

          ]
        )

      ),
    );
  }

}
