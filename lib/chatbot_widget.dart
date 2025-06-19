import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatbotWidget extends StatefulWidget {
  final String? userName;
  final Color primaryColor;
  final Color secondaryColor;
  final String botName;
  final String botAvatar;
  final String systemPrompt;

  const ChatbotWidget({
    super.key,
    this.userName,
    this.primaryColor = Colors.blueAccent,
    this.secondaryColor = Colors.white,
    this.botName = 'Anany+',
    this.botAvatar = 'A+',
    this.systemPrompt = """You are Anany+, a smart, friendly, and knowledgeable AI chatbot developed by RI Medicare.

Your primary goal is to assist users with:

1. General medical queries:
   - Basic symptoms and first-aid suggestions
   - Preventive healthcare tips
   - Common illness-related guidance (e.g., cold, fever, blood pressure, diabetes)
   - Information on lab tests, diagnostics, health reports, and medicines
   - When appropriate, recommend that the user consult a human doctor or healthcare provider for serious or unclear symptoms

2. RI Medicare services:
   - Guide users to book services through the RI Medicare app or website
   - Provide information about available health checkups and tests
   - Help with accessing test reports and medical records
   - Explain service procedures and requirements

3. User experience guidelines:
   - Maintain a polite, respectful, and calm tone
   - Be concise but allow detail if requested
   - For non-medical queries, respond: "I'm designed to help you with health-related queries and RI Medicare services. Could you please ask something related to that?"
   - Focus on being helpful and informative, avoid jokes or general chit-chat

4. Safety and accuracy:
   - Do not diagnose or prescribe treatment
   - Always clarify that you are an AI assistant, not a medical professional
   - For serious symptoms, respond: "Please consult a certified medical professional or visit your nearest hospital. I can only provide general guidance."

5. Company Information:
   - RI Medicare is a product of Rishishwar Industry Private Limited
   - MD: Mr. Harsh Raj Sharma
   - Director: Mr. Dinesh Kumar Sharma
   - Registered Office: 162, Mahadaji Nagar, Shivpuri Link Road, Lashkar, Gird, Gwalior, Madhya Pradesh – 474001, India

Begin every interaction by politely offering help, like: "Hello! I'm Anany+, your virtual healthcare assistant from RI Medicare. How can I help you today?"

If the user repeats a request or seems confused, respond with patience and reassurance.

Remember to:
- Keep responses clear, natural, and accurate
- Focus on being helpful and informative
- Maintain a professional yet friendly tone
- Always prioritize user safety and well-being""",
  });

  @override
  State<ChatbotWidget> createState() => _ChatbotWidgetState();
}

class _ChatbotWidgetState extends State<ChatbotWidget> {
  final List<Map<String, String>> _messages = [];
  final TextEditingController _textController = TextEditingController();
  late final String _geminiApiKey;
  final String _baseUrl = 'http://192.168.29.62:5000';
  bool _isLoading = false;
  bool _isTyping = false;
  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    _initializePrefs();
    _geminiApiKey = dotenv.env['GEMINI_API_KEY'] ?? '';
    _addWelcomeMessage();
  }

  Future<void> _initializePrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  void _addWelcomeMessage() {
    final userName = widget.userName ?? 'there';
    _messages.add({
      'sender': 'bot',
      'text': "Hi $userName, I'm ${widget.botName}, your Medicare assistant. How can I help you today?"
    });
  }

  Future<void> _sendMessage(String text) async {
    if (text.isEmpty) return;

    setState(() {
      _messages.add({'sender': 'user', 'text': text});
      _isLoading = true;
      _isTyping = true;
    });
    _textController.clear();

    // Save message to history
    await _saveMessageToHistory(text, 'user');

    try {
      final response = await http.post(
        Uri.parse(
            'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=$_geminiApiKey'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          "contents": [
            {
              "role": "user",
              "parts": [
                {"text": text}
              ]
            },
            {
              "role": "model",
              "parts": [
                {"text": widget.systemPrompt}
              ]
            }
          ]
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        String botReply = "Sorry, I couldn't get a response. Please try again.";
        if (data['candidates'] != null && data['candidates'].isNotEmpty) {
          botReply = data['candidates'][0]['content']['parts'][0]['text'];
        }
        
        // Add artificial delay for more natural conversation
        await Future.delayed(const Duration(seconds: 1));
        
        setState(() {
          _messages.add({'sender': 'bot', 'text': botReply});
          _isTyping = false;
        });
        
        // Save bot response to history
        await _saveMessageToHistory(botReply, 'bot');
      } else {
        print('Gemini API error: ${response.statusCode} - ${response.reasonPhrase}');
        setState(() {
          _messages.add({
            'sender': 'bot',
            'text': 'Sorry, I encountered an error. Please try again. (Error: ${response.statusCode})'
          });
          _isTyping = false;
        });
      }
    } catch (e) {
      print('Exception occurred: $e');
      setState(() {
        _messages.add({
          'sender': 'bot',
          'text': 'Sorry, I encountered an error. Please try again.'
        });
        _isTyping = false;
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _saveMessageToHistory(String message, String sender) async {
    final history = _prefs.getStringList('chat_history') ?? [];
    history.add(json.encode({
      'message': message,
      'sender': sender,
      'timestamp': DateTime.now().toIso8601String(),
    }));
    await _prefs.setStringList('chat_history', history);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.botName} Chat'),
        backgroundColor: widget.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              widget.primaryColor.withOpacity(0.1),
              widget.secondaryColor,
            ],
          ),
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(8.0),
                reverse: true,
                itemCount: _messages.length,
                itemBuilder: (_, int index) {
                  final message = _messages[_messages.length - 1 - index];
                  return _buildMessage(message['text']!, message['sender']!);
                },
              ),
            ),
            if (_isTyping)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const CircleAvatar(child: Text('A+')),
                    const SizedBox(width: 8),
                    Text(
                      '${widget.botName} is typing...',
                      style: TextStyle(
                        color: widget.primaryColor,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            const Divider(height: 1.0),
            _buildTextComposer(),
          ],
        ),
      ),
    );
  }

  Widget _buildMessage(String text, String sender) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment:
            sender == 'user' ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: <Widget>[
          if (sender == 'bot')
            CircleAvatar(
              backgroundColor: widget.primaryColor,
              child: Text(
                widget.botAvatar,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Material(
                  borderRadius: BorderRadius.circular(20.0),
                  elevation: 5.0,
                  color: sender == 'user' ? widget.primaryColor : widget.secondaryColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 15.0),
                    child: Text(
                      text,
                      style: TextStyle(
                        color: sender == 'user' ? Colors.white : Colors.black87,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (sender == 'user')
            CircleAvatar(
              backgroundColor: widget.primaryColor.withOpacity(0.5),
              child: const Icon(Icons.person, color: Colors.white),
            ),
        ],
      ),
    );
  }

  Widget _buildTextComposer() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Flexible(
            child: TextField(
              controller: _textController,
              onSubmitted: _sendMessage,
              decoration: InputDecoration(
                hintText: 'Type your message...',
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                hintStyle: TextStyle(color: Colors.grey[400]),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            child: IconButton(
              icon: Icon(Icons.send, color: widget.primaryColor),
              onPressed: () => _sendMessage(_textController.text),
            ),
          ),
        ],
      ),
    );
  }
} 