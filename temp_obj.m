function [f, g] = temp_obj(w, X, t, n)


mid_idx = t+1;
a = ones(n, 1);
temp_v = my_adj(a, X, t, w);
coeff = temp_v.f_hat;
cnt = 1;
for p = 1:t+1
    inc = p - 1;
    for q = -inc:inc
        if q < 0
            coeff(cnt, 1) = imag(coeff(cnt,1));
        else
            coeff(cnt, 1) = real(coeff(cnt,1));
        end
        cnt = cnt + 1;
        %disp(["!!!",num2str(temp_v(q+mid_idx,p))]);
    end
end
% for p = 1:size(v,1)
%     for q = 1:size(v,2)
%         disp(["###",num2str(v(p,q)),num2str(e_0(p,q))]);
%     end
% end
coeff(1,1) = coeff(1,1)-sqrt(4*pi);
% disp(["@@@",max(res)]);
f = (norm(coeff)^2)*0.5;
cnt = 1;
for p = 1:t+1
    inc = p - 1;
    for q = -inc:inc
        if q < 0
            coeff(cnt, 1) = 1i*coeff(cnt,1);
        else
            coeff(cnt, 1) = coeff(cnt,1);
        end
        cnt = cnt + 1;
    end
end
temp_v = f_hat(coeff);
g = real(my_trans(temp_v,X,t));
end