import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../src/constants/breakpoints.dart';
import '../../../../constants/app_constants.dart';

/// First screen that user sees. Allows to continue as guest
/// or login or signup (both via email and password)
class SignInResponsiveLayout extends ConsumerWidget {
  const SignInResponsiveLayout({
    required this.designWidget,
    required this.titleWidget,
    required this.loginWidget,
    super.key,
  });

  final Widget designWidget;
  final Widget titleWidget;
  final Widget loginWidget;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // get screen dimensions
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;

    return Scaffold(
      //backgroundColor: Colors.white,
      body:
          // show narrow design
          screenWidth < Breakpoints.medium
              // check if scrolling is needed
              ? screenHeight > stackedWidgetHeight
                  ? Column(
                      children: [
                        Expanded(child: designWidget),
                        SignInWidgetAndTitle(
                          titleWidget: titleWidget,
                          loginWidget: loginWidget,
                        ),
                      ],
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            constraints: const BoxConstraints(minHeight: designWidgetMinHeight),
                            child: designWidget,
                          ),
                          SignInWidgetAndTitle(
                            titleWidget: titleWidget,
                            loginWidget: loginWidget,
                          ),
                        ],
                      ),
                    )
              :
              // show wide design
              Row(
                  children: [
                    Expanded(child: designWidget),
                    SizedBox(
                      width: maxWidthRightSide,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SignInWidgetAndTitle(
                              titleWidget: titleWidget,
                              loginWidget: loginWidget,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
    );
  }
}

class SignInWidgetAndTitle extends StatelessWidget {
  const SignInWidgetAndTitle({
    required this.titleWidget,
    required this.loginWidget,
    super.key,
  });

  final Widget titleWidget;
  final Widget loginWidget;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: maxWidthSignInWidget,
      child: Column(
        children: [
          SizedBox(
            height: titleHeight,
            child: titleWidget,
          ),
          SizedBox(
            height: signInWidgetHeight,
            child: loginWidget,
          ),
        ],
      ),
    );
  }
}
