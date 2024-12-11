function [W] = HessMultFcn(H,vec,X,t,n)

W = zeros(size(vec,1),size(vec,2));
for i = 1:size(vec,2)
    W(:,i) = ATA(vec(:,i),X,t,n);
end
%disp(["%%%",num2str(size(W,1)),num2str(size(W,2))]);
end