
clc
clear all 
close all
alpha=0.1;
beta=.5;
int=1;
nt=0;

Nco=20;
% % %
% % % % Parameters
P0=0;
Nd      =     500;                         % # of devices
Ra      =     2000;                          % Radius
BW      =     125000;                       % System BW
SfR     =     [7,8,9,10,11,12];             % Spread factor range
Nc      =     1;                            % # of channels
Rp      =     200;                           % Reporting period
GnTdBm  =     [-6,-9,-12,-15,-17.5,-20];    % Threshold SNR dB
GnT     =     10.^(GnTdBm/10);              % Threshold SNR dB
%     GiT     =     4;                            % Threshold SIR; 6 dB stronger than strongest
CR      =     4/5;                          % Code rate
Rd      =     SfR.*BW.*CR./(2.^SfR);         % Data rate 
Ps      =     20*8;                        % Bits
Tt      =     floor(Ps./(Rd)*1000);                     % Transmission time
Tt=Tt(3)*ones(1,6);
% PtR     =     [2 5 8 11 14];                % Trans Pow. range
PtR     =     [8 14]-30 ;                         % Trans Pow. range
IPAI    =     2;                            % Inv. Pow. Amp. Eff.
Pc      =     0.01;                         % Circuit power
PT      =     IPAI*(10.^(PtR/10))+Pc;  % Total power Cons.
SimT    =     35000;                        % Symulation time
Np      =     floor(SimT/Rp);
DataI   =     zeros(Nd,Np);
Th= 4 ;%3 dB 

tic
PI=zeros(length(SfR),SimT*1000);
if(int==1)
    AR1=randperm((SimT+1000)*1000 ,floor(0.05*(SimT+1000)*1000 ));
    PI(1,AR1)=1e5;
    AR2=randperm((SimT+1000)*1000 ,floor(0.004*(SimT+1000)*1000 ));
    PI(2,AR2)=1e5;
    AR3=randperm((SimT+1000)*1000 ,floor(0.001*(SimT+1000)*1000 ));
    PI(3,AR3)=1e5;
    AR4=randperm((SimT+1000)*1000 ,floor(0.0004*(SimT+1000)*1000 ));
    PI(4,AR4)=1e5;
    AR5=randperm((SimT+1000)*1000 ,floor(0.008*(SimT+1000)*1000 ));
    PI(5,AR5)=1e5;
    AR6=randperm((SimT+1000)*1000 ,floor(0.006*(SimT+1000)*1000 ));
    PI(6,AR6)=1e5;
end
toc
PI0=PI;

for cont=1:Nco
    Dt=[];
    Rf=zeros(1,Nd);
    for j=1:Nd
        DataI(j,:)=sort(randperm(SimT*1000,Np));
        A=DataI(j,:);
        for ij=2:Np
            if(A(ij)-A(ij-1)<2*max(Tt))
                A(ij)=A(ij-1)+2*max(Tt);
            end
        end
        DataI(j,:)=A;
        Dt=[Dt,DataI(j,:)];
        Rf(j)=(Ra*sqrt(rand(1,1)));
    end
    Rf=sort(Rf);
    sDt=sort(Dt);
     
    save(['dataee','.mat'],'BW','DataI','GnT','IPAI','Nd','Np','Pc','PT','PtR','Ra','Rd','Rf','Rp','sDt','SfR','SimT','Th','Tt')
%     FuSch1(alpha,beta,PI0,cont,nt)
%     FuSch2(alpha,beta,PI0,cont,nt)
%     FuSch3(alpha,beta,PI0,cont,nt)
%     FuSch4(alpha,beta,PI0,cont,nt)
%     FuSch5(alpha,beta,PI0,cont,nt)
%     FuSch6(alpha,beta,PI0,cont,nt)
FuSch9(alpha,beta,PI0,cont,nt)
end
