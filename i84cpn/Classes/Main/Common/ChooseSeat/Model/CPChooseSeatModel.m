//
//  CPChooseSeatModel.m
//  i84cpn
//
//  Created by 爱巴士-余夏伟 on 16/5/28.
//  Copyright © 2016年 5i84. All rights reserved.
//

#import "CPChooseSeatModel.h"

@implementation CPChooseSeatModel

+(NSArray *)getCollectViewData:(NSDictionary *)dic{
    NSMutableArray *arrSeat = [NSMutableArray array];   //0:过道  1:已被选   2:无效   3:可选
    NSLog(@"data ==== %@",dic);
    int seatRow = [dic[@"modelParam"][@"seatRow"] intValue];   //行数
    NSArray *arrLetter = dic[@"strucMap"][@"letter"];
    int seatTotalColumn = (int)arrLetter.count;  //总列数
    int seatLeftColumn = [dic[@"modelParam"][@"seatLeft"] intValue];   //左边列数
    
    //形成一个全部可选，过道无座的数组
    for (int i=0; i<seatRow; i++) {
        for (int j=0; j<seatTotalColumn;j++ ) {
            if (j == seatLeftColumn) {
                [arrSeat addObject:@"0"];
            }else{
                [arrSeat addObject:@"3"];
            }
        }
    }
    

    //替换已被选座位到数组
    NSArray *arrSoldSeat = dic[@"soldSeat"];
    int soldSeatNum = (int)arrSoldSeat.count;
    for (int i=0; i<soldSeatNum; i++) {
        NSString *strSeat = arrSoldSeat[i];
        NSInteger length = strSeat.length;
        int num1 = -1;
        for (int j = 0; j<seatRow; j++) {
            int num = [[strSeat substringWithRange:NSMakeRange(0, length-1)] intValue];
            if (num == [dic[@"strucMap"][@"number"][j] intValue]) {
                num1 = j;
            }
        }
        int num2 = -1;
        for (int j = 0; j<seatTotalColumn; j++) {
            NSString *str = [strSeat substringFromIndex:length-1];
            if ([str isEqualToString:dic[@"strucMap"][@"letter"][j]]) {
                num2 = j;
            }
        }
        if ((num1 != -1) && (num2 != -1)) {
            int num = num1*seatTotalColumn + num2;
            if (num < arrSeat.count) {
                [arrSeat replaceObjectAtIndex:num withObject:@"1"];
            }
        }

    }
    
    
    //替换无效座位到数组
    NSArray *arrInvalidSeat = dic[@"invalidSeatNo"];
    int invalidSeatNum = (int)arrInvalidSeat.count;
    for (int i=0; i<invalidSeatNum; i++) {
        NSString *strSeat = arrInvalidSeat[i];
        NSInteger length = strSeat.length;
        int num1 = -1;
        for (int j = 0; j<seatRow; j++) {
            int num = [[strSeat substringWithRange:NSMakeRange(0, length-1)] intValue];
            if (num == [dic[@"strucMap"][@"number"][j] intValue]) {
                num1 = j;
            }
        }
        int num2 = -1;
        for (int j = 0; j<seatTotalColumn; j++) {
            NSString *str = [strSeat substringFromIndex:length-1];
            if ([str isEqualToString:dic[@"strucMap"][@"letter"][j]]) {
                num2 = j;
            }
        }
        if ((num1 != -1) && (num2 != -1)) {
            int num = num1*seatTotalColumn + num2;
            if (num < arrSeat.count) {
                [arrSeat replaceObjectAtIndex:num withObject:@"2"];
            }
        }
    }
    
    
    return arrSeat;
}


+(NSString *)transformSeatNo:(int)index dic:(NSDictionary *)dic{
    NSArray *arrLetter = dic[@"strucMap"][@"letter"];
    NSArray *arrNumber = dic[@"strucMap"][@"number"];
    int seatTotalColumn = (int)arrLetter.count;  //总列数
    NSInteger row = index/seatTotalColumn; //行数
    NSInteger column = index % seatTotalColumn;
    NSString *seatNo = [NSString stringWithFormat:@"%@%@",arrNumber[row],arrLetter[column]];
    return seatNo;
}


@end
