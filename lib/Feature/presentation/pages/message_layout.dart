import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';

class MessageLayout extends StatelessWidget {
  final String uid;
  final String type;
  final text;
  final time;
  final color;
  final align;
  final boxAlignment;
  final nip;
  final senderName;
  final senderId;
  final boxMainAxisAlignment;

  const MessageLayout({
    Key? key,
    required this.uid,
    required this.type,
    this.text,
    this.time,
    this.color,
    this.align,
    this.boxAlignment,
    this.nip,
    this.senderName,
    this.senderId,
    this.boxMainAxisAlignment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: boxAlignment,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: boxMainAxisAlignment,
          children: [
            color == Colors.yellow
                ? Container(
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 2),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(55))),
                    child: Image.asset("assets/images/profile_default.png"),
                  )
                : const Text(
                    "",
                    style: TextStyle(fontSize: 0),
                  ),
            Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.all(3),
              child: Bubble(
                color: color,
                nip: nip,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    color == const Color(0xFF15B4AF)
                        ? Text(
                            "Me",
                            textAlign: align,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          )
                        : Text(
                            senderName,
                            textAlign: align,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 250),
                      child: Text(
                        text == "" ? "" : text,
                        textAlign: align,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                    Text(
                      time,
                      textAlign: align,
                      style: const TextStyle(fontSize: 14),
                    )
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
