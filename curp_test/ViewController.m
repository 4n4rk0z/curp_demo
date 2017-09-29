//
//  ViewController.m
//  curp_test
//
//  Created by 4n4rk0z on 9/29/17.
//  Copyright © 2017 demo. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"

@interface ViewController ()

@end

@implementation ViewController

- (IBAction)curpData:(id)sender {
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)servicePost:(id)sender {
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
    NSString * curp = [self.curpData text];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"application/json"];
    
    NSDictionary *params = @{@"indRENAPO":@"CURP",
                             @"curp":curp
                             };
    
    NSString *completeURL= [NSString stringWithFormat:@"https://www.bancomermovil.net:11443/dembmv_mx_web/mbmv_mult_web_mbmv_01/services/digitalAccount/V02/consultaCURP"];
    
    [manager POST:completeURL parameters:params success:^(NSURLSessionDataTask *task, id responseObject)
     {
         NSLog(@"Response%@",responseObject);
         
         if ([[NSString stringWithFormat:@"%@",[responseObject valueForKey:@"status"]] isEqualToString:@"1"])
         {
             NSDictionary *data = (NSDictionary *)responseObject;
             NSString *aMaterno = [data objectForKey:@"aMaterno"];
             NSString *aPaterno = [data objectForKey:@"aPaterno"];
             NSString *sexo = [data objectForKey:@"sexo"];
             NSString *Nat = [data objectForKey:@"nacionalidad"];
             NSString *entEm = [data objectForKey:@"cveEntidadEmisora"];
             NSString *fecha = [data objectForKey:@"fechNac"];
             NSString *nombres = [data objectForKey:@"nombres"];

             [self.nombres setText:nombres];
             [self.Apaterno setText:aPaterno];
             [self.Amaterno setText:aMaterno];
             [self.sexo setText:sexo];
             [self.Nat setText:Nat];
             [self.EntEm setText:entEm];
             [self.Fecha setText:fecha];
             NSLog(@"responce%@",data);
         }
         else
         {
             NSLog(@"Not responce");
         }
     }
          failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         NSLog(@"Failure Block");
         
     }];
}

@end
