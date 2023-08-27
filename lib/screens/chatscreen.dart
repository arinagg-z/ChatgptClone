import 'package:chatgptclone/constants/constants.dart';
import 'package:chatgptclone/models/chat_model.dart';
import 'package:chatgptclone/provider/chatprovider.dart';
import 'package:chatgptclone/provider/model_proivder.dart';
import 'package:chatgptclone/services/assestmanager.dart';
import 'package:chatgptclone/services/services.dart';
import 'package:chatgptclone/widgets/chatwidget.dart';
import 'package:chatgptclone/widgets/textwidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class chatscreen extends StatefulWidget {
  const chatscreen({super.key});

  @override
  State<chatscreen> createState() => _chatscreenState();
}

class _chatscreenState extends State<chatscreen> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  late ScrollController _scrollController;
  @override
  void initState() {
    _scrollController = ScrollController();
    _controller = TextEditingController();
    _focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _focusNode.dispose();
    _controller.dispose(); // TODO: implement dispose
    super.dispose();
  }

  bool istyping = false;
  @override
  Widget build(BuildContext context) {
    final modelproviders = Provider.of<modelprovider>(context);
    final chatproviders = Provider.of<ChatProvider>(context);
    List<chatmodel> chatlist = chatproviders.getchatlist;

    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: cardColor,
        actions: [
          IconButton(
              onPressed: () async {
                await Services.showbottommodalsheet(context);
              },
              icon: Icon(
                Icons.more_vert,
                color: Colors.white,
              ))
        ],
        title: Text(
          "CHATGPT",
          style: TextStyle(color: Colors.white),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(assestmanager.openai),
        ),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Flexible(
              child: ListView.builder(
                  itemCount: chatlist.length,
                  itemBuilder: (context, index) {
                    return chatwidget(
                        msg: chatlist[index].msg,
                        chatindex: chatlist[index].index);
                  })),
          if (istyping) ...[
            SpinKitThreeBounce(
              color: Colors.white,
              size: 18,
            ),
          ],
          SizedBox(
            height: 15,
          ),
          Material(
            color: cardColor,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    focusNode: _focusNode,
                    onSubmitted: (val) async {
                      await sendmesage(modelproviders, chatproviders);
                    },
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                    controller: _controller,
                    decoration: InputDecoration.collapsed(
                      hintText: "How can i help you ?",
                      hintStyle: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.w600),
                    ),
                  )),
                  IconButton(
                      onPressed: () async {
                        await sendmesage(modelproviders, chatproviders);
                      },
                      icon: Icon(Icons.send, color: Colors.white))
                ],
              ),
            ),
          )
        ],
      )),
    );
  }

  // void scrolltoend() {
  //   _scrollController.animateTo(_scrollController.position.maxScrollExtent,
  //       duration: Duration(seconds: 1), curve: Curves.easeInOut);
  // }

  Future<void> sendmesage(
      modelprovider provider, ChatProvider chatProvider) async {
    if (_controller.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: textwidget(
          label: "Please enter the Message",
        ),
        backgroundColor: Colors.teal,
      ));
      return;
    }
    if (istyping) {
      return;
    }
    try {
      String msg = _controller.text;
      setState(() {
        istyping = true;
        chatProvider.addusermessage(msg: msg);
        _controller.clear();
        _focusNode.unfocus();
      });
      await chatProvider.sendmessageandgetanswer(
          msg: msg, modelid: provider.getcurrentModel);
      setState(() {});
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: textwidget(
          label: e.toString(),
        ),
        backgroundColor: Colors.teal,
      ));
    } finally {
      setState(() {
        // scrolltoend();
        istyping = false;
      });
    }
  }
}
