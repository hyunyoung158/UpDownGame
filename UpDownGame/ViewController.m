//
//  ViewController.m
//  UpDownGame
//
//  Created by SDT-1 on 2014. 1. 6..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITextFieldDelegate> {
    int answer;
    int maximunTrial;
    int trial;
}

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UITextField *userInput;
@property (weak, nonatomic) IBOutlet UIProgressView *progress;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameSelector;
@end

@implementation ViewController

//확인 버튼 누르면 숫자입력값 체크
- (IBAction)checkInput:(id)sender {
    int inputVal = [self.userInput.text intValue];
    self.userInput.text = @"";
    
    if (answer == inputVal) {
        self.label.text = @"정답입니다";
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"정답" message:@"다시 게임하시겠습니까?" delegate:self cancelButtonTitle:@"취소" otherButtonTitles:@"확인", nil];
        alert.tag = 11;
        [alert show];
        
    }else {
        trial ++;
        if (trial >= maximunTrial) {
            NSString *msg = [NSString stringWithFormat:@"답은 %d입니다.", answer];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"실패" message:msg delegate:self cancelButtonTitle:@"취소" otherButtonTitles:@"확인", nil];
            alert.tag = 12;
            [alert show];
            
        }else {
            if (answer < inputVal) {
                self.label.text = @"Down";
            }else {
                self.label.text = @"Up";
            }
            self.countLabel.text = [NSString stringWithFormat:@"%d / %d", trial, maximunTrial];
            
            self.progress.progress = trial/(float)maximunTrial;
        }
    }
}

- (IBAction)newGame:(id)sender {
    int selectedGame = (int)self.gameSelector.selectedSegmentIndex;
    int maximumRandom = 0;
    
    if (0 == selectedGame) {
        maximunTrial = 5;
        maximumRandom = 10;
    }else if (1 == selectedGame) {
        maximunTrial = 10;
        maximumRandom = 50;
    }else {
        maximunTrial = 20;
        maximumRandom = 100;
    }
    answer = random() % maximumRandom + 1;
    trial = 0;
    self.progress.progress = 0.0;
    self.countLabel.text = @"";
    self.label.text = @"";
    
    NSLog(@"New game with answer : %d", answer);
}

//키보드가 시작하자마자 올라오도록
- (void)viewWillAppear:(BOOL)animated {
    self.userInput.keyboardType = UIKeyboardTypeNumberPad;
    [self.userInput becomeFirstResponder];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //초기치 설정
    [self newGame:nil];
}

//return 키로 확인 - 숫자 키패드라서 테스트용.
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self checkInput:nil];
    return YES;
}

//게임 재시작 여부
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == alertView.firstOtherButtonIndex) {
        [self newGame:nil];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
