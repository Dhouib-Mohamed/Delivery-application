import 'package:flutter/material.dart';

class ColoredButton extends StatelessWidget {
  final Widget? icon;
  final String name;
  final double? width;
  final Color? color;
  final Color? textColor;
  final void Function() role;
  const ColoredButton(
      {Key? key,
      required this.name,
      this.icon,
      this.color,
      required this.role, this.width, this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 32, top: 6, left: 32, bottom: 13),
      child: OutlinedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(color??const Color(0xffbd2005)),
              fixedSize: MaterialStateProperty.all(Size(width??330, 48)),
              shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ))),
          onPressed: role,
          child:
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: icon ?? const SizedBox(),
            ),
            Text(
              name,
              style: TextStyle(color: textColor??Colors.white, fontSize: 17),
            )
          ]),
    ));
  }
}

class ProfileButton extends StatelessWidget {
  final Widget? icon;
  final String name;
  final double? width;
  final Color? color;
  final Color? textColor;
  final void Function() role;
  const ProfileButton(
      {Key? key,
        required this.name,
        this.icon,
        this.color,
        required this.role, this.width, this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
          style: ButtonStyle(
            side: MaterialStateProperty.all(const BorderSide(color: Colors.blueGrey,width: 0.3)),
              backgroundColor: MaterialStateProperty.all<Color>(color??Colors.white),
              fixedSize: MaterialStateProperty.all(Size(width??200, 60)),
          shape: MaterialStateProperty.all(const ContinuousRectangleBorder())),
          onPressed: role,
          child:
          Padding(
            padding: const EdgeInsets.only(left:30),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: icon ?? const SizedBox(),
                  ),
                  Text(
                    name,
                    style: TextStyle(color: textColor??Colors.black, fontSize: 17),
                  )
                ]),

        ));
  }
}

class Input extends StatelessWidget {
  final String field;
  final TextEditingController? control;
  final String? Function(String?)? valid;
  const Input({
    Key? key,
    required this.field,
    this.control,
    this.valid,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 32, top: 6, left: 32, bottom: 18),
      child: TextFormField(
        controller: control,
        keyboardType: field == 'Name'
            ? TextInputType.name
            : field == 'Email'
                ? TextInputType.emailAddress
                : field == 'Password'
                    ? TextInputType.visiblePassword
                    : field == 'Phone Number'
                        ? TextInputType.phone
                        : TextInputType.text,
        obscureText: field == 'Password',
        strutStyle: const StrutStyle(forceStrutHeight: true, height: 1),
        decoration: InputDecoration(
            border: const OutlineInputBorder(
              borderSide: BorderSide(),
              borderRadius: BorderRadius.all(Radius.circular(10)),
              gapPadding: 4.0,
            ),
            labelText: field),
        validator: valid,
        onSaved: (value) {
          control?.text = value!;
        },
      ),
    );
  }
}

class TappedText extends StatelessWidget {
  final String text;
  final Color? c;
  final String tapped;
  final String role;
  const TappedText(
      {Key? key,
      this.c,
      required this.text,
      required this.tapped,
      required this.role})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 35, bottom: 20),
      child: Row(children: [
        Text(
          text,
          style: const TextStyle(
            fontFamily: "Inter",
            fontSize: 13,
            color: Colors.black,
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, role);
          },
          child: Text(
            tapped,
            style: TextStyle(
              fontFamily: "Inter",
              color: (c == null) ? const Color(0xffbd2005) : c,
              fontSize: 13,
            ),
          ),
        )
      ]),
    );
  }
}

class TappedPosition extends StatelessWidget {
  final String text;
  final Color? c;
  final String tapped;
  final String role;
  const TappedPosition(
      {Key? key,
      this.c,
      required this.text,
      required this.tapped,
      required this.role})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 15,right: 1),
      child: SizedBox(
        width: 328,
        height: 24,
        child: Row(children: [
          Text(
            text,
            style: const TextStyle(
              fontFamily: "Inter",
              fontSize: 13,
              color: Colors.black,
            ),
          ),
          Flexible(
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, role);
              },
              child: Text(
                tapped,
                overflow:TextOverflow.fade,
                softWrap: false,
                maxLines: 2,
                style: TextStyle(
                  fontFamily: "Inter",
                  color: (c == null) ? const Color(0xffbd2005) : c,
                  fontSize: 17,
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}

class TappedBox extends StatefulWidget {
  final String text;
  bool val = true;
  TappedBox({Key? key, required this.text}) : super(key: key);

  @override
  State<TappedBox> createState() => _TappedBoxState();
}

class _TappedBoxState extends State<TappedBox> {
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 0, bottom: 15, right: 0),
      child: Row(
        children: [
          Checkbox(
            activeColor: const Color(0xffbd2005),
            onChanged: (bool? value) {
              setState(() {
                widget.val = value!;
              });
            },
            value: widget.val,
          ),
          Text(
            widget.text,
            style: const TextStyle(color: Color(0xffbd2005)),
          ),
        ],
      ),
    );
  }
}

class SimpleButton extends StatelessWidget {
  final void Function()? buttonRole;

  final String buttonText;

  const SimpleButton(
      {Key? key, required this.buttonRole, required this.buttonText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            fixedSize: MaterialStateProperty.all(const Size(145, 40)),
            shape: MaterialStateProperty.all(const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ))),
        onPressed: () {
          if (buttonRole != null) buttonRole!();
        },
        child: Text(
          buttonText,
          style: const TextStyle(color: Colors.black, fontSize: 14),
        ));
  }
}
