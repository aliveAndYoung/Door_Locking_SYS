
_main:

;MyProject.c,29 :: 		void main() {
;MyProject.c,30 :: 		password_input[5] = '\0' ;
	CLRF       _password_input+5
;MyProject.c,33 :: 		trisc = 0 ; portc = 0 ;
	CLRF       TRISC+0
	CLRF       PORTC+0
;MyProject.c,37 :: 		portc.f2 = 1 ;
	BSF        PORTC+0, 2
;MyProject.c,38 :: 		Lcd_Init(); keypad_Init();
	CALL       _Lcd_Init+0
	CALL       _Keypad_Init+0
;MyProject.c,39 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,41 :: 		Lcd_Cmd( _LCD_CLEAR ) ;
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,42 :: 		lcd_out(1 , 1 , "WELCOME !!");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,43 :: 		delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_main0:
	DECFSZ     R13+0, 1
	GOTO       L_main0
	DECFSZ     R12+0, 1
	GOTO       L_main0
	DECFSZ     R11+0, 1
	GOTO       L_main0
	NOP
;MyProject.c,44 :: 		lcd_out(1 , 1 , "To Switch Modes");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,45 :: 		lcd_out(2 , 1 , "  Press + ");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr3_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,46 :: 		delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_main1:
	DECFSZ     R13+0, 1
	GOTO       L_main1
	DECFSZ     R12+0, 1
	GOTO       L_main1
	DECFSZ     R11+0, 1
	GOTO       L_main1
	NOP
;MyProject.c,47 :: 		Lcd_Cmd( _LCD_CLEAR ) ;
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,59 :: 		USER_MODE :
___main_USER_MODE:
;MyProject.c,61 :: 		Lcd_Cmd( _LCD_CLEAR ) ;
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,62 :: 		Lcd_out(1,1,"Enter Your Key :");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr4_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,63 :: 		password_input[0]=0;password_input[1]=0;password_input[2]=0;
	CLRF       _password_input+0
	CLRF       _password_input+1
	CLRF       _password_input+2
;MyProject.c,64 :: 		password_input[3]=0;password_input[4]=0;
	CLRF       _password_input+3
	CLRF       _password_input+4
;MyProject.c,65 :: 		Lcd_out( 2 , 1 , " "  );
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr5_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,66 :: 		for( i = 0 ; i < 5 ; i++){
	CLRF       _i+0
	CLRF       _i+1
L_main2:
	MOVLW      128
	XORWF      _i+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main25
	MOVLW      5
	SUBWF      _i+0, 0
L__main25:
	BTFSC      STATUS+0, 0
	GOTO       L_main3
;MyProject.c,68 :: 		while(password_input[i] == 0){  password_input[i] = keypad_key_Click(); }
L_main5:
	MOVF       _i+0, 0
	ADDLW      _password_input+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main6
	MOVF       _i+0, 0
	ADDLW      _password_input+0
	MOVWF      FLOC__main+0
	CALL       _Keypad_Key_Click+0
	MOVF       FLOC__main+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
	GOTO       L_main5
L_main6:
;MyProject.c,69 :: 		if(password_input[i] == 16 ){ goto ADMIN_MODE ;}
	MOVF       _i+0, 0
	ADDLW      _password_input+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      16
	BTFSS      STATUS+0, 2
	GOTO       L_main7
	GOTO       ___main_ADMIN_MODE
L_main7:
;MyProject.c,70 :: 		Lcd_out_cp(  "*"  );
	MOVLW      ?lstr6_MyProject+0
	MOVWF      FARG_Lcd_Out_CP_text+0
	CALL       _Lcd_Out_CP+0
;MyProject.c,71 :: 		if(password_input[i]==1) password_input[i] = '7' ;
	MOVF       _i+0, 0
	ADDLW      _password_input+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main8
	MOVF       _i+0, 0
	ADDLW      _password_input+0
	MOVWF      FSR
	MOVLW      55
	MOVWF      INDF+0
L_main8:
;MyProject.c,72 :: 		if(password_input[i]==2) password_input[i] = '8' ;
	MOVF       _i+0, 0
	ADDLW      _password_input+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      2
	BTFSS      STATUS+0, 2
	GOTO       L_main9
	MOVF       _i+0, 0
	ADDLW      _password_input+0
	MOVWF      FSR
	MOVLW      56
	MOVWF      INDF+0
L_main9:
;MyProject.c,73 :: 		if(password_input[i]==3) password_input[i] = '9' ;
	MOVF       _i+0, 0
	ADDLW      _password_input+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      3
	BTFSS      STATUS+0, 2
	GOTO       L_main10
	MOVF       _i+0, 0
	ADDLW      _password_input+0
	MOVWF      FSR
	MOVLW      57
	MOVWF      INDF+0
L_main10:
;MyProject.c,74 :: 		if(password_input[i]==5) password_input[i] = '4' ;
	MOVF       _i+0, 0
	ADDLW      _password_input+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      5
	BTFSS      STATUS+0, 2
	GOTO       L_main11
	MOVF       _i+0, 0
	ADDLW      _password_input+0
	MOVWF      FSR
	MOVLW      52
	MOVWF      INDF+0
L_main11:
;MyProject.c,75 :: 		if(password_input[i]==6) password_input[i] = '5' ;
	MOVF       _i+0, 0
	ADDLW      _password_input+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      6
	BTFSS      STATUS+0, 2
	GOTO       L_main12
	MOVF       _i+0, 0
	ADDLW      _password_input+0
	MOVWF      FSR
	MOVLW      53
	MOVWF      INDF+0
L_main12:
;MyProject.c,76 :: 		if(password_input[i]==7) password_input[i] = '6' ;
	MOVF       _i+0, 0
	ADDLW      _password_input+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      7
	BTFSS      STATUS+0, 2
	GOTO       L_main13
	MOVF       _i+0, 0
	ADDLW      _password_input+0
	MOVWF      FSR
	MOVLW      54
	MOVWF      INDF+0
L_main13:
;MyProject.c,77 :: 		if(password_input[i]==9) password_input[i] = '1' ;
	MOVF       _i+0, 0
	ADDLW      _password_input+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      9
	BTFSS      STATUS+0, 2
	GOTO       L_main14
	MOVF       _i+0, 0
	ADDLW      _password_input+0
	MOVWF      FSR
	MOVLW      49
	MOVWF      INDF+0
L_main14:
;MyProject.c,78 :: 		if(password_input[i]==10) password_input[i] = '2' ;
	MOVF       _i+0, 0
	ADDLW      _password_input+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      10
	BTFSS      STATUS+0, 2
	GOTO       L_main15
	MOVF       _i+0, 0
	ADDLW      _password_input+0
	MOVWF      FSR
	MOVLW      50
	MOVWF      INDF+0
L_main15:
;MyProject.c,79 :: 		if(password_input[i]==11) password_input[i] = '3' ;
	MOVF       _i+0, 0
	ADDLW      _password_input+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      11
	BTFSS      STATUS+0, 2
	GOTO       L_main16
	MOVF       _i+0, 0
	ADDLW      _password_input+0
	MOVWF      FSR
	MOVLW      51
	MOVWF      INDF+0
L_main16:
;MyProject.c,80 :: 		if(password_input[i]==14) password_input[i] = '0' ;
	MOVF       _i+0, 0
	ADDLW      _password_input+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      14
	BTFSS      STATUS+0, 2
	GOTO       L_main17
	MOVF       _i+0, 0
	ADDLW      _password_input+0
	MOVWF      FSR
	MOVLW      48
	MOVWF      INDF+0
L_main17:
;MyProject.c,66 :: 		for( i = 0 ; i < 5 ; i++){
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;MyProject.c,81 :: 		}
	GOTO       L_main2
L_main3:
;MyProject.c,82 :: 		Lcd_Cmd( _LCD_CLEAR ) ;
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,83 :: 		lcd_out( 1 , 1 , password_input ) ;
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _password_input+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,84 :: 		delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_main18:
	DECFSZ     R13+0, 1
	GOTO       L_main18
	DECFSZ     R12+0, 1
	GOTO       L_main18
	DECFSZ     R11+0, 1
	GOTO       L_main18
	NOP
;MyProject.c,85 :: 		if(strcmp(password_input,"12345")==0){
	MOVLW      _password_input+0
	MOVWF      FARG_strcmp_s1+0
	MOVLW      ?lstr7_MyProject+0
	MOVWF      FARG_strcmp_s2+0
	CALL       _strcmp+0
	MOVLW      0
	XORWF      R0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main26
	MOVLW      0
	XORWF      R0+0, 0
L__main26:
	BTFSS      STATUS+0, 2
	GOTO       L_main19
;MyProject.c,86 :: 		Lcd_Cmd( _LCD_CLEAR ) ;
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,87 :: 		Lcd_out( 1 , 2 , "WELCOME");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      2
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr8_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,88 :: 		Lcd_out( 2 , 3 ,"MO3GZA");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      3
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr9_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,89 :: 		delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_main20:
	DECFSZ     R13+0, 1
	GOTO       L_main20
	DECFSZ     R12+0, 1
	GOTO       L_main20
	DECFSZ     R11+0, 1
	GOTO       L_main20
	NOP
;MyProject.c,90 :: 		goto USER_MODE ;
	GOTO       ___main_USER_MODE
;MyProject.c,91 :: 		}
L_main19:
;MyProject.c,93 :: 		count_fails ++;
	INCF       _count_fails+0, 1
	BTFSC      STATUS+0, 2
	INCF       _count_fails+1, 1
;MyProject.c,94 :: 		if( count_fails == 3 ){
	MOVLW      0
	XORWF      _count_fails+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main27
	MOVLW      3
	XORWF      _count_fails+0, 0
L__main27:
	BTFSS      STATUS+0, 2
	GOTO       L_main22
;MyProject.c,95 :: 		count_fails = 0;
	CLRF       _count_fails+0
	CLRF       _count_fails+1
;MyProject.c,96 :: 		goto SUSPENDED_MODE ;
	GOTO       ___main_SUSPENDED_MODE
;MyProject.c,97 :: 		}
L_main22:
;MyProject.c,99 :: 		Lcd_Cmd( _LCD_CLEAR ) ;
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,100 :: 		Lcd_out( 1 , 1 , "8alat ya 3ars");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr10_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,101 :: 		lcd_out(2, 1, "Tries Left: ");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr11_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,102 :: 		IntToStr( 3 - count_fails , tries_left) ;
	MOVF       _count_fails+0, 0
	SUBLW      3
	MOVWF      FARG_IntToStr_input+0
	MOVF       _count_fails+1, 0
	BTFSS      STATUS+0, 0
	ADDLW      1
	CLRF       FARG_IntToStr_input+1
	SUBWF      FARG_IntToStr_input+1, 1
	MOVLW      _tries_left+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;MyProject.c,103 :: 		tries_left[1] = tries_left[7] ;
	MOVF       _tries_left+7, 0
	MOVWF      _tries_left+1
;MyProject.c,104 :: 		lcd_out_cp( tries_left );
	MOVLW      _tries_left+0
	MOVWF      FARG_Lcd_Out_CP_text+0
	CALL       _Lcd_Out_CP+0
;MyProject.c,105 :: 		delay_ms(100) ;
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_main23:
	DECFSZ     R13+0, 1
	GOTO       L_main23
	DECFSZ     R12+0, 1
	GOTO       L_main23
	DECFSZ     R11+0, 1
	GOTO       L_main23
	NOP
;MyProject.c,106 :: 		goto USER_MODE ;
	GOTO       ___main_USER_MODE
;MyProject.c,109 :: 		ADMIN_MODE :
___main_ADMIN_MODE:
;MyProject.c,110 :: 		Lcd_Cmd( _LCD_CLEAR ) ;
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,111 :: 		Lcd_out( 1 , 1 , "ADMIN MODE");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr12_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,112 :: 		SUSPENDED_MODE :
___main_SUSPENDED_MODE:
;MyProject.c,113 :: 		Lcd_out_cp("2");
	MOVLW      ?lstr13_MyProject+0
	MOVWF      FARG_Lcd_Out_CP_text+0
	CALL       _Lcd_Out_CP+0
;MyProject.c,116 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
