//  Configuring the LCD's ports and directions
//       as required by the library
sbit LCD_D4 at RD0_bit;
sbit LCD_D5 at RD1_bit;
sbit LCD_D6 at RD2_bit;
sbit LCD_D7 at RD3_bit;
sbit LCD_EN at RD4_bit;
sbit LCD_RS at RD5_bit;

sbit LCD_D4_Direction at TRISD0_bit;
sbit LCD_D5_Direction at TRISD1_bit;
sbit LCD_D6_Direction at TRISD2_bit;
sbit LCD_D7_Direction at TRISD3_bit;
sbit LCD_EN_Direction at TRISD4_bit;
sbit LCD_RS_Direction at TRISD5_bit;


// configuring the keypad rows and cols connection
char keypadPort at PORTB ;


char password_input[6] ;

char tries_left [9];
int count_fails = 0 ;
int i ;
char mode ;

void main() {
password_input[5] = '\0' ;

// initialize outpot port and direction all with 0
trisc = 0 ; portc = 0 ;

// initially the door is locked
//  so red LED is on
portc.f2 = 1 ;
Lcd_Init(); keypad_Init();
Lcd_Cmd(_LCD_CURSOR_OFF);

Lcd_Cmd( _LCD_CLEAR ) ;
lcd_out(1 , 1 , "WELCOME !!");
delay_ms(100);
lcd_out(1 , 1 , "To Switch Modes");
lcd_out(2 , 1 , "  Press + ");
delay_ms(100);
Lcd_Cmd( _LCD_CLEAR ) ;


//while( 1 ){
//lcd_out(1 , 1 , "1 -> USER_MODE");
//lcd_out(2 , 1 , "2 -> ADMIN_MODE");
//mode = keypad_key_Click();
//if(mode == 9 ){  goto USER_MODE ;  }
//if(mode == 10 ){  goto ADMIN_MODE ;  }
//}


USER_MODE :

Lcd_Cmd( _LCD_CLEAR ) ;
Lcd_out(1,1,"Enter Your Key :");
password_input[0]=0;password_input[1]=0;password_input[2]=0;
password_input[3]=0;password_input[4]=0;
Lcd_out( 2 , 1 , " "  );
for( i = 0 ; i < 5 ; i++){

while(password_input[i] == 0){  password_input[i] = keypad_key_Click(); }
if(password_input[i] == 16 ){ goto ADMIN_MODE ;}
Lcd_out_cp(  "*"  );
if(password_input[i]==1) password_input[i] = '7' ;
if(password_input[i]==2) password_input[i] = '8' ;
if(password_input[i]==3) password_input[i] = '9' ;
if(password_input[i]==5) password_input[i] = '4' ;
if(password_input[i]==6) password_input[i] = '5' ;
if(password_input[i]==7) password_input[i] = '6' ;
if(password_input[i]==9) password_input[i] = '1' ;
if(password_input[i]==10) password_input[i] = '2' ;
if(password_input[i]==11) password_input[i] = '3' ;
if(password_input[i]==14) password_input[i] = '0' ;
}
Lcd_Cmd( _LCD_CLEAR ) ;
lcd_out( 1 , 1 , password_input ) ;
delay_ms(100);
if(strcmp(password_input,"12345")==0){
Lcd_Cmd( _LCD_CLEAR ) ;
Lcd_out( 1 , 2 , "WELCOME");
Lcd_out( 2 , 3 ,"MO3GZA");
delay_ms(100);
goto USER_MODE ;
}
else{
count_fails ++;
if( count_fails == 3 ){
count_fails = 0;
goto SUSPENDED_MODE ;
}                

Lcd_Cmd( _LCD_CLEAR ) ;
Lcd_out( 1 , 1 , "8alat ya 3ars");
lcd_out(2, 1, "Tries Left: ");
IntToStr( 3 - count_fails , tries_left) ;
tries_left[1] = tries_left[7] ;
lcd_out_cp( tries_left );
delay_ms(100) ;
goto USER_MODE ;
}

ADMIN_MODE :
Lcd_Cmd( _LCD_CLEAR ) ;
Lcd_out( 1 , 1 , "ADMIN MODE");
SUSPENDED_MODE :
Lcd_out_cp("2");


}

