function validate(w,X,t)
t = floor(t/2);
%[temp_X,temp_w] =gl(t);
%temp_w = temp_w.';
rand_coeff = randn(2*t+1,t+1);
mid_idx = t+1;
for i = 1:t+1
    for j = -t:t
        if j < (-i+1) || j > (i-1)
            rand_coeff(mid_idx+j,i) = 0;
        end
    end
end

[gl_X,gl_w] = gl(t);
gl_w=gl_w.';
rand_coeff = f_hat(rand_coeff);
f = my_trans(rand_coeff,X,t);
gl_f = my_trans(rand_coeff,gl_X,t);
new_coeff = my_adj(f,X,t,w);
gl_coeff = my_adj(gl_f,gl_X,t,gl_w);

a = rand_coeff.f_hat;
b = new_coeff.f_hat;
c = gl_coeff.f_hat;

disp(["!!!",num2str(norm(a-b))]);
disp(["???",num2str(norm(a-c))]);
disp(["###",num2str(norm(b-c))]);
tilde_f = my_trans(new_coeff,X,t);
tilde_gl_f = my_trans(gl_coeff,gl_X,t);
disp(["!!!",num2str(norm(tilde_f-f))]);
disp(["???",num2str(norm(tilde_gl_f-gl_f))]);
end