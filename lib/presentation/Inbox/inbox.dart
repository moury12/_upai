import 'package:flutter/material.dart';
import 'package:upai/widgets/chat_item_widget.dart';

class InboxScreen extends StatelessWidget {
  const InboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 16,right: 16,top: 10),
                child: TextField(
                  decoration: InputDecoration(
                      fillColor: const Color(0xffF3F3F3),
                      filled: true,
                      hintText: "Search service you're looking for...",
                      hintStyle:
                          TextStyle(fontSize: 14, color: Colors.grey.shade500),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(8))),
                ),
              ),
              const SizedBox(height: 10,),
              Expanded(
                child: ListView.builder(
                  itemCount: 15,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        ChatItemWidget(),
                        Divider(),
                      ],
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
