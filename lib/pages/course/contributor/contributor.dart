import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/common/values/colors.dart';
import 'package:ulearning_app/common/widgets/base_text_widget.dart';
import 'package:ulearning_app/pages/course/contributor/contributor_controller.dart';
import 'package:ulearning_app/pages/course/contributor/cubit/contributor_cubits.dart';
import 'package:ulearning_app/pages/course/contributor/cubit/contributor_states.dart';
import 'package:ulearning_app/pages/course/contributor/widgets/contributor_widgets.dart';

class Contributor extends StatefulWidget {
  const Contributor({Key? key}) : super(key: key);

  @override
  State<Contributor> createState() => _ContributorState();
}

class _ContributorState extends State<Contributor> {
  late ContributorController _contributorController;

  @override
  void didChangeDependencies() {
    _contributorController = ContributorController(context: context);
    _contributorController.init();
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContributorCubits, ContributorStates>(
        builder: (context, state) {
      return Scaffold(
        appBar: buildAppBar("Contributor"),
        body: Container(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //This container contains background image and profile photo
                Container(
                  width: 325.w,
                  height: 220.h,
                  child: Stack(
                    children: [
                      //author page background
                      backgroundImage(),
                      //author page profile photo and bio
                      if(state.authorItem !=null)
                        Positioned(
                            left: 0, bottom: 0, child: authorView(context, state))
                      else
                        Container(),

                    ],
                  ),
                ),
                SizedBox(height: 30.h,),
                //about me and description
                authorsDescription(state),
                //chat button using reusbale components
                SizedBox(height: 20.h,),
                GestureDetector(
                    onTap: (){
                      if(state.authorItem !=null){
                        _contributorController.goChat(state.authorItem!);
                        print('getting to the page');
                      }
                    },
                    child: appPrimaryButton("Go chat")

                ),
                SizedBox(height: 30.h,),
                reusableText("Author course list", color: AppColors.primaryText,
                ),
                authorCourseList(state)

              ],
            ),
          ),
        ),
      );
    });
  }


}
