import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../bloc/room_quiz_bloc.dart';
import '../models/quiz_grid_item_model.dart';

class QuizGridItemWidget extends StatefulWidget {
  const QuizGridItemWidget(this.quizGridItemModelObj, this.index, {super.key});

  final QuizGridItemModel quizGridItemModelObj;
  final int index;

  @override
  State<QuizGridItemWidget> createState() => _QuizGridItemWidgetState();
}

class _QuizGridItemWidgetState extends State<QuizGridItemWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 10.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    Future.delayed(const Duration(milliseconds: 50), () {
      if (mounted) {
        _animationController.forward();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoomQuizBloc, RoomQuizState>(
      builder: (context, state) {
        if (state.isLoading) {
          return Container(
            height:
                state.roomQuizModelObj?.quizType?.toUpperCase() == 'TRUE_FALSE'
                    ? 650.h
                    : 320.h,
            decoration: BoxDecoration(
              color: appTheme.whiteA700.withOpacity(0.1),
              borderRadius: BorderRadiusStyle.circleBorder12,
            ),
            child: Center(
              child: CircularProgressIndicator(
                color: appTheme.deppPurplePrimary,
              ),
            ),
          );
        }

        bool isTrueFalse =
            state.roomQuizModelObj?.quizType?.toUpperCase() == 'TRUE_FALSE';

        return SlideTransition(
          position: _slideAnimation,
          child: InkWell(
            onTap: () {
              context
                  .read<RoomQuizBloc>()
                  .add(QuizItemTappedEvent(widget.index));
            },
            child: Container(
              height: isTrueFalse ? 650.h : 320.h,
              width: isTrueFalse ? 170.h : null,
              decoration: BoxDecoration(
                color: widget.quizGridItemModelObj.backgroundColor,
                borderRadius: BorderRadiusStyle.circleBorder12,
                border: widget.quizGridItemModelObj.isSelected
                    ? Border.all(color: Colors.white, width: 3)
                    : null,
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Text(
                    widget.quizGridItemModelObj.textAnswer!,
                    style: CustomTextStyles.titleMediumWhiteA700Bold.copyWith(
                      fontSize: isTrueFalse ? 24.fSize : 20.fSize,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  if (widget.quizGridItemModelObj.isSelected)
                    Positioned(
                      top: 10,
                      right: 10,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.rectangle,
                        ),
                        child: Icon(
                          Icons.check,
                          color: widget.quizGridItemModelObj.backgroundColor,
                          size: 20,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
