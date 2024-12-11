function varout = my_trans(f_hat,X,t)


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

% Select fh
plan.fhat = f_hat;

% NFSFT transform
nfsft_trafo(plan);

% Output
varout = plan.f;
% disp(["!!!",size(varout,1),size(varout,2)]);
end