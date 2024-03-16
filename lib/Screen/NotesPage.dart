import 'package:flutter/material.dart';

import '../Utils/Utils.dart';
import '../Utils/text.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor.withOpacity(0.6),
      appBar: AppBar(
        title: Text('Notes'),
        backgroundColor: Utils().primaryColor,
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              'Your Notes,',
              style: textStyleWhite(FontWeight.w400, 25.0),
            ),
            SizedBox(
              height: 50,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                card('Text ', Colors.white, () {
                  Navigator.pushNamed(context, '/textNotes');
                },Icons.image),
                SizedBox(
                  width: 20,
                ),
                SizedBox(height: 20,),
                card('Video', Colors.white, () {
                  Navigator.pushNamed(context, '/videoNotes');
                },Icons.video_camera_front_outlined),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: card('Audio',Colors.white, () {
                    Navigator.pushNamed(context, '/audioNotes');
                  },Icons.audio_file),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget card(title, color, onTap,iconData) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 100,
        width: 320,
        margin: EdgeInsets.all(5),
        child: Center(
          child:
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(iconData,size: 34,color: Utils().primaryColor,),
              SizedBox(width: 20,),
              Text(
                title,
                style: TextStyle(color: Colors.black,fontSize: 22.0,fontWeight: FontWeight.normal),
              ),
              SizedBox(width: 20,),
              Icon(Icons.arrow_forward_ios,color: Utils().primaryColor,size: 40,),
            ],
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color,
        ),
      ),
    );
  }
}
