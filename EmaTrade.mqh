//+------------------------------------------------------------------+
//|                                                      OrderST.mqh |
//|                                  Copyright 2018, Gustavo Carmona |
//|                                         thttps://www.awtt.com.ar |
//+------------------------------------------------------------------+
#property copyright "Copyright 2018, Gustavo Carmona"
#property link      "thttps://www.awtt.com.ar"
#property version   "1.00"
#property strict
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class emaTrade
  {
private:
   double balance;
   bool emaShortIsLow;
   bool        emaShortLow(int );
   
public:
               emaTrade(int period);
   double      getBid();
   int         buy(double stoploss);
   int         sell(double stoploss);
   double      getProfit();
   void        closeByProfit(double profitInDollars);
   void        closeByEma(int period, int orderType );
   void        closeByDistEmas(int pips);
  };
//+------------------------------------------------------------------+


emaTrade::emaTrade(int period){
   emaShortIsLow = emaShortLow(period);
      
}

double emaTrade::getBid(void){
   return Bid;
   }
   
 int emaTrade::buy(double stoploss){
   int numOrder;
   numOrder = OrderSend(Symbol(),OP_BUY,0.01,Ask,10, Ask-stoploss, 0);
   return numOrder;
 
   }
   
 int emaTrade::sell(double stoploss){
   int numOrder;
   numOrder = OrderSend(Symbol(),OP_SELL,0.01,Bid,10, Bid+stoploss, 0);
   return numOrder;
 
   }
 
  void emaTrade::closeByProfit(double profitInDollars){
      double price, sumProfit;
      int t = OrdersTotal();
      for(int i=t-1;i>=0;i--){
         if(OrderSelect(i, SELECT_BY_POS)){
            if(OrderSymbol() == "USDJPY"){
               sumProfit = OrderProfit()+OrderCommission()+OrderSwap();
               if(sumProfit>=profitInDollars){
                  if(OrderType()==OP_BUY){
                     price = Bid; }
                  else {
                     price = Ask;}
                  
               
               if(!OrderClose(OrderTicket(),OrderLots(),price,10))
                  Comment("Error close ticket: ", OrderTicket());
                  }//sumProfit>profitInDollars
            }//OrderSymbol
            }//for
       }
      return; 
  
      }
      
  void emaTrade::closeByEma(int period, int orderType){
      double price;
      int t = OrdersTotal();
      for(int i=t-1;i>=0;i--){
         if(OrderSelect(i, SELECT_BY_POS)){
            if(OrderSymbol() == "USDJPY"){
               if(emaShortLow(period) != emaShortIsLow){
                  if(OrderType()==OP_BUY){
                     price = Bid; }
                  else {
                     price = Ask;}
               
               emaShortIsLow = emaShortLow(period);   
               Print("emaShortLow(5) ", emaShortLow(period));
               Print("\n emaShortIsLow ", emaShortIsLow);
               Print(" \n ******************** ");
               if(OrderType()==orderType){
                  //close
                  if(!OrderClose(OrderTicket(),OrderLots(),price,10))
                     Comment("Error close ticket: ", OrderTicket());
                     }//sumProfit>profitInDollars
                   }//orderType
            }//OrderSymbol
            }//for
       }
      return; 
  
      }
  
  bool emaTrade::emaShortLow(int period){
      double shortMA, longMA;
   shortMA = iMA(Symbol(),period,10,0,MODE_EMA,PRICE_CLOSE,1);
   longMA = iMA(Symbol(),period,50,0,MODE_EMA,PRICE_CLOSE,1);
   if(shortMA<longMA)
      return true;
   else
      return false;
  
  
      }
      
 void closeByDistEmas(int pips, int period, int ticket){
    double shortMA, longMA;
   shortMA = iMA(Symbol(),period,10,0,MODE_EMA,PRICE_CLOSE,1);
   longMA = iMA(Symbol(),period,50,0,MODE_EMA,PRICE_CLOSE,1);
   if(MathAbs(shortMA-longMA)<=(pips*0.0001)){
      closeByTicket(ticket);
      }
   
  
 
 
   }