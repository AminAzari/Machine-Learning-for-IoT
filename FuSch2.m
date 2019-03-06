function FuSch2(alpha,beta,PI,cont,nt)
scheme=2;
load dataee.mat
PtR     =     PtR(2);                         % Trans Pow. range
PT      =     PT(2);  % Total power Cons.
ij=0;
cop=0;
for i=1:length(SfR)
    for j=1:length(PtR)
        ij=ij+1;
        action(ij,1)=i;
        action(ij,2)=j;
    end
end
AC=[1:ij];
for ijc=1:length(SfR)*length(PtR)
    EC(ijc)=PT(action(ijc,2))*Tt(action(ijc,1))/1000;
end

HoQ=DataI(:,1);
CoI=ones(1,Nd);

AKi=zeros(Nd,Np);
ACT=zeros(Nd,Np);
co=0;
% alpha           = .1;
% Nen=length(SfR)*length(PtR);
% Tun               = zeros(Nd,Nen);
% Sun               = zeros(Nd,Nen);       % sum of rewards X =S/T;
AK=0;Ak1=0;Ak2=0;
% mu=ones(1,Nd);
% fSf=funS(Rf,Nd,Tt);
% fSfq=funSq(Rf,Nd,Tt);
% We(1:Nd,1:length(AC))=1;
% Prs(1:Nd,1:length(AC))=1/length(AC);
for j=1:floor(0.9*Np*Nd)
    if(mod (j,50000)==0)
        %                 [scheme, j/(Np*Nd), sum(AK)/co, sum(Ak1)/co, sum(Ak2)/co]
        [cont,scheme, j/(0.9*Np*Nd),cop]
    end
    fH=find(HoQ==sDt(j));
    
    if (isempty(fH))
        fH1=randperm(Nd,1);
        cop=cop+1;
    else
        fH1=fH(1);
    end
    
    if(CoI(fH1)==1)
        aci=randperm(length(AC),1);
        
        sfi=action(aci,1);
        Pot=PtR(action(aci,2));
        %         Tun(fH1,aci)=Tun(fH1,aci)+1;
    elseif(CoI(fH1)>1)
        N=10^(-20.4)*BW;
        co=co+1;
        
        Ak1(j)=(PIs(fH1))/N>GnT(action(acs(fH1),1));
        Ak2(j)=Ts(fH1)*0.001* PIs(fH1)/...
            abs(sum(0.001*(PI(action(acs(fH1),1),Tss(fH1):Tss(fH1)+Ts(fH1)-1)))-Ts(fH1)*0.001*(PIs(fH1)))>Th;
         
        AK(Jj(fH1))=and(Ak1(j), Ak2(j));
          
        
        ACT(fH1,CoI(fH1)-1)=acs(fH1);
        
        AKi(fH1,CoI(fH1)-1)=AK(Jj(fH1));
        
        
        ECi=EC(acs(fH1));
        EA=min(EC)/ECi;
        
        if(scheme==2)
            aci=randperm(length(AC),1);
            
            sfi=action(aci,1);
            Pot=PtR(action(aci,2));
            
        end
        % %         Tun(fH1,aci)                  = Tun(fH1,aci)+1;
        % %         %         sfi=randperm(6,1);
        % %         sfi=action(aci,1);
        % %         Pot= PtR(action(aci,2));
        
    end
    tau=Tt(sfi);
    Plu=133+38.3*log10(Rf(fH1)/1000)+10*log10(exprnd(1.775,1,1));
    PI(sfi,DataI(fH1,CoI(fH1)):DataI(fH1,CoI(fH1))+tau-1)=PI(sfi,DataI(fH1,CoI(fH1)):DataI(fH1,CoI(fH1))+tau-1)+...
        (10.^((Pot-Plu)/10))*ones(1,tau);
    
    PIs(fH1)=10^((Pot-Plu)/10);
    Ts(fH1)=tau;
    Tss(fH1)=DataI(fH1,CoI(fH1));
    acs(fH1)=aci;
    Jj(fH1)=j;
    if(CoI(fH1)<Np)
        CoI(fH1)=CoI(fH1)+1;
        HoQ(fH1)=DataI(fH1,CoI(fH1));
    end
end


X=['Sch',num2str(scheme),'Co',num2str(cont),'al',num2str(alpha),'be',num2str(beta)];
save([X,'.mat'],'Nd', 'ACT','AKi','EC','alpha','beta','Rf')