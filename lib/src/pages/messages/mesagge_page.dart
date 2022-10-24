import 'package:chat_udemy/src/models/message.dart';
import 'package:chat_udemy/src/pages/messages/message_controller.dart';
import 'package:chat_udemy/src/utils/bubble.dart';
import 'package:chat_udemy/src/utils/bubble_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/relative_time_util.dart';

class MessagePage extends StatelessWidget {

  MessageController con = Get.put(MessageController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(245, 246, 248, 1),
      body: Obx( () =>
          Column(
          children: [
            custonAppBar(),
            Expanded(
              flex: 1,
              child: Container(
              margin: EdgeInsets.only(bottom: 30),
              child: ListView(
                reverse: true,
                controller: con.scrollController,
                children: getMessages(),
                ),
              ),
            ),
            messageBox(context),

          ],
        ),
      )
    );
  }

  List<Widget> getMessages() {
    return con.message.map((message)  {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        alignment: message.idSender == con.myUser.id
            ? Alignment.centerRight
            : Alignment.centerLeft,
        child: bublleMessage(message),
        );
     }).toList();
  }

  Widget bublleMessage(Message message){

    if (message.isImage == true){
      return BubbleImage(
        message:  message.message ?? '',
        delivered: true,
        isMe: message.idSender == con.myUser.id ? true :false,
        status: message.status ?? 'ENVIADO',
        isImage: true,
        time: RelativeTimeUtil.getRelativeTime(message.timestamp ?? 0),
        url: message.url ?? 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__480.png',
      );
    }

    return Bubble(
      message: message.message ?? '',
      delivered: true,
      isMe: message.idSender == con.myUser.id ? true :false,
      status: message.status ?? 'ENVIADO',
      time: RelativeTimeUtil.getRelativeTime(message.timestamp ?? 0),
    );
  }

  Widget messageBox(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      color: Colors.white,
      elevation: 15,
      child: Row(
        children: [
          Expanded(
            flex: 1,
              child: IconButton(
            onPressed: () => con.showAlertDialog(context),
            icon: Icon(Icons.image_outlined),
            ),
          ),
          Expanded(
            flex: 1,
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.video_call_rounded),
            ),
          ),
          Expanded(
            flex: 10,
            child: TextField(
              onChanged: (String text) {
                con.emitWriting();
              },
              controller: con.messageController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Esctribe un mensaje...',
                contentPadding: EdgeInsets.symmetric(vertical: 15,horizontal: 15)
              ),
            )
          ),
          Expanded(
            flex: 2,
            child: IconButton(
              onPressed: () => con.sendMessage(),
              icon: Icon(Icons.send),
            ),
          ),
        ],
      ),
    );
  }

  Widget custonAppBar() {
    return  SafeArea(
      child: ListTile(
        title: Text(
          '${con.userChat.name} ${con.userChat.lastname}' ?? '',
          style: TextStyle(
              fontSize: 18,
              color: Colors.grey[700],
              fontWeight: FontWeight.bold
          ),
        ),
        subtitle: con.isWriting.value == true ?
           Text(
             'Escribiendo....',
                style: TextStyle(
                color: Colors.green
          ),
        )
            : Text( con.isOnline.value ==  true
              ?  'En linea'
              :  'Desconectado',
          style: TextStyle(
              color: Colors.grey
          ),
        ) ,
        leading: IconButton(
          onPressed:  () => Get.back(),
          icon: Icon(Icons.arrow_back_ios),
        ),
        trailing:  Container(
          margin: EdgeInsets.symmetric(vertical: 5),
          child: AspectRatio(aspectRatio: 1,
            child: ClipOval(
              child: FadeInImage.assetNetwork(
                  fit: BoxFit.cover,
                  placeholder: 'assets/img/user_profile_2.png',
                  image: con.userChat.image ?? 'https://image.shutterstock.com/image-vector/person-icon-profile-isolated-vector-260nw-684276352.jpg'
              ),
            ),
          ),
        ),
      ),
    );
  }
}
