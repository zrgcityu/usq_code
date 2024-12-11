function g = ATA(vec,X,t,n)

a = ones(n,1);
temp_v = my_adj(a, X, t, vec);
coeff = temp_v.f_hat;
mid_idx = t+1;
cnt = 1;
for p = 1:t+1
    inc = p - 1;
    for q = -inc:inc
        if q < 0
            coeff(cnt, 1) = 1i*imag(coeff(cnt,1));
        else
            coeff(cnt, 1) = real(coeff(cnt,1));
        end
        cnt = cnt + 1;
    end
end
temp_v = f_hat(coeff);

g = real(my_trans(temp_v,X,t));

end