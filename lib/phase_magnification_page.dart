// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:mav/upload_screen.dart';


enum ValueInputType { slider, manual }

class PhaseMagnificationPage extends StatefulWidget {
  @override
  _PhaseMagnificationPageState createState() => _PhaseMagnificationPageState();
}

class _PhaseMagnificationPageState extends State<PhaseMagnificationPage> {
  double magnificationFactor = 20.0;
  double f1 = 0.04;
  double fh = 0.4;
  double fs = 1;
  bool attenuateOtherFrequencies = true;
  String pyrType = 'octave';
  double sigma = 5;
  ValueInputType valueInputType = ValueInputType.slider;
  Map<String, dynamic> parameters={};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phase-Based Magnification Parameters'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildInputTypeSelection(),
            if (valueInputType == ValueInputType.slider)
              Column(
                children: [
                  _buildParameterSlider('Magnification Factor', magnificationFactor, (value) {
                    setState(() {
                      magnificationFactor = value;
                    });
                  }, 100),
                  _buildParameterSlider('f1', f1, (value) {
                    setState(() {
                      f1 = value;
                    });
                  }, 1),
                  _buildParameterSlider('fh', fh, (value) {
                    setState(() {
                      fh = value;
                    });
                  }, 1),
                  _buildParameterSlider('fs', fs, (value) {
                    setState(() {
                      fs = value;
                    });
                  }, 10),
                  _buildParameterSlider('Sigma', sigma, (value) {
                    setState(() {
                      sigma = value;
                    });
                  }, 10),
                  SwitchListTile(
                    title: Text('Attenuate Other Frequencies'),
                    value: attenuateOtherFrequencies,
                    onChanged: (value) {
                      setState(() {
                        attenuateOtherFrequencies = value;
                      });
                    },
                  ),
                  _buildApplyButton(),
                ],
              ),
            if (valueInputType == ValueInputType.manual)
              Column(
                children: [
                  _buildParameterInput('Magnification Factor', magnificationFactor, (value) {
                    setState(() {
                      magnificationFactor = double.tryParse(value) ?? magnificationFactor;
                    });
                  }, 100),
                  _buildParameterInput('f1', f1, (value) {
                    setState(() {
                      f1 = double.tryParse(value) ?? f1;
                    });
                  }, 1),
                  _buildParameterInput('fh', fh, (value) {
                    setState(() {
                      fh = double.tryParse(value) ?? fh;
                    });
                  }, 1),
                  _buildParameterInput('fs', fs, (value) {
                    setState(() {
                      fs = double.tryParse(value) ?? fs;
                    });
                  }, 10),
                  _buildParameterInput('Sigma', sigma, (value) {
                    setState(() {
                      sigma = double.tryParse(value) ?? sigma;
                    });
                  }, 10),
                  SwitchListTile(
                    title: Text('Attenuate Other Frequencies'),
                    value: attenuateOtherFrequencies,
                    onChanged: (value) {
                      setState(() {
                        attenuateOtherFrequencies = value;
                      });
                    },
                  ),
                  _buildInputTypeSelection(),
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
        'technique':"phase",
        'magnification_factor': magnificationFactor.toString(),
        'f1': f1.toString(),
        'fh': fh.toString(),
        'fs': fs.toString(),
        'attenuate_other_frequencies': attenuateOtherFrequencies.toString(),
        'pyr_type': pyrType.toString(),
        'sigma': sigma.toString(),
      };

      // Navigate to the next page and pass the parameters
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UploadScreen(parameters: parameters),
        ),
      );
    },
      style: ElevatedButton.styleFrom(
        primary: Colors.black, // Button color
        onPrimary: Colors.white, // Text color
        padding: EdgeInsets.symmetric(vertical: 16), // Button padding
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // Button border
        ),
      ),
      child: Text('Done'),
    );
  }
}
