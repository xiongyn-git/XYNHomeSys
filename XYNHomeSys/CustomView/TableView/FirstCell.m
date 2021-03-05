//
//  FirstCell.m
//  XYNHomeSys
//
//  Created by xyn on 2021/2/23.
//

#import "FirstCell.h"

@interface FirstCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameLab;

@property (weak, nonatomic) IBOutlet UIButton *addStrBtn;

@end

@implementation FirstCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.addStrBtn.layer.cornerRadius = 4.0f;
    //yes的时候会渲染
//    self.addStrBtn.clipsToBounds = NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

- (void)loadModel:(FirstModel *)model {
    self.nameLab.text = model.name;
    [self.addStrBtn setTitle:model.appendStr forState:UIControlStateNormal];
}
- (IBAction)appendStr:(UIButton *)sender {
//    if(!self.appendBlock) {
        self.appendBlock(sender.titleLabel.text);
//    }
}


@end
