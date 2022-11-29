import numpy as np
import pandas as pd
from librosa_class import *

#set fps and song length
fps = 40
song_len = 240 #s
#choose song name
song_name="../media/crimewave.mp3"
# calculate frame duration and number of frames
frame_duration = (1/fps)*1000 #ms
n_frames = song_len /(frame_duration*1000)
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
features.get_percussive_data()
df.to_csv('data.csv',index=True) # same as beat_activations.csv ?
