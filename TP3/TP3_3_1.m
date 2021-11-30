close all;
clc;
clear variables;

load SignalRecu_2.mat

[TxMsg,Xp] = RxMessage_DQ(X,Xp);