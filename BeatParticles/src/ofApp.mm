#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup(){
    ofSetOrientation(OF_ORIENTATION_90_LEFT);
    ofSetCircleResolution(100);
    //ofSetBackgroundAuto(false);
    ofBackground(255);
    ofEnableAlphaBlending();
    

    //maxim
    ofSetVerticalSync(true);
    ofEnableAlphaBlending();
    ofSetupScreen();

    sample.load(ofToDataPath("IGotYou.wav"));
    playSpeed=1.0;
    sampleRate = 44100; /* Sampling Rate */
    bufferSize = 512; /* Buffer Size. you have to fill this buffer with sound using the for loop in the audioOut method */

    ofxMaxiSettings::setup(sampleRate, 2, bufferSize);
    // the higher the value, the more accurate will be the fft analysis
    fftSize = 1024;
    fft.setup(fftSize, 512, 256);
    /* this has to happen at the end of setup - it switches on the DAC */
    
    ofSoundStreamSetup(2,2,this, sampleRate, bufferSize, 4);
}

//--------------------------------------------------------------
void ofApp::update(){
    for(int i = 0; i<particles.size(); i++)
    {
        particles[i].update();
    }
}

//--------------------------------------------------------------
void ofApp::draw(){
    for(int i = 0; i<particles.size(); i++)
    {
        particles[i].draw();
    }
    
    //maixm
    float width = float(ofGetWidth()) / float(fftSize) /2.f;
     for(int i = 0; i < fftSize ;i++)
     {
         ofSetColor(0, 20);
         ofDrawCircle(ofGetWidth()/2 +width * i, ofGetHeight()/2, fft.magnitudes[i] * 10);
         ofDrawCircle(ofGetWidth()/2 -width * i,ofGetHeight()/2, fft.magnitudes[i] * 10);
     }
}

//--------------------------------------------------------------
void ofApp::exit(){

}

//--------------------------------------------------------------
void ofApp::touchDown(ofTouchEventArgs & touch){
    playSpeed=0.5+touch.x/ofGetWidth()*1.1;
    createParticle(touch.x, touch.y);
}

//--------------------------------------------------------------
void ofApp::touchMoved(ofTouchEventArgs & touch){
    playSpeed=0.5+touch.x/ofGetWidth()*1.1;
    createParticle(touch.x, touch.y);
}

//--------------------------------------------------------------
void ofApp::touchUp(ofTouchEventArgs & touch){
   for(int i = 0; i<particles.size(); i++)
   {
       particles[i].touched = false;
   }
}

//--------------------------------------------------------------
void ofApp::touchDoubleTap(ofTouchEventArgs & touch){
    playSpeed=1.0;
}

//--------------------------------------------------------------
void ofApp::touchCancelled(ofTouchEventArgs & touch){
    
}

//--------------------------------------------------------------
void ofApp::audioOut(float * output, int bufferSize, int nChannels) {
     for (int i = 0; i < bufferSize; i++){
            wave = sample.play(playSpeed);
            //fft
            if(fft.process(wave)){
                fft.magsToDB();
            }
            mymix.stereo(wave, outputs, 0.5);
            output[i*nChannels    ] = outputs[0];
            output[i*nChannels + 1] = outputs[1];
        }
   
}
//--------------------------------------------------------------
void ofApp::audioIn(float * input, int bufferSize, int nChannels){
    for(int i = 0; i < bufferSize; i++){
        /* you can also grab the data out of the arrays*/
    }
}
//--------------------------------------------------------------
void ofApp::lostFocus(){

}

//--------------------------------------------------------------
void ofApp::gotFocus(){

}

//--------------------------------------------------------------
void ofApp::gotMemoryWarning(){

}

//--------------------------------------------------------------
void ofApp::deviceOrientationChanged(int newOrientation){

}

void ofApp::createParticle(float x, float y)
{
    ofVec2f newPos(x,y);
    Particle p;
    p.setup(newPos);
    particles.push_back(p);
}

