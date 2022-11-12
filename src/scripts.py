import numpy as np
import pandas as pd
from librosa_class import *

#set number of frames and frame duration
n_frames=500 #included for testing purposes
frame_duration=50 #ms
#choose song name
song_name="../media/bubbles.wav"
#class for feature extraction
features=Feature_extractorx(song_name)
#set sound type
sound_type='beat'
#get np array len(num. frames) with True for every frame before a sound
activation_frames=features.get_activation_frame(
    n_frames,frame_duration,sound_type)


for i in activation_frames:
    print(i)
print(features.duration)
df=pd.DataFrame(columns=['Beat activation'],data=activation_frames)
df.to_csv('beat_activations.csv',index=False)
