//+------------------------------------------------------------------+
//|                                                     EmaClose.mq4 |
//|                                  Copyright 2018, Gustavo Carmona |
//|                                           http://www.awtt.com.ar |
//+------------------------------------------------------------------+
#property copyright "Copyright 2018, Gustavo Carmona"
#property link      "http://www.awtt.com.ar"
#property version   "1.00"
#property strict

#include "OrderST.mqh"
int minutes=5;
OrderST bot(minutes);
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {

   return(INIT_SUCCEEDED);
  }

void OnTick()
  {
//---
   //bot.closeByEma(minutes, OP_SELL);
   //bot.closeByProfit(2);
   bot.closeByDistEmas(10, 60);
   
  }
//+------------------------------------------------------------------+
