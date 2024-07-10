import 'package:flutter/material.dart';

class CulturalDetailPage extends StatefulWidget {
  final String headingName;
  final List<String>? steps;

  const CulturalDetailPage({
    Key? key,
    required this.headingName,
    this.steps,
  }) : super(key: key);

  @override
  _CulturalDetailPageState createState() => _CulturalDetailPageState();
}

class _CulturalDetailPageState extends State<CulturalDetailPage> {
  int _currentStep = 0;

  @override
  void initState() {
    super.initState();
    _currentStep = widget.steps?.isNotEmpty == true ? 0 : -1;
  }

  @override
  Widget build(BuildContext context) {
    print('widget.steps: ${widget.steps}');
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.headingName),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Stepper(
            currentStep: _currentStep,
            onStepContinue: () {
              if (_currentStep < (widget.steps?.length ?? 0) + 1) {
                setState(() {
                  _currentStep += 1;
                });
              }
            },
            onStepCancel: () {
              if (_currentStep > 0) {
                setState(() {
                  _currentStep -= 1;
                });
              }
            },
            steps: List.generate(
              widget.steps?.length ?? 0,
              (index) {
                return Step(
                  title: Text('Step ${index + 1}'),
                  content: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${widget.steps?[index] ?? ""}',
                        style: TextStyle(fontSize: 15),
                      ),
                      // Add more Text widgets for additional details if needed
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
