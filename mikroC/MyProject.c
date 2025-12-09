// --- LCD Connections ---
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

char keypadPort at PORTB;

// --- Global Variables (RAM) ---
char ADMIN_KEY[5] = "0000";
char password_input[5];
char stored_pass[5];
char str[7];
short tries_left = 3;
short user = 0, admin = 0;
short i = 0;
short seconds = 60;
short slot = 0;
short addr = 0;
short match_found = 0;
char key;
short is_full = 1;
short id = 0;

// --- Constant Messages (Stored in ROM to save RAM) ---
const char msg_new_user[] = "New User Key:";
const char msg_mem_full[] = "Memory Full!";
const char msg_saving[] = "Saving...";
const char msg_saved[] = "User Saved!";
const char msg_userid[] = "USER ID: ";
const char msg_user_key[] = "User Key:";
const char msg_deleting[] = "Deleting ...";
const char msg_deleted[] = "USER Deleted";
const char msg_user_mode[] = "USER MODE";
const char msg_enter_key[] = "Enter Key:";
const char msg_welcome[] = "WELCOME";
const char msg_access[] = "ACCESS GRANTED";
const char msg_wrong[] = "Wrong Password";
const char msg_tries[] = "Tries Left: ";
const char msg_admin_mode[] = "ADMIN MODE";
const char msg_enter_admin[] = "Enter ADMIN Key:";
const char msg_elhefnawy[] = "ELHEFNAWY";
const char msg_opt1[] = "1- ADD USER";
const char msg_opt2[] = "2- DELETE USER";
const char msg_locked[] = "SYSTEM LOCKED";
const char msg_timer[] = "SECONDS LEFT: ";
const char msg_main_welcome[] = "Welcome!!";
const char msg_empty[] = " ";

// --- Helper for Printing ROM Strings ---
char txt_buffer[17];
void Lcd_Out_Const(char row, char col, const char *text)
{
    char i;
    for (i = 0; i < 16 && text[i]; i++)
    {
        txt_buffer[i] = text[i];
    }
    txt_buffer[i] = '\0';
    Lcd_Out(row, col, txt_buffer);
}

enum SystemState
{
    STATE_LOGIN,
    STATE_ADMIN,
    STATE_LOCKED
};

enum SystemState current_state = STATE_LOCKED;

char get_mapped_key()
{
    key = keypad_key_Click();
    if (key == 0)
        return 0;
    if (key == 16)
        return 'M';
    if (key == 1)
        return '7';
    if (key == 2)
        return '8';
    if (key == 3)
        return '9';
    if (key == 5)
        return '4';
    if (key == 6)
        return '5';
    if (key == 7)
        return '6';
    if (key == 9)
        return '1';
    if (key == 10)
        return '2';
    if (key == 11)
        return '3';
    if (key == 14)
        return '0';
    return 0;
}

void add_user()
{
    i = 0;
    id = 0;
    slot = 0;
    addr = 0;
    is_full = 1;

    lcd_cmd(_LCD_CLEAR);
    Lcd_Out_Const(1, 1, msg_new_user);
    Lcd_Out_Const(2, 1, msg_empty);

    memset(password_input, 0, 5);
    for (i = 0; i < 4; i++)
    {
        do
        {
            key = get_mapped_key();
        } while (key == 0);

        if (key == 'M')
        {
            current_state = STATE_ADMIN;
            return;
        }
        password_input[i] = key;
        Lcd_Chr_Cp('*');
    }

    for (slot = 0; slot < 64; slot++)
    {
        addr = slot * 4;
        if (EEPROM_Read(addr) == 0xFF)
        {
            is_full = 0;
            break;
        }
        id++;
    }

    if (is_full)
    {
        lcd_cmd(_LCD_CLEAR);
        Lcd_Out_Const(1, 1, msg_mem_full);
        delay_ms(1000);
        return;
    }

    Lcd_Cmd(_LCD_CLEAR);
    Lcd_Out_Const(1, 1, msg_saving);

    for (i = 0; i < 4; i++)
    {
        EEPROM_Write(addr + i, password_input[i]);
        delay_ms(20);
    }
    ByteToStr(id, str);
    Ltrim(str);
    Lcd_Out_Const(1, 1, msg_saved);
    Lcd_Out_Const(2, 1, msg_userid);
    if (id < 10)
        Lcd_Chr_Cp('0');
    lcd_out_cp(str);
    delay_ms(1000);
}

void delete_user()
{
    i = 0;
    id = 0;
    slot = 0;
    addr = 0;

    Lcd_Cmd(_LCD_CLEAR);
    Lcd_Out_Const(1, 1, msg_userid);

    for (i = 0; i < 2; i++)
    {
        do
        {
            key = get_mapped_key();
        } while (key == 0);

        if (key == 'M')
        {
            current_state = STATE_LOGIN;
            return;
        }
        id = id * 10 + (key - '0');
        Lcd_Chr_Cp('*');
    }

    addr = id * 4;
    EEPROM_Write(addr, 0xff);
    Lcd_Out_Const(1, 1, msg_deleting);
    delay_ms(20);
    Lcd_Out_Const(1, 1, msg_deleted);
    delay_ms(1000);
}

