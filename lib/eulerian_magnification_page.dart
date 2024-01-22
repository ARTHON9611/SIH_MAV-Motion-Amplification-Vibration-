// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:mav/upload_screen.dart';

enum ValueInputType { slider, manual }

class EulerianMagnificationPage extends StatefulWidget {
  @override
  _EulerianMagnificationPageState createState() =>
      _EulerianMagnificationPageState();
}

class _EulerianMagnificationPageState extends State<EulerianMagnificationPage> {
  double alpha = 10;
  double cutoff = 45;
  double low = 0.5;
  double high = 1;
  double chromAttenuation = 0;
  bool linearAttenuation = true;
  int mode = 0;
  late Map<String, dynamic> parameters = {};
  ValueInputType valueInputType = ValueInputType.slider;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Eulerian Video Magnification Parameters'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [_buildModeSelector(), _buildApplyButton()]),
            _buildInputTypeSelection(),
            if (valueInputType == ValueInputType.slider)
              Column(
                children: [
                  _buildParameterSlider('Alpha', alpha, (value) {
                    setState(() {
                      alpha = value;
                    });
                  },50),
                  _buildParameterSlider('Cutoff', cutoff, (value) {
                    setState(() {
                      cutoff = value;
                    });
                  },100),
                  _buildParameterSlider('Low', low, (value) {
                    setState(() {
                      low = value;
                    });
                  },0.5),
                  _buildParameterSlider('High', high, (value) {
                    setState(() {
                      high = value;
                    });
                  },1),
                  _buildParameterSlider('Chrom Attenuation', chromAttenuation, (value) {
                    setState(() {
                      chromAttenuation = value;
                    });
                  },1),
                  if (mode == 0)
                    SwitchListTile(
                      title: Text('Linear Attenuation'),
                      value: linearAttenuation,
                      onChanged: (value) {
                        setState(() {
                          linearAttenuation = value;
                        });
                      },
                    ),
                  _buildApplyButton(),
                ],
              ),
            if (valueInputType == ValueInputType.manual)
              Column(
                children: [
                  _buildParameterInput('Alpha', alpha, (value) {
                    setState(() {
                      alpha = double.tryParse(value) ?? alpha;
                    });
                  },50),
                  _buildParameterInput('Cutoff', cutoff, (value) {
                    setState(() {
                      cutoff = double.tryParse(value) ?? cutoff;
                    });
                  },10),
                  _buildParameterInput('Low', low, (value) {
                    setState(() {
                      low = double.tryParse(value) ?? low;
                    });
                  },0.5),
                  _buildParameterInput('High', high, (value) {
                    setState(() {
                      high = double.tryParse(value) ?? high;
                    });
                  },1),
                  _buildParameterInput('Chrom Attenuation', chromAttenuation, (value) {
                    setState(() {
                      chromAttenuation = double.tryParse(value) ?? chromAttenuation;
                    });
                  },1),
                  if (mode == 0)
                    SwitchListTile(
                      title: Text('Linear Attenuation'),
                      value: linearAttenuation,
                      onChanged: (value) {
                        setState(() {
                          linearAttenuation = value;
                        });
                      },
                    ),
                  _buildModeSelector(),
                  _buildApplyButton(),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputTypeSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Value Input Type',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            Radio(
              value: ValueInputType.slider,
              groupValue: valueInputType,
              onChanged: (ValueInputType? value) {
                setState(() {
                  valueInputType = value!;
                });
              },
            ),
            Text('Slider'),
            Radio(
              value: ValueInputType.manual,
              groupValue: valueInputType,
              onChanged: (ValueInputType? value) {
                setState(() {
                  valueInputType = value!;
                });
              },
            ),
            Text('Manual'),
          ],
        ),
      ],
    );
  }

  Widget _buildModeSelector() {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'Mode',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 16),
            DropdownButton<int>(
              value: mode,
              onChanged: (int? value) {
                setState(() {
                  mode = value!;
                });
              },
              items: [
                DropdownMenuItem<int>(
                  value: 0,
                  child: Text('0'),
                ),
                DropdownMenuItem<int>(
                  value: 1,
                  child: Text('1'),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 16),
      ],
    );
  }

 Widget _buildParameterSlider(
  String label, double value, ValueChanged<double> onChanged, double maxValue) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      Slider(
        value: value,
        min: 0,
        max: maxValue, // Set the maximum value for the slider
        divisions: 10,
        label: '$value',
        onChanged: onChanged,
        activeColor: Colors.blueAccent,
      ),
      SizedBox(height: 16),
    ],
  );
}

Widget _buildParameterInput(
  String label, double value, ValueChanged<String> onChanged, double maxLength) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      TextField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: 'Enter $label (max $maxLength)', // Show maximum value allowed
          border: OutlineInputBorder(),
        ),
        onChanged: (newValue) {
          if (newValue.isNotEmpty) {
            final double parsedValue = double.parse(newValue);
            if (parsedValue <= maxLength) {
              onChanged(newValue);
            } else {
              // Notify the user if the value exceeds the maximum allowed
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Value exceeds maximum'),
                    content: Text('Maximum allowed value for $label is $maxLength'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('OK'),
                      ),
                    ],
                  );
                },
              );
            }
          }
        },
      ),
      SizedBox(height: 16),
    ],
  );
}

  Widget _buildApplyButton() {
  return ElevatedButton(
    onPressed: () {
      Map<String, String> parameters = {
        'technique':'eulerian',
        'alpha': alpha.toString(),
        'cutoff': cutoff.toString(),
        'low': low.toString(),
        'high': high.toString(),
        'chromAttenuation': chromAttenuation.toString(),
        'linearAttenuation': linearAttenuation.toString(),
        'mode': mode.toString(),
        'valueInputType': valueInputType.toString(),
      };

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UploadScreen(parameters: parameters),
        ),
      );
    },
    style: ElevatedButton.styleFrom(
      primary: Colors.black,
      onPrimary: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    child: Text('Done'),
  );
}

}
