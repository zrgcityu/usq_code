%%
clc
clear
% addpath ../matlab-nfft-3.3.1-core2-openmp/nfsft
addpath ../nfsft

diapath = [pwd,'/log/'];
format long;
% pointpath = [pwd,'/point/'];
% rng('default');
%%
multiplier_list = linspace(4,4,1);
t_list = [512];
%t_list = linspace(120,500,39);
%r_seed = [0];
r_seed = [1];
% t_list = [16];
for p = 1:size(t_list,2)
    t = t_list(1,p);
    %t = ceil(t_list(1,p));
    for m = 1:size(multiplier_list,2)
        c = multiplier_list(1,m);
        n = ceil(c*((t+1)^2));
        %temp_diapath = [diapath,num2str(t),'/',num2str(c),'.txt'];
        temp_diapath =[diapath,num2str(t),'_',num2str(c),'.txt'];
        diary(temp_diapath);
        diary on
        for q = 1:size(r_seed,2)
            rand('seed',r_seed(1,q));
            randn('seed',r_seed(1,q));
            %c = multiplier_list(1,m);
            %n = 3000000;
            
            
            longtitude = 2*pi*rand(1,n); %longtitude = azimuth
            colatitude = acos(2*rand(1,n)-1); %colatitude = inclination, latitude = elevation
            X = [longtitude;colatitude];
            W = (4*pi/n).*ones(1,n);
            %W = zeros(1,n);
            W = W.';
            
            
            tolx = eps;
            tolf = 0;
            tolg = eps;
            maxIter = 200;
            options = optimoptions('fmincon','Display','iter','Algorithm','trust-region-reflective',...
                'SpecifyObjectiveGradient',true,'HessianMultiplyFcn',@HessMultFcn,...
                'MaxIterations',maxIter,'TolX',tolx,'TolFun',tolf,'OptimalityTolerance', tolg);
            
            % [temp_f,tempg,temp_H] = obj(W,X,t,n);
            % disp(["???",num2str(temp_f)]);
            %%
            
            A = [];
            b = [];
            Aeq = [];
            beq = [];
            %lb = ones(size(W)).*(-4*pi*((1/n)+(9/sqrt(n)))*2);
            %ub = ones(size(W)).*(4*pi*((1/n)+(9/sqrt(n)))*2);
            lb = zeros(size(W));
            ub = ones(size(W)).*(4*pi/(((t/2)+1)^2));
            %lb = [];
            %ub = [];
            nonlcon = [];
            tStart = tic;
            
            [ss, fs, flag, outputlog] = fmincon('obj', W, A, b, Aeq, beq, lb, ub, nonlcon, options, X, t, n);
            
            
            tEnd = toc(tStart);
%           diary(temp_diapath);
%           diary on
            validate(ss,X,t);
            [temp_f,temp_g] = temp_obj(ss,X,t,n);
            fprintf('Elapsed time is: %f seconds\n', (tEnd));
            fprintf('FMINUNC: flag = %d\n', flag);
            fprintf('f^{1/2} = %.6e', sqrt(temp_f*2));
            fprintf(', ||g||_inf = %.6e\n', norm(temp_g,inf));
            
%             w_affix = [num2str(t),'_weight_4.dat'];
%             p_affix = [num2str(t),'_point_4.dat'];
%             save([pointpath,w_affix],'ss','-ascii');
%             save([pointpath,p_affix],'X','-ascii');
            
        end
        diary off;
    end
end
%disp(num2str(ss));