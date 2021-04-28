# A voice assistant to monitor a target application

[![NeuroSnippets](https://img.shields.io/static/v1?label=Neuro&message=Snippets&color=orange)](http://neurosnippets.com/posts/voice-monitor/#post) [![made-with-python](https://img.shields.io/badge/Made%20with-Python-1f425f.svg)](https://www.python.org/)

This script implements a simple voice assistant (`jarvis.py`) using [SpeechRecognition](https://pypi.org/project/SpeechRecognition/ 'SpeechRecognition on PyPI') to monitor a target application running (through an output file). More details available in this [post](http://neurosnippets.com/posts/voice-monitor/#post).

To run the script, you need `python` (`3.7`) and the following packages:

* `pyttsx3` (`2.90`);
* `SpeechRecognition` (`3.8.1);
* `PyAudio` (`0.2.11`).

To run the target script (`run.sh`), you need also `MRtrix3` (`3.0-RC3`) and `dipy` (`1.4.0`). 

The script was tested on macOS `10.15.7`.
