import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<UserProvider>(context).currentUser;

    // List of chatbot questions and answers
    final chatbotQuestions = [
      'How can I check the availability of train seats?',
      'How do I book a train ticket?',
      'How can I cancel my train ticket?',
      'What are the different payment methods available?'
    ];

    final chatbotAnswers = [
      'You can check the availability of train seats by entering your travel details such as the source and destination stations, travel date, and the class of travel. Once you provide these details, the app will show you the list of available trains along with seat availability for each class.',
      'To book a train ticket, follow these steps:\n1. Open the app and log in to your account.\n2. Enter your journey details including the source, destination, and travel date.\n3. Select the desired train and class.\n4. Choose your seat preferences and enter passenger details.\n5. Proceed to payment and complete the transaction.\n6. You will receive a booking confirmation and e-ticket via email and SMS.',
      'To cancel your train ticket, follow these steps:\n1. Log in to your account on the app.\n2. Go to the \'My Bookings\' section.\n3. Select the ticket you wish to cancel.\n4. Click on the \'Cancel Ticket\' option.\n5. Confirm your cancellation request.\n6. You will receive a cancellation confirmation, and the refund amount will be processed as per the cancellation policy.',
      'The app supports multiple payment methods for your convenience. You can pay using:\n1. Credit or Debit Cards (Visa, MasterCard, Rupay)\n2. Net Banking from various banks\n3. UPI (Unified Payments Interface)\n4. Mobile Wallets (Paytm, PhonePe, etc.)\n5. Cash on Delivery (if available)\nChoose your preferred payment method at the time of checkout to complete your booking.'
    ];

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 6, 74, 164),
      appBar: AppBar(
        title: Text('Welcome'),
        backgroundColor: Color.fromARGB(255, 182, 207, 210),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (currentUser != null) ...[
              Text(
                'Welcome, ${currentUser.name}!',
                style: TextStyle(fontSize: 24),
              ),
              Text('Email: ${currentUser.email}',
                  style: TextStyle(fontSize: 18)),
              Text('Username: ${currentUser.username}',
                  style: TextStyle(fontSize: 18)),
            ] else ...[
              Text('No user is currently signed in.',
                  style: TextStyle(fontSize: 18)),
            ],
            SizedBox(height: 30),
            GestureDetector(
              onTap: () =>
                  _showChatbotDialog(context, chatbotQuestions, chatbotAnswers),
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 40, 140, 4),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blueAccent),
                ),
                child: Text(
                  'Rail Mate',
                  style: TextStyle(
                      fontSize: 18,
                      color: const Color.fromARGB(255, 184, 198, 222)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showChatbotDialog(
      BuildContext context, List<String> questions, List<String> answers) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Chat Bot Questions'),
          backgroundColor: Colors.black,
          content: SingleChildScrollView(
            child: ListBody(
              children: questions.map((question) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    _showAnswerDialog(context, question,
                        answers[questions.indexOf(question)]);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(question,
                        style: TextStyle(fontSize: 16, color: Colors.blue)),
                  ),
                );
              }).toList(),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showAnswerDialog(BuildContext context, String question, String answer) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(question),
          backgroundColor: Colors.black,
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(answer),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
