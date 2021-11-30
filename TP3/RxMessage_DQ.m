function [RxMsg,Xp,RxBinMsg] = RxMessage_DQ(X,Xp)

% [RxMsg,Xp,RxBinMsg] = RxMessage_DQ(X,Xp)     performs a Quadratic
% Detection of binary message conveyed in signal structure X. Xp is a structure 
% that contains all parameters related to the transmission. X and Xp are
% usually the output of routine TxMessage

% PG : octobre 2014 (CPE)

if ~isfield(Xp,'Dnu')
    Xp = setfield(Xp,'Dnu',16) ;
end
if ~isfield(Xp,'RCxDnu')
    Xp = setfield(Xp,'RCxDnu',20) ;
end

newDnu = input(['Bandwidth (bandpass filter) [',num2str(Xp.Dnu),'] = ']) ;
newRCxDnu = input(['Product RC x Dnu [',num2str(Xp.RCxDnu),'] = ']) ;
if isempty(newDnu), newDnu = Xp.Dnu ; end
if isempty(newRCxDnu), newRCxDnu = Xp.RCxDnu ; end

while ~isempty(newDnu) | ~isempty(newRCxDnu)
    
    if ~isempty(newDnu), Dnu = newDnu ; end
    if ~isempty(newRCxDnu), RCxDnu = newRCxDnu ; end
    
    RC  = RCxDnu / Dnu ;
    disp(['RC constant = ',num2str(RC),' s.']) ;
    Xp.BPForder = 2 ;
    Fp = struct('Fs',Xp.Fs,'F0',Xp.Fc,'Dnu',Dnu,'order',Xp.BPForder,'class','BP filter') ;
    figure(2), clf
    [Y] = BPF(X,Fp) ;
    [Z] = SquareSig(Y) ;

    RCFp = struct('Fs',Xp.Fs,'RC',RC) ;
    figure(2), clf
    [W] = RCF(Z,RCFp) ;

    figure(2), clf,
    % plot(M.time,M.data), 
    hold on
    plot(W.time,W.data,'r')
    YLim = get(gca,'Ylim') ;
    axis([-Inf Inf YLim(1)-0.1 YLim(2)+0.1])    
        % Lecture du niveau a 90% de la periode du bit
    tsync_begin = (0:Xp.Nbit-1).*(Xp.PeriodPerBit/Xp.Fc) ;
    tsync = (0:Xp.Nbit-1).*(Xp.PeriodPerBit/Xp.Fc)+(0.9*Xp.PeriodPerBit)/Xp.Fc ;
    for k=1:Xp.Nbit ;
        nsync(k) = find(W.time >= tsync(k), 1, 'first') ;
    end
    set(gca,'Xtick',tsync_begin), grid
    set(gca,'XTickLabel',[]) 
    plot(tsync,W.data(nsync),'+k')

%     newrho = (max(W.data)+min(W.data))/2 ; % set a threshold arbitrarilly...
    newrho = input(['Set a threshold (',num2str(min(W.data)),' < Sigma < ',num2str(max(W.data)),') : '])  
    hh = plot([W.time(1) W.time(end)],[newrho newrho],'-.m','linewidth',2) ;
    texthandle = text(tsync,zeros(1,Xp.Nbit),'x') ;

    while ~isempty(newrho)
        rho = newrho ;
        set(hh,'YData',[rho rho]) ;
        RxBinMsg = double(W.data(nsync) > rho) ;
        for j=1:length(texthandle)
            set(texthandle(j),'string',num2str(RxBinMsg(j))) ;
        end
        RxByte = reshape(RxBinMsg, Xp.Nbit/Xp.Nchar, Xp.Nchar)' ;
        RxMsg = '' ;
        for k=1:Xp.Nchar
            RxChar =  bin2int(RxByte(k,:)) ;
            if RxChar == 32, RxChar = 31; end
            RxMsg = strcat(RxMsg,char(RxChar)) ;
        end
        disp(['Received message ---> ',RxMsg])
        newrho = input(['New threshold value [',num2str(newrho),'] ? = ']) ;
    end

    newDnu = input(['Bandwidth (bandpass filter) [',num2str(Dnu),'] = ']) ;
    newRCxDnu = input(['Product RC x Dnu [',num2str(RCxDnu),'] = ']) ;

end

Xp.Dnu = Dnu ;
Xp.RCxDnu = RCxDnu ;
Xp.RC = RC ;
Xp.rho = rho ;

