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
for i = 1:49
    bstr = strcat(b(i), b(i+1));
    sig = bin2dec(bstr); %Choose signal from Apam alternatives
    plot(x, Apam(sig + 1)*grc, 'blue')
    hold on
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
signals = [sig1 sig2 sig3 sig4];


for i = 1:49
    bstr = strcat(b(i), b(i+1));
    sig = bin2dec(bstr); %Choose signal from Apam alternatives
    
    plot(x, grc * signals(sig + 1), 'blue')
    hold on
    
    x = x + 1;
    i = i + 1;
end

%% 16-QAM
% 2 4-PAM signals i equal to 16-QAM in symmetric cases

Apam = [-3 -1 1 3];
x = linspace(0,1);
for i = 1:24
    bstr1 = strcat(b(i), b(i+1));
    sig1 = bin2dec(bstr1); %Choose signal from Apam alternatives
    bstr2 = strcat(b(i+25), b(i+26));
    sig2 = bin2dec(bstr2);
    plot(x, Apam(sig1 + 1)*grc + Apam(sig2 + 1)*grc, 'blue')
    hold on
    x = x + 1;
    i = i + 1;
end


%% b

