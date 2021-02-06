//
//  GameScene.m
//  ShootTheTank
//
//  Created by Westley Rose on 2/6/21.
//

#import "GameScene.h"

@implementation GameScene {
    SKShapeNode *_spinnyNode;
    SKShapeNode* background;
    SKLabelNode *_label;
}

- (void)didMoveToView:(SKView *)view {
    // Setup your scene here

    //_label.alpha = 0.0;
    //[_label runAction:[SKAction fadeInWithDuration:2.0]];

    background = (SKShapeNode *)[self childNodeWithName:@"//battleBackground"];

    CGFloat w = (self.size.width + self.size.height) * 0.05;
    
    // Create shape node to use during mouse interaction
//    _spinnyNode = [SKShapeNode shapeNodeWithRectOfSize:CGSizeMake(w, w) cornerRadius:w * 0.3];
    _spinnyNode = [SKShapeNode shapeNodeWithRectOfSize:CGSizeMake(w, w) cornerRadius:w * 0.2];
    _spinnyNode.lineWidth = 5.5;
    
//    [_spinnyNode runAction:[SKAction repeatActionForever:[SKAction rotateByAngle:M_PI duration:1]]];
//    [_spinnyNode runAction:[SKAction sequence:@[
//                                                [SKAction waitForDuration:0.5],
//                                                [SKAction fadeOutWithDuration:0.5],
//                                                [SKAction removeFromParent],
//                                                ]]];

//    SKShapeNode *n = [_spinnyNode copy];
    CGPoint pos = CGPointMake(5, 5);
    _spinnyNode.position = pos;
    _spinnyNode.strokeColor = [SKColor blueColor];
    [self addChild:_spinnyNode];




    // The background demon to move the map
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        while (true) {
            if (movingUp) {
                dispatch_async(dispatch_get_main_queue(), ^(void) {
                    CGPoint newPos = self->background.position;
                    newPos.y -= tankMovmentSpeed;
                    [self->background setPosition:newPos];
                });
            }
            if (movingDown) {
                dispatch_async(dispatch_get_main_queue(), ^(void) {
                    CGPoint newPos = self->background.position;
                    newPos.y += tankMovmentSpeed;
                    [self->background setPosition:newPos];
                });
            }
            if (movingLeft) {
                dispatch_async(dispatch_get_main_queue(), ^(void) {
                    CGPoint newPos = self->background.position;
                    newPos.x += tankMovmentSpeed;
                    [self->background setPosition:newPos];
                });
            }
            if (movingRight) {
                dispatch_async(dispatch_get_main_queue(), ^(void) {
                    CGPoint newPos = self->background.position;
                    newPos.x -= tankMovmentSpeed;
                    [self->background setPosition:newPos];
                });
            }

            sleep(0.1);
        }
    });
}


- (void)touchDownAtPoint:(CGPoint)pos {
//    SKShapeNode *n = [_spinnyNode copy];
//    n.position = pos;
//    n.strokeColor = [SKColor greenColor];
//    [self addChild:n];
}

- (void)touchMovedToPoint:(CGPoint)pos {
    _spinnyNode.position = pos;

//    SKShapeNode *n = [_spinnyNode copy];
//    n.position = pos;
//    n.strokeColor = [SKColor blueColor];
//    [self addChild:n];
}

- (void)touchUpAtPoint:(CGPoint)pos {
//    SKShapeNode *n = [_spinnyNode copy];
//    n.position = pos;
//    n.strokeColor = [SKColor redColor];
//    [self addChild:n];
}

bool movingUp;
bool movingDown;
bool movingLeft;
bool movingRight;
double tankMovmentSpeed = 0.002;

- (void)keyDown:(NSEvent*)event {
    switch (event.keyCode) {
        case 0x0D: // up
            movingUp = YES;
            break;

        case 0x01: // down
            movingDown = YES;
            break;

        case 0x02: // right
            movingRight = YES;
            break;

        case 0x00: // left
            movingLeft = YES;
            break;

        default:
            NSLog(@"keyDown:'%@' keyCode: 0x%02X", event.characters, event.keyCode);
            break;
    }

}

- (void)keyUp:(NSEvent*)event {
    switch (event.keyCode) {
        case 0x0D: // up
            movingUp = NO;
            break;

        case 0x01: // down
            movingDown = NO;
            break;

        case 0x02: // right
            movingRight = NO;
            break;

        case 0x00: // left
            movingLeft = NO;
            break;

        default:
            NSLog(@"keyDown:'%@' keyCode: 0x%02X", event.characters, event.keyCode);
            break;
    }
}



- (void)mouseDown:(NSEvent *)theEvent {
    [self touchDownAtPoint:[theEvent locationInNode:self]];
}
- (void)mouseDragged:(NSEvent *)theEvent {
    [self touchMovedToPoint:[theEvent locationInNode:self]];
}
- (void)mouseUp:(NSEvent *)theEvent {
   // [self touchUpAtPoint:[theEvent locationInNode:self]];
}


-(void)update:(CFTimeInterval)currentTime {
    // Called before each frame is rendered
}

@end
