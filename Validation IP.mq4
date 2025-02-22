//+------------------------------------------------------------------+
//|                                                Validación IP.mq4 |
//|                                                    Tony Programa |
//|                         https://www.instagram.com/tony_programa/ |
//+------------------------------------------------------------------+
#property copyright "Tony Programa"
#property link      "https://www.instagram.com/tony_programa/"
#property version   "1.00"
#property strict


//-----------  IP Direction  -----------//
//Page
string Page = "https://cual-es-mi-ip-publica.com/";
string header;
char post[], result[];

// IP Public Directions
string IP_Direction[] =
  {
   "190.96.247.215",
   "186.99.151.180",
   "38.180.33.173",
   "181.32.206.216"
  };

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---

   bool Permit_IP_Direction = false;
   string IP = "";
   int res = WebRequest("GET", Page, NULL, NULL, 5000, post, 0, result, header);
   if(res == -1)
      Print("Error in WebRequest. Error code  =", GetLastError());
   else
     {
      //--- Save the data to a file
      int filehandle = FileOpen("CODE.htm", FILE_WRITE | FILE_BIN);
      //--- Checking errors
      if(filehandle != INVALID_HANDLE)
        {
         //--- Save the contents of the result[] array to a file
         FileWriteArray(filehandle, result, 0, ArraySize(result));
         //--- Close the file
         FileClose(filehandle);

         for(int i = 0; i < ArraySize(result) - 9; i++)
           {
            string Key = "";
            for(int j = i; j < i + 9; j++)
               Key = Key + CharToStr(result[j]);

            if(Key == "<strong>1")
               for(int j = i + 8; j < i + 40; j++)
                  if(CharToStr(result[j]) == "<")
                     break;
                  else
                     IP = IP + CharToStr(result[j]);
           }
        }
      else
         Print("Error in FileOpen. Error code=", GetLastError());
     }

   for(int i = 0; i < ArraySize(IP_Direction); i++)
      if(IP_Direction[i] == IP)
         Permit_IP_Direction = true;

   if(!Permit_IP_Direction)
     {
      Alert("IP direction Failed");
      return(INIT_FAILED);
     }

//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---

  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---

  }
//+------------------------------------------------------------------+
