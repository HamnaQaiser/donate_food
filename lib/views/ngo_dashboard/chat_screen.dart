import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../utility/constants.dart';

class ChatScreen extends StatefulWidget {
  final String senderId;
  final String receiverId;
  final String Name;
  ChatScreen({
    required this.senderId,
    required this.receiverId,
    required this.Name,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late CollectionReference<Map<String, dynamic>> messagesCollection;
  TextEditingController _messageController = TextEditingController();
  late Stream<QuerySnapshot<Map<String, dynamic>>> _messagesStream;

  @override
  void initState() {
    super.initState();

    String chatId = createChatId(widget.senderId, widget.receiverId);
    messagesCollection =
        FirebaseFirestore.instance.collection('messages_$chatId');

    _messagesStream = messagesCollection
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  String createChatId(String senderId, String receiverId) {
    List<String> ids = [senderId, receiverId];
    ids.sort();
    return ids.join('_');
  }

  void _sendMessage() {
    String message = _messageController.text.trim();
    if (message.isNotEmpty) {
      messagesCollection.add({
        'message': _messageController.text.toString(),
        'senderId': widget.senderId,
        'receiverId': widget.receiverId,
        'timestamp': FieldValue.serverTimestamp(),
      });
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.Name}', style: TextStyle(color: Colors.white)),
        backgroundColor: mainColor,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: _messagesStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (!snapshot.hasData ||
                    snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Text('No messages yet.'),
                  );
                }

                List<DocumentSnapshot<Map<String, dynamic>>> messages =
                    snapshot.data!.docs;

                return ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    var message = messages[index].data();
                    bool isSentBySender =
                        message!['senderId'] == widget.senderId;

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      child: Container(
                        color:
                        isSentBySender ? mainColor : textColor,
                          child:  ListTile(
                            title: Text(message!['message'],
                              textAlign:
                              isSentBySender ? TextAlign.end : TextAlign.start,
                               style: TextStyle(
                                 color: isSentBySender ? Colors.white : Colors.white,
                                 fontWeight: FontWeight.bold,
                               ),
                            ),
                            subtitle: Text(
                              isSentBySender ? 'You' : widget.Name,
                              textAlign:
                              isSentBySender ? TextAlign.end : TextAlign.start,
                              style: TextStyle(
                                color: isSentBySender ? Colors.white : Colors.black,
                              ),

                            ),
                          ),
                        ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: mainColor),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
