%IHN
clc
close all
clear all
alpha=0.1;
beta=0.5;
SchR=[1,9,4,5,2];
 Nco=20;

int=1;
for cont=1:Nco
    for scheme =SchR
        X=['Sch',num2str(scheme),'Co',num2str(cont),'al',num2str(alpha),'be',num2str(beta)];
        load ([X,'.mat'])
        NrG=floor(0.002*Nd:Nd);
         MC=90;
        for k=NrG; 
            SK(k,:)=AKi(k,1:MC);
        end
        for k=NrG; 
            EK(k,:)=EC(ACT(k,1:MC));%(1./mean(SK(k,:))).*EC(ACT(k,1:MC))+10*Pc;
        end   
        mEK(cont,:,scheme)=mean(EK); 
        mSK(cont,:,scheme)=mean(SK);
%         if(cont==1)
%             figure(3)
%     plot(ACT(1,1:MC))
%     hold on
%     plot(ACT(250,1:MC))
%     plot(ACT(500,1:MC))
%         end
    end 
    %     [ME;MS] 
    
    
end

MM=1:MC;
% MMC=MM([1:5:MC]);
MMC=MM([1:floor(MC/9):MC,MC]);
for scheme=SchR
    AA= mean(mEK(:,:,scheme));
    switch(scheme)
        case(1)
            X='k-';
            Y='k+';
            Z='k-+';
        case(9)
            X='b-';
            Y='bx';
            Z='b-x';
        case(4)
            X='g-';
            Y='go';
            Z='g-o';
        case(5)
            X='m-';
            Y='m*';
            Z='m-*';
        case(6)
            X='c-';
            Y='cs';
            Z='c-s';
        case(2)
            X='r-';
            Y='rs';
            Z='r-s';
    end
    figure(1) 
    plot(MM,AA, X,'LineWidth', 1.5)
    hold on
    plot( MMC,AA(MMC),Y, 'LineWidth', 1.5 )
    plot( MMC,100*AA(MMC),Z , 'LineWidth', 1.5)
 
    
    figure(2)
    AA= mean(mSK(:,:,scheme));
    plot(MM,AA,X, 'LineWidth', 1.5)
    hold on
    plot( MMC,AA(MMC) ,Y, 'LineWidth', 1.5)
    plot( MMC,100*AA(MMC) ,Z, 'LineWidth', 1.5)
    
end

figure(1)
set(gca,'FontSize',12)
grid on
hold off
xlabel('Index of transmitted packets')
ylabel('Consumed energy per packet (J)')
legend('a','a','Alg. 1','a','a','Alg. 2','a','a','Alg. 1 (PC)','a','a','Eq. Load','a','a','Rand. Sel.')

figure(2)
set(gca,'FontSize',12)
grid on
hold off
legend('a','a','Alg. 1','a','a','Alg. 2','a','a','Alg. 1 (PC)','a','a','Eq. Load','a','a','Rand. Sel.')
xlabel('Index of transmitted packets')
ylabel('Probability of success in transmission')  