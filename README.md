Implementation of the paper "On the Probability Estimates of Quadrature Rules from
Uniformly Sampled Points on Spheres". Codes are based on a modified matlab version of [NFFT] (https://www-user.tu-chemnitz.de/~potts/nfft/) used in [Spherical Framelets from Spherical Designs](https://epubs.siam.org/doi/10.1137/22M1542362). 
To obtain this modified version (a folder 'nfsft'), please send request to xzhuang7@cityu.edu.hk.

Some comments:

1. Create 2 folders named 'log' and 'point', and run script 'main.m' to obtain quadrature rules (uncomment certain lines to store nodes and weights of the rules). The constant c of c*(1+t)^2 is stored in 'multiplier list' and the degree t in 't_list'. Experiments in 
Table 1 used random seed 0. Table 2 used seeds 1,2,3,4. There are two sets of lower and upper bounds of the weights, choose one to run.

2. The script 'validate.m' is for comparing the reconstruction results with the Gauss-Legendre tensor product rule upon a random linear combination of spherical harmonics.

3. Codes were tested using MATLAB R2021b. MATLAB Optimization Toolbox required.