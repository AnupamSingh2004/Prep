import 'package:flutter/material.dart';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> with TickerProviderStateMixin {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  List<ChatMessage> messages = [];
  bool _isTyping = false;
  late AnimationController _typingAnimationController;

  @override
  void initState() {
    super.initState();
    _typingAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();
    
    // Add welcome message
    _addBotMessage("Hello! I'm your medical assistant. How can I help you today? 👨‍⚕️");
    _addQuickReplies();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    _typingAnimationController.dispose();
    super.dispose();
  }

  void _addQuickReplies() {
    setState(() {
      messages.add(ChatMessage(
        text: "",
        isUser: false,
        timestamp: DateTime.now(),
        isQuickReplies: true,
        quickReplies: [
          "Find nearby pharmacies",
          "Medicine information",
          "Symptom checker",
          "Emergency contacts",
          "Health tips",
        ],
      ));
    });
  }

  void _addBotMessage(String text) {
    setState(() {
      messages.add(ChatMessage(
        text: text,
        isUser: false,
        timestamp: DateTime.now(),
      ));
    });
    _scrollToBottom();
  }

  void _addUserMessage(String text) {
    setState(() {
      messages.add(ChatMessage(
        text: text,
        isUser: true,
        timestamp: DateTime.now(),
      ));
    });
    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    _addUserMessage(text);
    _messageController.clear();
    
    // Show typing indicator
    setState(() {
      _isTyping = true;
    });

    // Simulate bot response
    Future.delayed(const Duration(milliseconds: 1500), () {
      setState(() {
        _isTyping = false;
      });
      _getBotResponse(text);
    });
  }

  void _handleQuickReply(String reply) {
    _addUserMessage(reply);
    
    setState(() {
      _isTyping = true;
    });

    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        _isTyping = false;
      });
      _getBotResponse(reply);
    });
  }

  void _getBotResponse(String userMessage) {
    String response = "";
    
    final message = userMessage.toLowerCase();
    
    if (message.contains("pharmacy") || message.contains("find nearby")) {
      response = "🏥 I found several pharmacies near you:\n\n1. MedPlus Pharmacy - 0.5 km\n2. Apollo Pharmacy - 1.2 km\n3. Guardian Healthcare - 1.8 km\n\nWould you like directions to any of these?";
    } else if (message.contains("medicine") || message.contains("drug")) {
      response = "💊 I can help you with medicine information. Please tell me:\n\n• Medicine name\n• Dosage information\n• Side effects\n• Drug interactions\n\nWhat would you like to know?";
    } else if (message.contains("symptom") || message.contains("pain") || message.contains("fever")) {
      response = "🩺 I understand you're experiencing symptoms. While I can provide general guidance, please remember:\n\n⚠️ For serious symptoms, consult a doctor immediately\n\nCan you describe your symptoms in more detail?";
    } else if (message.contains("emergency")) {
      response = "🚨 Emergency Contacts:\n\n• Ambulance: 108\n• National Emergency: 112\n• Poison Control: 1066\n\nFor immediate medical emergency, call 108 or visit the nearest hospital.";
    } else if (message.contains("health tips") || message.contains("tips")) {
      response = "💡 Here are some daily health tips:\n\n• Drink 8-10 glasses of water daily\n• Exercise for 30 minutes\n• Eat 5 servings of fruits & vegetables\n• Get 7-8 hours of sleep\n• Practice stress management\n\nWould you like specific tips for any health condition?";
    } else if (message.contains("appointment") || message.contains("doctor")) {
      response = "👨‍⚕️ I can help you find doctors and book appointments:\n\n• Search by specialty\n• View doctor profiles\n• Check availability\n• Book appointments\n\nWhat type of doctor are you looking for?";
    } else {
      response = "I'm here to help with your health-related questions! I can assist with:\n\n• Finding pharmacies & doctors\n• Medicine information\n• Health tips\n• Emergency contacts\n• Symptom guidance\n\nWhat would you like to know more about?";
    }
    
    _addBotMessage(response);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFF1976D2).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: const Color(0xFF1976D2).withValues(alpha: 0.2),
                ),
              ),
              child: const Icon(
                Icons.smart_toy_rounded,
                color: Color(0xFF1976D2),
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Medical Assistant",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    "Online • Ready to help",
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF1976D2),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: IconButton(
              onPressed: () {
                setState(() {
                  messages.clear();
                });
                _addBotMessage("Chat cleared! How can I help you today? 👨‍⚕️");
                _addQuickReplies();
              },
              icon: const Icon(
                Icons.refresh_rounded,
                color: Color(0xFF1976D2),
              ),
              tooltip: "Clear chat",
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Chat Messages
          Expanded(
            child: Container(
              color: const Color(0xFFF8FAFE),
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                itemCount: messages.length + (_isTyping ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == messages.length && _isTyping) {
                    return _buildTypingIndicator();
                  }
                  
                  final message = messages[index];
                  return _buildMessageBubble(message);
                },
              ),
            ),
          ),
          
          // Input Area - Fixed positioning with proper spacing
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SafeArea(
              top: false,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFE),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: const Color(0xFF1976D2).withValues(alpha: 0.2),
                        ),
                      ),
                      child: TextField(
                        controller: _messageController,
                        decoration: const InputDecoration(
                          hintText: "Type your message...",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                        maxLines: null,
                        onSubmitted: (_) => _sendMessage(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1976D2),
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF1976D2).withValues(alpha: 0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: IconButton(
                      onPressed: _sendMessage,
                      icon: const Icon(
                        Icons.send_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    if (message.isQuickReplies) {
      return _buildQuickReplies(message.quickReplies ?? []);
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: message.isUser 
          ? MainAxisAlignment.end 
          : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!message.isUser) ...[
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: const Color(0xFF1976D2).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xFF1976D2).withValues(alpha: 0.2),
                ),
              ),
              child: const Icon(
                Icons.smart_toy_rounded,
                color: Color(0xFF1976D2),
                size: 16,
              ),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.75,
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: message.isUser 
                    ? const Color(0xFF1976D2)
                    : Colors.white,
                  borderRadius: BorderRadius.circular(20).copyWith(
                    bottomLeft: message.isUser ? const Radius.circular(20) : const Radius.circular(4),
                    bottomRight: message.isUser ? const Radius.circular(4) : const Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  message.text,
                  style: TextStyle(
                    color: message.isUser ? Colors.white : Colors.black87,
                    fontSize: 16,
                    height: 1.4,
                  ),
                ),
              ),
            ),
          ),
          if (message.isUser) ...[
            const SizedBox(width: 8),
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                Icons.person,
                color: Colors.grey[600],
                size: 16,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildQuickReplies(List<String> replies) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 40, bottom: 12),
            child: Text(
              "Quick suggestions:",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: replies.map((reply) {
              return GestureDetector(
                onTap: () => _handleQuickReply(reply),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1976D2).withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color(0xFF1976D2).withValues(alpha: 0.2),
                    ),
                  ),
                  child: Text(
                    reply,
                    style: const TextStyle(
                      color: Color(0xFF1976D2),
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: const Color(0xFF1976D2).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color(0xFF1976D2).withValues(alpha: 0.2),
              ),
            ),
            child: const Icon(
              Icons.smart_toy_rounded,
              color: Color(0xFF1976D2),
              size: 16,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20).copyWith(
                bottomLeft: const Radius.circular(4),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedBuilder(
                  animation: _typingAnimationController,
                  builder: (context, child) {
                    return Row(
                      children: List.generate(3, (index) {
                        final delay = index * 0.2;
                        final animationValue = (_typingAnimationController.value - delay).clamp(0.0, 1.0);
                        final opacity = (animationValue * 2).clamp(0.0, 1.0);
                        
                        return Container(
                          margin: const EdgeInsets.only(right: 4),
                          child: Opacity(
                            opacity: opacity > 1 ? 2 - opacity : opacity,
                            child: Container(
                              width: 6,
                              height: 6,
                              decoration: const BoxDecoration(
                                color: Color(0xFF1976D2),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        );
                      }),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;
  final bool isQuickReplies;
  final List<String>? quickReplies;

  ChatMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
    this.isQuickReplies = false,
    this.quickReplies,
  });
}
