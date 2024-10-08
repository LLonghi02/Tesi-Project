/*import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:groq/groq.dart';
import 'package:tuple/tuple.dart';

class GroqExample extends ConsumerStatefulWidget {
  const GroqExample({Key? key}) : super(key: key);

  @override
  ConsumerState<GroqExample> createState() => _ChatGptExampleState();
}

class _ChatGptExampleState extends ConsumerState<GroqExample> {
  static const _apiKey =
      String.fromEnvironment('GROQ_API_KEY', defaultValue: '');
  final groq = Groq(_apiKey, model: GroqModel.llama38b8192);
  var _groqModel = GroqModel.llama38b8192;

  final _textController = TextEditingController();
  final _scrollController = ScrollController();
  bool _pendingResponse = false;
  final _messages = <Tuple2<String, bool>>[];

  @override
  void initState() {
    super.initState();
    groq.startChat();
  }

  void _changeModel(GroqModel? m) {
    if (m != null) {
      _groqModel = m;
      _messages.clear();
      groq.clearChat();
      groq.startChat();
      setState(() {});
    }
  }

  Future<String> _askChatGpt(String prompt) async {
    try {
      final response = await groq.sendMessage(prompt);
      return response.choices.firstOrNull?.message.content ?? "<error>";
    } catch (e) {
      return e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          child: ListView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.all(8.0),
            reverse: true,
            itemBuilder: (_, i) => MyMessageBubbleTile(
                message: _messages[i].item1, isMe: _messages[i].item2),
            itemCount: _messages.length,
          ),
        ),
        if (_pendingResponse)
          ListTile(
            leading: CircleAvatar(
                backgroundColor: Colors.blue,
                child: Icon(Icons.android)), // Replace with any desired icon from Icons class
            title: LinearProgressIndicator(),
          ),
        Divider(height: 1.0),
        MyValuePickerTile<GroqModel>(
            val: _groqModel,
            values: GroqModel.values,
            title: 'Select a model: ',
            onChanged: _changeModel),
        Divider(),
        _buildTextComposer(),
        Divider(height: 1.0),
        MyAiChatQuotaBar(),
      ],
    );
  }

  Future<void> _handleSubmitted(String text) async {
    _textController.clear();
    setState(() {
      _messages.insert(0, Tuple2(text, true));
      _pendingResponse = true;
    });
    final resp = await _askChatGpt(text);
    setState(() {
      _pendingResponse = false;
      _messages.insert(0, Tuple2(resp, false));
    });
  }

  Widget _buildTextComposer() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Flexible(
            child: TextField(
              enabled: !_pendingResponse,
              controller: _textController,
              maxLines: null,
              maxLength: 200,
              onSubmitted: _handleSubmitted,
              decoration: InputDecoration.collapsed(
                hintText: 'Send a message',
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            child: IconButton(
              icon: Icon(Icons.send),
              onPressed: () => _handleSubmitted(_textController.text),
            ),
          ),
        ],
      ),
    );
  }
}

/// A bar showing how many turns left, and a btn to get more quota.
class MyAiChatQuotaBar extends ConsumerWidget {
  const MyAiChatQuotaBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Free turns left'), // Esempio generico

        TextButton.icon(
          label: Text('More quota'),
          icon: Icon(Icons.emoji_events),
          onPressed: () =>
              Navigator.of(context).pushNamed('/monetization_rewarded_ad_ex'),
        ),
      ],
    );
  }
}

class MyMessageBubbleTile extends StatelessWidget {
  const MyMessageBubbleTile({
    Key? key,
    required this.message,
    required this.isMe,
  }) : super(key: key);

  final String message;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    final avatar = isMe
        ? CircleAvatar(
            backgroundColor: Colors.blueGrey,
            child: Text('Me'),
          )
        : CircleAvatar(
            backgroundColor: Colors.blue,
            child: Icon(Icons.android), // Replace with any desired icon from Icons class
          );

    final msgBubble = Align(
        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          margin: isMe
              ? EdgeInsets.only(top: 8.0, bottom: 8.0, left: 80.0)
              : EdgeInsets.only(top: 8.0, bottom: 8.0, right: 80),
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: isMe ? Colors.grey[300] : Colors.blue[100],
            borderRadius: isMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    bottomLeft: Radius.circular(15.0),
                    bottomRight: Radius.circular(15.0),
                  )
                : BorderRadius.only(
                    topRight: Radius.circular(15.0),
                    bottomLeft: Radius.circular(15.0),
                    bottomRight: Radius.circular(15.0),
                  ),
          ),
          child: MarkdownBody(data: message, selectable: true),
        ));
    return ListTile(
      leading: isMe ? null : avatar,
      trailing: isMe ? avatar : null,
      title: msgBubble,
    );
  }
}

class MyValuePickerTile<T> extends StatelessWidget {
  const MyValuePickerTile({
    Key? key,
    required this.val,
    required this.values,
    required this.title,
    required this.onChanged,
  }) : super(key: key);

  final T val;
  final List<T> values;
  final String title;
  final void Function(T?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(title),
        trailing: DropdownButton<T>(
          value: val,
          onChanged: onChanged,
          items: values.map<DropdownMenuItem<T>>((T value) {
            return DropdownMenuItem<T>(
              value: value,
              child: Text(value.toString()),
            );
          }).toList(),
        ),
      ),
    );
  }
}
*/