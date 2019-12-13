
//  Particle.h
//  Particle
//
//  Created by Dinan Yan on 2019/12/13.
//

#include "ofxiOS.h"
#define NUM_COLOR 5
class Particle{

  public:
    void setup(ofVec3f gPos){
        pos=gPos;
        speed.set(ofRandom(-5,5),ofRandom(-5,5));
        touched = true;
        myColor.set(ofRandom(255),ofRandom(255),100);
    }
    
    void update(){
        pos+=speed;
    }
        
    void draw(){
        ofSetColor(myColor,ofRandom(50,160));
        ofDrawCircle(pos.x, pos.y, ofRandom(80));
        //
        /*
        int maxRadius = 50;  // Increase for a wider brush
        int radiusStepSize = 5;  // Decrease for more circles (i.e. a more opaque brush)
        int alpha = 100;  // Increase for a more opaque brush
        int maxOffsetDistance = 100;  // Increase for a larger spread of circles
        // draw smaller and smaller circles and layering (increasing) opaqueness
        for (int radius=maxRadius; radius>0; radius-=radiusStepSize) {
            float angle = ofRandom(ofDegToRad(360.0));
            float distance = ofRandom(maxOffsetDistance);
            float xOffset = cos(angle) * distance;
            float yOffset = sin(angle) * distance;
            ofSetColor(myColor, alpha);
            ofDrawCircle(pos.x+xOffset, pos.y+yOffset, radius);
        }
        */
    }
    
    ofVec2f pos,speed;
    ofColor myColor;
    bool touched;
};
