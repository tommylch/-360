//
//  ViewController.m
//  Panorama
//
//  Created by Robby Kraft on 8/24/13.
//  Copyright (c) 2013 Robby Kraft. All Rights Reserved.
//

#import "ViewController.h"
#import "PanoramaView.h"
#import "_360-Swift.h"

@interface ViewController (){
	PanoramaView *panoramaView;
}

//@property(nonatomic,strong) NSString *ImageName;

@end

@implementation ViewController
- (IBAction)Back:(id)sender {
}



- (void)viewDidLoad{
	[super viewDidLoad];
    
//    AnnotationDetail *obj = [[AnnotationDetail alloc] init];
//    
//    obj.image1name = _ImageName;
    
    NSString *ImageNamewithquote = [NSString stringWithFormat:@"\"%@\"", _ImageName];
    
    NSLog(@"%@", _ImageName);
    NSLog(@"%@", ImageNamewithquote);
    
    panoramaView = [[PanoramaView alloc] init];
	[panoramaView setImageWithName: _ImageName];
//	[panoramaView setImageWithName:@"spectrum.png"];
	[panoramaView setOrientToDevice:YES];
	[panoramaView setTouchToPan:YES ];
	[panoramaView setPinchToZoom:YES];
	[panoramaView setShowTouches:NO];
	[panoramaView setVRMode:NO];
	[self setView:panoramaView];
}

-(void) glkView:(GLKView *)view drawInRect:(CGRect)rect{
	[panoramaView draw];
    

    }

//restrict orientations
- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

// uncomment everything below to make a VR-Mode switching button

-(void) viewWillAppear:(BOOL)animated{
    
    
	[super viewWillAppear:animated];
	CGFloat PAD = 15.0;
	UIButton *VRButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
 	[VRButton setTransform:CGAffineTransformMakeRotation(M_PI*0.5)];
	[VRButton setCenter:CGPointMake(VRButton.frame.size.width*0.5 + PAD,
									self.view.bounds.size.height - VRButton.frame.size.height*0.5 - PAD)];   
	[VRButton setImage:[UIImage imageNamed:@"cardboardOn"] forState:UIControlStateNormal];
	[VRButton setAlpha:0.5];
	[VRButton addTarget:self action:@selector(vrButtonHandler:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:VRButton];
    
    
    UIButton *BackButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    [BackButton setTransform:CGAffineTransformMakeRotation(M_PI*0.5)];
    [BackButton setCenter:CGPointMake(BackButton.frame.size.width*0.5 + 80,
                                    self.view.bounds.size.height - BackButton.frame.size.height*0.5 - PAD)];
    [BackButton setImage:[UIImage imageNamed:@"backbutton"] forState:UIControlStateNormal];
    [BackButton setAlpha:0.5];
	[BackButton addTarget:self action:@selector(backPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:BackButton];
}

-(void) vrButtonHandler:(UIButton*)sender{
	[panoramaView setVRMode:!panoramaView.VRMode];
	if(panoramaView.VRMode){
		[sender setImage:[UIImage imageNamed:@"cardboardOff"] forState:UIControlStateNormal];
	}else{
		[sender setImage:[UIImage imageNamed:@"cardboardOn"] forState:UIControlStateNormal];
	}
}

-(void) backPressed:(UIButton*)sender{
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

@end
