//
//  EmisoraViewController.m
//  april 9
//
//  Created by webstudent on 4/9/14.
//  Copyright (c) 2014 RVC Student. All rights reserved.
//

#import "EmisoraViewController.h"

@interface EmisoraViewController ()
@end

NSURL *url;
@implementation EmisoraViewController
@synthesize webview;

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
   
    url = [NSURL URLWithString:_dial[row]];
    self.avAsset = [AVURLAsset URLAssetWithURL:url options:nil];
    self.playerItem = [AVPlayerItem playerItemWithAsset:self.avAsset];
    self.audioPlayer = [AVPlayer playerWithPlayerItem:self.playerItem];
    [self.audioPlayer play];
   
        self.btnStop.enabled = YES;
        self.btnPlay.enabled = NO;
       
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.radiostations.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.radiostations[row];
}

- (void)viewDidLoad

{
 
    // Disable Stop/Play button when application launches
    [self.btnStop setEnabled:NO];
    [self.btnPlay setEnabled:NO];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    
    self.radiostations = @[@"Select Radio Station",@"89.5 NPR", @"181 Kickin Country", @"96.7 EAGLE", @"95.3 WRTB", @"95.3 WRTB", @"95.3 WRTB", @"95.3 WRTB", @"95.3 WRTB", @"95.3 WRTB", @"95.3 WRTB", @"95.3 WRTB", @"95.3 WRTB"];
    
    
    self.dial = @[@"",@"http://peace.str3am.com:6810/live-96k.mp3", @"http://yp.shoutcast.com/sbin/tunein-station.pls?id=221956", @"http://provisioning.streamtheworld.com/pls/wkglfmaac.pls",@"http://out1.cmn.icy.abacast.com/wrtb-wrtbfmaac-64.m3u",
        @"http://out1.cmn.icy.abacast.com/wrtb-wrtbfmaac-64.m3u",@"http://out1.cmn.icy.abacast.com/wrtb-wrtbfmaac-64.m3u",
        @"http://out1.cmn.icy.abacast.com/wrtb-wrtbfmaac-64.m3u",@"http://out1.cmn.icy.abacast.com/wrtb-wrtbfmaac-64.m3u",
        @"http://out1.cmn.icy.abacast.com/wrtb-wrtbfmaac-64.m3u",@"http://out1.cmn.icy.abacast.com/wrtb-wrtbfmaac-64.m3u",
        @"http://out1.cmn.icy.abacast.com/wrtb-wrtbfmaac-64.m3u",@"http://out1.cmn.icy.abacast.com/wrtb-wrtbfmaac-64.m3u"];
  
    //Make sure the system follows our playback status (needed to play audio in background)
    
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    [[AVAudioSession sharedInstance] setActive: YES error: nil];
    
     NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"banner" ofType:@"html"];
    NSURL *url=[NSURL fileURLWithPath:htmlFile];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
   [self.webview loadRequest:req];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    
    //Once the view has loaded then we can register to begin recieving controls and we can become the first responder
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    [self becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    //End recieving events
    [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
    [self resignFirstResponder];
}
//Make sure we can recieve remote control events
- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (void)remoteControlReceivedWithEvent:(UIEvent *)event {
    //if it is a remote control event handle it correctly
    if (event.type == UIEventTypeRemoteControl) {
        if (event.subtype == UIEventSubtypeRemoteControlPlay) {
             [self.audioPlayer play];
        } else if (event.subtype == UIEventSubtypeRemoteControlPause) {
              [self.audioPlayer pause];
        } else if (event.subtype == UIEventSubtypeRemoteControlTogglePlayPause) {
            [self togglePlayPause];
        }
    }
}
- (void)togglePlayPause {
    //Toggle if the music is playing or paused
    if (!self.audioPlayer.playing) {
        [self.audioPlayer play];
        
    } else if (self.audioPlayer.playing) {
        [self.audioPlayer pause];
        
    }
}
- (IBAction)btnStop:(id)sender {
    
           self.btnStop.enabled = NO;
        self.btnPlay.enabled = YES;
        [self.audioPlayer pause];
   
}

- (IBAction)btnPlay:(id)sender {
    self.btnStop.enabled = YES;
    self.btnPlay.enabled = NO;
    [self.audioPlayer play];

}
@end
