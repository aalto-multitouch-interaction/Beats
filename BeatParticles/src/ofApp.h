#pragma once

#include "ofxiOS.h"
#include "ofxMaxim.h"
#include "Particle.h"

class ofApp : public ofxiOSApp {
    
    public:
        void setup();
        void update();
        void draw();
        void exit();
    
        void touchDown(ofTouchEventArgs & touch);
        void touchMoved(ofTouchEventArgs & touch);
        void touchUp(ofTouchEventArgs & touch);
        void touchDoubleTap(ofTouchEventArgs & touch);
        void touchCancelled(ofTouchEventArgs & touch);

        void lostFocus();
        void gotFocus();
        void gotMemoryWarning();
        void deviceOrientationChanged(int newOrientation);
        void audioOut(float * output, int bufferSize, int nChannels);
        void audioIn(float * input, int bufferSize, int nChannels);
        void createParticle(float x, float y);
 
    
    vector <Particle> particles;

    //maxim
    int bufferSize;
    int sampleRate;
    int fftSize;
    float playSpeed;

    maxiSample sample;
    maxiMix mymix;
    double wave;
    double outputs[2];
    ofxMaxiFFT fft;
    
};


