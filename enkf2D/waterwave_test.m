% grid size
n=64;
% initialization
H = ones(n,n);   
U = zeros(n,n); 
V = zeros(n,n);



for i = 1:100
    H = H + droplet(1,n);
    figure(1);
    surf(H);
    [H,U,V]=waterwave(H,U,V,0.01,1,1,100);
    figure(2);
    surf(H);
end
   