%% a
x = linspace(0,1);
grc = 1/2*(1 - cos(2*pi*x));
%plot(T*x, grc) % Check the pulse for correct form
text = 'digital';
m = double(text);
b = reshape(dec2base(m, 2).', 1, []);
b(50) = 0; % Padding signal


%% 4-PAM
Apam = [-3 -1 1 3];
x = linspace(0,1);
sumAreaPam = 0;
for i = 1:49
    bstr = strcat(b(i), b(i+1));
    sig = bin2dec(bstr); %Choose signal from Apam alternatives
    plot(x, Apam(sig + 1)*grc, 'blue')
    hold on
    sumAreaPam = sumAreaPam + abs(trapz(x, Apam(sig + 1)*grc));
    x = x + 1;
    i = i + 1;
end

%% 4-PSK
vl = [0 pi/2 pi 3*pi/2];
x = linspace(0,1);
sig1 = cos(8*pi*x + vl(1));  
sig2 = cos(8*pi*x + vl(2));
sig3 = cos(8*pi*x + vl(3));
sig4 = cos(8*pi*x + vl(4));
signals1 = [sig1 sig2 sig3 sig4];
sumAreaPsk = 0;

for i = 1:49
    bstr = strcat(b(i), b(i+1));
    sig = bin2dec(bstr); %Choose signal from alternatives
    
    plot(x, grc * signals1(sig + 1), 'blue')
    hold on
    sumAreaPsk = sumAreaPsk + abs(trapz(x, grc * signals1(sig + 1)));
    x = x + 1;
    i = i + 1;
end

%% 16-QAM
% 2 4-PAM signals i equal to 16-QAM in symmetric cases

Apam = [-3 -1 1 3];
x = linspace(0,1);
sumAreaQam = 0;
for i = 1:47
    bstr1 = strcat(b(i), b(i+1));
    sig1 = bin2dec(bstr1); %Choose signal from Apam alternatives
    bstr2 = strcat(b(i+2), b(i+3));
    sig2 = bin2dec(bstr2);
    plot(x, Apam(sig1 + 1)*grc + Apam(sig2 + 1)*grc, 'blue')
    hold on
    
    sumAreaQam = sumAreaQam + abs(trapz(x, Apam(sig1 + 1)*grc + Apam(sig2 + 1)*grc));
    x = x + 1;
    i = i + 1;
end

%% 4-FSK
x = linspace(0,1);
xh = linspace(0,0.5);
sumAreaFsk = 0;

for i = 1:49
    bstr = strcat(b(i), b(i+1));
    sig = bin2dec(bstr) + 1; %Choose frequency multiplier
    plot(x, cos(2*pi*x*sig), 'blue')
    hold on
    
    sumAreaFsk = sumAreaFsk + abs(trapz(xh, cos(2*pi*xh*sig))) + abs(trapz(xh, cos(2*pi*xh*sig)));
    x = x + 1;
    i = i + 1;
    
end


%% b
% Average symbol energy should be integral / 50

EsPam = sumAreaPam * sumAreaPam / 50;
EsPsk = sumAreaPsk * sumAreaPsk / 50;
EsQam = sumAreaQam * sumAreaQam / 50;
EsFsk = sumAreaFsk * sumAreaFsk / 50;

