function varout = my_adj(f, X, t, w)


% threshold (affects accuracy, 1000 is the default)
kappa = 2000;
% NFFT cutoff parameter (default 6)
nfft_cutoff = 9;
M = size(X,2); 
% Create plan of class NFSFT.
% plan = nfsft(t,M,NFSFT_NORMALIZED, kappa, nfft_cutoff);

% Create plan of class NFSFT.
plan = nfsft(t,M,NFSFT_NORMALIZED);

% Set nodes. x = [phi; theta]
plan.x = X; 

% Select f
plan.f = f.*w;

% Adjoint transform
nfsft_adjoint(plan);

% Output
varout = plan.fhat;
% disp(["!!!",size(varout,1),size(varout,2)]);
end