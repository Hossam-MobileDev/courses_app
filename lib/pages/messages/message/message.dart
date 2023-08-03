import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/common/values/colors.dart';
import 'package:ulearning_app/common/widgets/base_text_widget.dart';
import 'package:ulearning_app/pages/messages/message/cubit/message_cubits.dart';
import 'package:ulearning_app/pages/messages/message/cubit/message_states.dart';
import 'package:ulearning_app/pages/messages/message/widgets/message_widgets.dart';

import 'message_controller.dart';

class Messages extends StatefulWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  late MessagesController _messagesController;

  @override
  void didChangeDependencies() {
    _messagesController = MessagesController(context: context);
    _messagesController.init();
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: BlocBuilder<MessageCubits, MessageStates>(builder: (context, state) {

          return Scaffold(
            backgroundColor: Colors.white,
            appBar: buildAppBar("Messages"),
            body: state.loadStatus == true
                ? const Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryElement,
              ),
            )
                : CustomScrollView(
              slivers: [
                SliverPadding(
                  padding:
                  EdgeInsets.symmetric(horizontal: 25.w, vertical: 0.h),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                            (context, index){
                          var item = state.message.elementAt(index);
                          print(item.token);
                          return buildChatList(context, item, _messagesController);
                        },
                        childCount: state.message.length
                    ),
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
