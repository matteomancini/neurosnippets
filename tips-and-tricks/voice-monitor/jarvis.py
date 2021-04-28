#!/usr/bin/env python3
# coding: utf-8
# Script that implements a simple voice assistant
# Copyright (C) Matteo Mancini (ingmatteomancini@gmail.com)
# Permission to copy and modify is granted under MIT license
# Last revised: 28/04/2021

import speech_recognition as sr
import pyttsx3


def speak(text):
    engine = pyttsx3.init()
    engine.say(text)
    engine.runAndWait()
    
    
def get_audio():
    r = sr.Recognizer()
    with sr.Microphone() as source:
        audio = r.listen(source)
        said = ""

        try:
            said = r.recognize_google(audio)
            print(said)
        except Exception as e:
            print("Exception: " + str(e))

    return said.lower()
    
    
wake_word = "hey jarvis"
queries = ["what is the status", "what is going on",
           "how is going with", "any update with"]
quit = "thank you"

while True:
    print("Listening...")
    text = get_audio()

    if text.count(wake_word) > 0:
        for phrase in queries:
            if phrase in text:
                filename = text.split(' ')[-1]+'.txt'
                try:
                    file_handle = open(filename,'r')
                    last_update = file_handle.readlines()[-1]
                    file_handle.close()
                    speak("The current status is: " + last_update)
                except IOError:
                    speak("I cannot find " + filename)
        else:
            if quit in text:
                speak("Goodbye")
                break
