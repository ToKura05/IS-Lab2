clear;
% Įėjimo masyvas
x = 0.1: 1/22: 1;

% Reikia simuliuoti tokią funkciją
y = (1 + 0.6 * sin (2 * pi * x / 0.7)) + 0.3 * sin (2 * pi * x) / 2;
%plot(x,y,'*r');

% Tinklo apibūdinimas - 4 neuronai paslėptame sluoksnyje, kurių aktyvavimo
% funkcijos - sigmoides ir hiperboliniai tangentai
% Išėjimo neurone - tiesinė aktyvavimo funkcija
% Pasirenku - pirmo ir antro neurono aktyvavimo funkcijos - sigmoidė
% Trečio ir ketvirto - hiperbolinis tangentas

%Svorių koeficientai
%w(i kuri neurona)(is kurio neurono)_(kelintas sluoksnis)

% Pirmo sluoksnio parametrai
w11_1 = randn(1);
w21_1 = randn(1);
w31_1 = randn(1);
w41_1 = randn(1);
% neuronų bazės
b1_1 = randn(1);
b2_1 = randn(1);
b3_1 = randn(1);
b4_1 = randn(1);

% Antro sluoksnio parametai
% (Iš keturiu neuronu į vieną išėjimo - antras sluoksnis)

w11_2 = randn(1);
w12_2 = randn(1);
w13_2 = randn(1);
w14_2 = randn(1);
% Išėjimo neurono bazė
b1_2 = randn(1);

% Mokymosi žingsnis
eta = 0.15;

for i = 1:30000

    for n = 1:length(x)
    
        % Pasverta suma pirmame sluoksnyje
        v1_1 = x(n) * w11_1 + b1_1;
        v2_1 = x(n) * w21_1 + b2_1;
        v3_1 = x(n) * w31_1 + b3_1;
        v4_1 = x(n) * w41_1 + b4_1;
        
        % Aktyvavimo funkcijos 
        y1_1 = 1/(1+exp(-v1_1)); % sigmoidės
        y2_1 = 1/(1+exp(-v2_1));
        y3_1 = 2/(1+exp(-2*v3_1)) - 1; %hiperboliniai tangentai
        y4_1 = 2/(1+exp(-2*v4_1)) - 1;
        
        % Pasverta suma antrame sluoksnyje
        
        v1_2 = y1_1 * w11_2 + y2_1 * w12_2 + y3_1 * w13_2 + y4_1 * w14_2 + b1_2;
        
        % Tiesinė aktyvavimo funkcija išėjimo neurone (y = x)
        
        y1_2 = v1_2;
        
        % Skaičiuojama klaida
        
        e = y(n) - y1_2;
    
        % Ryšių svoriu atnaujinimas išėjime
        % w = w + eta*delta*input;
    
        % Skaičiuojami klaidos gradientai
        % delta = e*aktyvacijos_fcijos_isvestine
    
        delta_out = e;
    
        % Pirmo sluoksnio (paslėpto) deltos
    
        delta1_1 = y1_1*(1-y1_1)*(delta_out * w11_2);
        delta2_1 = y2_1*(1-y2_1)*(delta_out * w12_2);
        delta3_1 = (1 - y3_1^2) *(delta_out * w13_2);
        delta4_1 = (1 - y4_1^2) *(delta_out * w14_2);
        %atnaujinimas
        w11_2 = w11_2 + eta*delta_out*y1_1;
        w12_2 = w12_2 + eta*delta_out*y2_1;
        w13_2 = w13_2 + eta*delta_out*y3_1;
        w14_2 = w14_2 + eta*delta_out*y4_1;
        b1_2 = b1_2 + eta*delta_out;
    
        % Ryšių svorių atnaujinimas paslėptame sluoksnyje
    
        w11_1 = w11_1 + eta * delta1_1*x(n);
        w21_1 = w21_1 + eta * delta2_1*x(n);
        w31_1 = w31_1 + eta * delta3_1*x(n);
        w41_1 = w41_1 + eta * delta4_1*x(n);
    
        b1_1 = b1_1 + eta*delta1_1;
        b2_1 = b2_1 + eta*delta2_1;
        b3_1 = b3_1 + eta*delta3_1;
        b4_1 = b4_1 + eta*delta4_1;
    end
end

% Laikome, kad po 30 tūkstančių iteracijų perėjus per visa įėjimo reikšmių
% masyvą tinklas yra apmokytas.
% Po vieną tašką braižomas norimos atvaizduoti funkcijos grafikas ir
% apmokyto tinklo išėjimo vertės palyginimui

for n = 1:length(x)
    
    % Pasverta suma pirmame sluoksnyje
    
    v1_1 = x(n) * w11_1 + b1_1;
    v2_1 = x(n) * w21_1 + b2_1;
    v3_1 = x(n) * w31_1 + b3_1;
    v4_1 = x(n) * w41_1 + b4_1;
    
    % Aktyvavimo funkcijos 
    y1_1 = 1/(1+exp(-v1_1)); % sigmoidės
    y2_1 = 1/(1+exp(-v2_1));
    y3_1 = 2/(1+exp(-2*v3_1)) - 1; %hiperboliniai tangentai
    y4_1 = 2/(1+exp(-2*v4_1)) - 1;
    
    % Pasverta suma antrame sluoksnyje
    
    v1_2 = y1_1 * w11_2 + y2_1 * w12_2 + y3_1 * w13_2 + y4_1 * w14_2 + b1_2;
    
    % Tiesinė aktyvavimo funkcija išėjimo neurone (y = x)
    y1_2 = v1_2;
    
    hold on;
    plot(x(n), y1_2, '*b',x(n), y(n),'*r');
end

legend('Aproksimacija','Norimas atsakas');








