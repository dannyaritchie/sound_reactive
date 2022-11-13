import librosa
import numpy as np
from IPython.display import Audio
import soundfile as sf

class Feature_extractorx():

    def __init__(self,filename):
        self.filename=filename
        self.y, self.sr = librosa.load(filename)
        self.tempo, self.beat_frames = librosa.beat.beat_track(
            y=self.y,sr=self.sr)
        self.beat_times = librosa.frames_to_time(self.beat_frames, sr=self.sr)
        self.duration=librosa.get_duration(y=self.y,sr=self.sr)
        return
    def get_activation_frame(self,number_of_frames,frame_duration,sound):
        #sound: a string descpripor for an array of sound activation times
        #returns activation_frames: (a bool for every frame with True indicating that 
        #frame is the first frame before a sound activation.
        frame_duration/=1000
        activation_times=None
        if sound == 'beat':
            activation_times=self.beat_times
        activation_frames=np.full((number_of_frames),0) 
        frame_index=0
        for i in activation_times:
            time=frame_index*frame_duration
            while(time<i):
                    frame_index +=1
                    time=frame_index*frame_duration
            if frame_index<number_of_frames-1:
                activation_frames[frame_index-1]=1
        return activation_frames
    def get_percussive_data(self):
        y_harmonic, y_percussive = librosa.effects.hpss(self.y)
        Audio(data=y_percussive, rate=self.sr)
        sf.write('percussive.wav',y_percussive,self.sr)
        sf.write('harmonic.wav',y_harmonic,self.sr)

