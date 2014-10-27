classdef cemoption < handle
	properties (SetAccess = private)
		allfields
		opt
	end

	methods
		% Constructor
		function CEMOPT = cemoption()
			allfields = default_opts_cem;
			structinput = cell(2,length(allfields));
			structinput(1,:) = allfields';
			for i = 1 : length(allfields)
				structinput{2,i} = default_opts_cem(allfields{i});
			end
			CEMOPT.opt = struct(structinput{:});
			CEMOPT.allfields = allfields;
		end
		
		function set(obj,field,value)
			obj.opt = setfield(obj.opt,field,value);
		end

		function value = get(obj,field)
			value = getfield(obj.opt,field);
		end

		function print(obj)
			  fprintf('   ____ _____ __  __  ___  ____ _____\n') ;
			  fprintf('  / ___| ____|  \\/  |/ _ \\|  _ \\_   _|\n');
			  fprintf(' | |   |  _| | |\\/| | | | | |_) || | \n');  
			  fprintf(' | |___| |___| |  | | |_| |  __/ | | \n'); 
			  fprintf('  \\____|_____|_|  |_|\\___/|_|    |_|  \n');
				                                     

			fprintf('')
			for i = 1 : length(obj.allfields)
				fprintf('%10s : ',obj.allfields{i})
				val = getfield(obj.opt,obj.allfields{i}); 
				if isnumeric(val)
					fprintf('%10s\n',num2str(val));
				else
					fprintf('%10s\n',val);
				end
			end
		end
	end
end