void login_mode()
{
    i = 0;
    slot = 0;
    addr = 0;
    match_found = 0;

    Lcd_Cmd(_LCD_CLEAR);
    portC.f1 = 0;
    portC.f2 = 1;
    if (!user)
    {
        Lcd_Out_Const(1, 1, msg_user_mode);
        delay_ms(200);
        user = 1;
        admin = 0;
    }
    Lcd_Out_Const(1, 1, msg_enter_key);

    memset(password_input, 0, sizeof password_input);
    memset(stored_pass, 0, sizeof stored_pass);

    for (i = 0; i < 4; i++)
    {
        do
        {
            key = get_mapped_key();
        } while (key == 0);

        if (key == 'M')
        {
            current_state = STATE_ADMIN;
            return;
        }
        password_input[i] = key;
        Lcd_Chr_Cp('*');
    }

    for (slot = 0; slot < 64; slot++)
    {
        addr = slot * 4;

        if (EEPROM_Read(addr) == 0xFF)
            continue;

        for (i = 0; i < 4; i++)
        {
            stored_pass[i] = EEPROM_Read(addr + i);
            delay_ms(10);
        }

        if (strcmp(password_input, stored_pass) == 0)
        {
            match_found = 1;
            break;
        }
    }

    if (match_found)
    {
        Lcd_Cmd(_LCD_CLEAR);
        Lcd_Out_Const(1, 2, msg_welcome);
        Lcd_Out_Const(2, 3, msg_access);
        portC.f1 = 1;
        portC.f2 = 0;
        delay_ms(200);
        tries_left = 3;
    }
    else
    {
        tries_left--;
        if (tries_left <= 0)
        {
            current_state = STATE_LOCKED;
            return;
        }

        Lcd_Cmd(_LCD_CLEAR);
        Lcd_Out_Const(1, 1, msg_wrong);

        Lcd_Out_Const(2, 1, msg_tries);
        ByteToStr(tries_left, str);
        Ltrim(str);
        Lcd_out_cp(str);
        delay_ms(200);
    }
}

void admin_mode()
{
    i = 0;
    Lcd_Cmd(_LCD_CLEAR);
    portC.f1 = 0;
    portC.f2 = 0;
    if (!admin)
    {
        Lcd_Out_Const(1, 1, msg_admin_mode);
        delay_ms(100);
        admin = 1;
        user = 0;
    }

    Lcd_Out_Const(1, 1, msg_enter_admin);
    Lcd_Out_Const(2, 1, msg_empty);
    memset(password_input, 0, sizeof password_input);

    for (i = 0; i < 4; i++)
    {
        do
        {
            key = get_mapped_key();
        } while (key == 0);

        if (key == 'M')
        {
            current_state = STATE_LOGIN;
            return;
        }
        password_input[i] = key;
        Lcd_Chr_Cp('*');
    }

    if (strcmp(password_input, ADMIN_KEY) == 0)
    {
        Lcd_Cmd(_LCD_CLEAR);
        Lcd_Out_Const(1, 2, msg_welcome);
        Lcd_Out_Const(2, 3, msg_elhefnawy);
        delay_ms(200);
        tries_left = 3;
        Lcd_Out_Const(1, 1, msg_opt1);
        Lcd_Out_Const(2, 1, msg_opt2);
        do
        {
            key = get_mapped_key();
        } while (key == 0);
        if (key == '1')
            add_user();
        else
            delete_user();
    }
    else
    {
        tries_left--;
        if (tries_left <= 0)
        {
            current_state = STATE_LOCKED;
            return;
        }

        Lcd_Cmd(_LCD_CLEAR);
        Lcd_Out_Const(1, 1, msg_wrong);

        Lcd_Out_Const(2, 1, msg_tries);
        ByteToStr(tries_left, str);
        Ltrim(str);
        Lcd_out_cp(str);
        delay_ms(200);
    }

    current_state = STATE_LOGIN;
}

void suspended_mode()
{

    Lcd_Cmd(_LCD_CLEAR);
    Lcd_Out_Const(1, 1, msg_locked);
    Lcd_Out_Const(2, 1, msg_timer);
    portc.f0 = 1;
    portc.f2 = 1;
    seconds = 60;

    while (seconds > 0)
    {
        Lcd_out(2, 15, "  ");
        ByteToStr(seconds, str);
        Ltrim(str);
        Lcd_out(2, 15, str);
        i = 0;
        while (i < 31)
        {
            if (INTCON.TMR0IF == 1)
            {
                INTCON.TMR0IF = 0;
                i++;
            }
        }
        seconds--;
    }
    current_state = STATE_LOGIN;
}

// --- MAIN FUNCTION ---
void main()
{

    OPTION_REG = 0b10000111;
    TMR0 = 0;
    INTCON.TMR0IF = 0;

    trisc = 0;
    portc = 0;
    portc.f2 = 1;

    Lcd_Init();
    keypad_Init();
    Lcd_Cmd(_LCD_CURSOR_OFF);
    Lcd_Cmd(_LCD_CLEAR);

    Lcd_Out_Const(1, 1, msg_main_welcome);
    delay_ms(200);

    while (1)
    {
        switch (current_state)
        {
        case STATE_LOGIN:
            login_mode();
            break;

        case STATE_ADMIN:
            admin_mode();
            break;

        case STATE_LOCKED:
            suspended_mode();
            break;
        }
    }
}