% I think this  should work but I havent had anything to check against to
% make sure

function ploteigenvector(L,ev,ne,nsub,scale)

nv=ne*nsub+1;
Le=L/ne;
dx=Le/nsub;
k=1;
X=zeros(1,nv);
V=zeros(1,nv);
for e=1:ne 
    %loop over elements    
    xi=Le*(e-1); 
    vi=ev(2*e-1); 
    qi=ev(2*e); 
    vj=ev(2*e+1); 
    qj=ev(2*e+2);    
    for n=1:nsub 
        %// loop over subdivisions        
        xk=xi+dx*n; 
        x=(2*n-nsub)/nsub; %// isoP coordinate 
        vk=scale*(0.125*(4*(vi+vj)+2*(vi-vj)*(x^2-3)*x+Le*(x^2-1)*(qj-qi+(qi+qj)*x))); % Hermitian interpolant      
                
        k = k+1; 
        X(k)=xk;
        V(k)=vk; 
               
    end  
end 
 plot(X,V)