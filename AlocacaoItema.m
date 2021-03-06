clc
A= [1 1 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0; 
    0 0 0 0 0 1 1 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0; 
	0 0 0 0 0 0 0 0 0 0 1 1 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0; 
	0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0;
	0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0; 
	0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0; 
	0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0; 
	0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0; 
    0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0; 
    0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 1 1 0 0 0 0 0 0 0 0 0 1];

m = size(A,1);
n = size(A,2);

b = ones(m,1);

c = zeros(n, 1);
c(1:50) = [8 8 7 9 2 8 1 2 7 3 10 7 7 9 5 10 8 8 10 3 10 5 5 7 5 6 10 2 7 9 5 8 10 5 2 8 8 9 3 4 5 8 10 5 1 7 1 1 1 6]';
c = -c;

baseInicio = 51:60;

B = A(:,baseInicio);

x = zeros(n,1);
x(baseInicio) = inv(B)*b;

while(1),
	cRedux = c' - (c(baseInicio,:))'*inv(B)*A;
	
	cReduxNeg = find(cRedux < 0);
	
	if (isempty(cReduxNeg))
		disp('Custo �timo: ');
		disp(-c'*x); %Est� assim pois o problema � de max.
		disp('Ponto �timo: ');
		disp(x'(1:50));
		break;
	end
	
	j = cReduxNeg(1);
	d = zeros(n, 1);
	d(j) = 1;
	d(baseInicio) = -inv(B) * A(:,j);
	dIndicesNeg = find(d(baseInicio) < 0);
	
	if(isempty(dIndicesNeg))
		disp('O problema � ilimitado, pois o vetor d � inteiramente positivo.')
		d
		break;
	end
	
	[theta, ind] = min(-x(baseInicio(dIndicesNeg)) ./ d(baseInicio(dIndicesNeg)));
	l = dIndicesNeg(ind);
	x = x + theta * d;
	baseInicio(l) = j;
	B = A(:,baseInicio);
end