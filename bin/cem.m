classdef cem < handle
    %CEM Circulant Embedding Method Class
    %   자세한 설명 위치
    
    properties (SetAccess = private)
        CEMOPT 		% option file
		c = []; 	% first row of C
		m 			% size of C
		n 			% size of random field
		h 			% mesh size
		L 			% weighted square roots of eigenvalues of C  
		onesdim 	% 3-by-1 vector with ones for valid dimensions
		isEven = 0;
		tempZ
    end
    
    methods
        % Constructor
		function  CEM = cem(CEMOPT)
            CEM.CEMOPT    = CEMOPT;
			n = CEMOPT.get('N');			
			CEM.h = CEMOPT.get('h');
			onesdim = [0 0 0];
			for i = 1 : CEMOPT.get('dim')
				onesdim(i) = 1;
			end
			CEM.onesdim = onesdim;
			m = [1 1 1];
			m(find(n>1)) = n(find(n>1))*2;
			CEM.m = m;
			CEM.n = n;
			decomposition(CEM);
        end

		function print(obj)
			obj.CEMOPT.print();
		end
    end
    
	methods
		function z = generate_matrix(obj)
			if ~obj.isEven 
				x = randn(obj.m) + 1i*randn(obj.m);
				z = fftn(obj.L.*x);
				z = z([1:obj.n(1)],[1:obj.n(2)],[1:obj.n(3)]);
				obj.tempZ = imag(z);
				z = real(z);
				obj.isEven = 1;
			else
				z = obj.tempZ;
				obj.isEven = 0;
			end
		end

		function z = generate_vector(obj)
			z = generate_matrix(obj);
			z = z(:);
		end


	end
    
	methods (Access = private)
    	function decomposition(obj)
			fprintf('[CEM Decomposition]')
			obj.c = get_first_row(obj);
			eig_C = fftn(obj.c);
		    nnev = nnz(eig_C<0);
			while nnev > 0
				disp(nnev)
				increase_m(obj,ceil(log10(nnev)));
				obj.c = get_first_row(obj);
				eig_C = fftn(obj.c);
				nnev = nnz(eig_C<0);
			end
			obj.L = sqrt(eig_C/prod(obj.m));
		end

		function increase_m(obj,inc)
			obj.m = obj.m + inc * obj.onesdim;
		end

		function c = get_first_row(obj)
			c = zeros(obj.m);
			l = obj.CEMOPT.get('corrlen');
			s2 = obj.CEMOPT.get('sigma');
			switch (obj.CEMOPT.get('norm'))
				case {'L1'}
					lnorm = 1;
				case {'L2'}
					lnorm = 2;
			end

			for k = 1 : obj.m(3)
				for j = 1 : obj.m(2)
					for i = 1 : obj.m(1)
						d = norm([mirror(obj.m(1)*obj.h(1),obj.h(1)*(i-1)) ...
						          mirror(obj.m(2)*obj.h(2),obj.h(2)*(j-1)) ...
								  mirror(obj.m(3)*obj.h(3),obj.h(3)*(k-1)) ...
								  ], lnorm);
						c(i,j,k) = exp_covf(d,l,s2);
					end
				end
			end
		end

    end
end

function h = mirror(m,x)
	if x < m/2
		h = x;
	else
		h = m - x;
	end
end

function r = exp_covf(d,l,sigma2)
	r = sigma2*exp(-d/l);
end
