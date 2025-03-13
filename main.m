clear all;
clc;

% Unilateral figure of merit: U(S) < 0.05 => unilateral approximation OK
% Stability: Unconditionally stable if |Delta(m)| < 1 and K > 1

Z0 = 50; % OBS! Change for different characteristic impedance

S11 = 0.8;
S12 = 3;
S21 = 5;
S22 = 7;

angS11 = (pi/180)*(-90);
angS12 = (pi/180)*(4);
angS21 = (pi/180)*(6);
angS22 = (pi/180)*(-90);

S = [[S11,S12];[S21,S22]];
angS = [[angS11,angS12];[angS21,angS22]];

%% Stability check
%d = Delta(S);
%k = K(S);
%u = U(S);

%% Two-port power gain

%GT = GS*G0*GL

function p2c = Polar2cart(S, angS)
    p2c = [[S(1,1)*cos(angS(1,1)), S(1,1)*sin(angS(1,1))], [S(1,2)*cos(angS(1,2)), S(1,2)*sin(angS(1,2))]; [S(2,1)*cos(angS(2,1)), S(2,1)*sin(angS(2,1))], [S(2,2)*cos(angS(2,2)), S(2,2)*sin(angS(2,2))]]
end


function d = Delta(m)
    d = m(1,1)*m(2,2) - m(1,2)*m(2,1);
end

function k_return = K(m)
    k_return = (1 - abs(m(1,1))^2 - abs(m(2,2))^2 + abs(Delta(m))^2)/(2*abs(m(1,2)*m(2,1)));
end

function u_return = U(m)
    u_return = (abs(m(1,1))*abs(m(1,2))*abs(m(2,1))*abs(m(2,2)))/((1-abs(m(1,1)^2)*(1-abs(m(2,2))^2)));
end

function gamma_in = Gamma_in(S,gamma_l)
    gamma_in = S(1,1) + (S(1,2)*S(2,1)*gamma_l)/(1 - S(1,1)*gamma_l);
end

function gamma_out = Gamma_out(S,gamma_s)
    gamma_out = S(2,2) + (S(1,2)*S(2,1)*gamma_s)/(1 - S(1,1)*gamma_s);
end

function gamma = Gamma(Z)
    gamma = (Z - Z0)/(Z + Z0);
end

function gs = Gs(gamma_in, gamma_s)
    gs = (1 - abs(gamma_s)^2)/(abs(1-gamma_in*gamma_s)^2);
end

function g0 = G0(S)
    g0 = abs(S(2,1))^2;
end

function gl = GL(S,gamma_l)
    gl = (1-abs(gamma_l)^2)/(abs(1-S(2,2)*gamma_l));
end

%function mt = Mult_polar(mag1,ang1,mag2,ang2)
%    mt = [mag1*mag2,ang1+ang2];
%end

function f = F()

