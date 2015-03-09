function val = default_opts_cem(varargin)

allfields = {'dim';'N';'h';'sigma';'covfun';'distfun'};
% Print out all default values
if (nargin == 0) && (nargout == 0)
  	fprintf('    __  ______  ____________________  ___ \n')
  	fprintf('   /  |/  /   |/_  __/ ____/ ____/  |/  / \n')
  	fprintf('  / /|_/ / /| | / / / /   / __/ / /|_/ /  \n')
  	fprintf(' / /  / / ___ |/ / / /___/ /___/ /  / /   \n')  
  	fprintf('/_/  /_/_/  |_/_/  \\____/_____/_/  /_/    \n')   
	for i = 1 : length(allfields)
		fprintf('[%d]%10s : ',i,allfields{i})
		disp(default_opts_cem(allfields{i}));
	end
	return			                                           

	
end
if (nargin == 0) && (nargout == 1)
	val = allfields;
	return
end

if nargin ~= 1
	error('MATLAB:dafault_opts_cem:WrongInputSize','default_opt_cem requries 1 inputs')	
end

if ~ischar(varargin{1})
	error('MATLAB:default_opts_cem:noncharinput','Input must be char')
end
switch lower(varargin{1})
	case {'dim'}
		val = 2;
		return
	case {'n'}
		val = [8 8 1];
		return
	case {'h'}
		val = [1/8 1/8 0];
		return
	case {'distfun'}
		val = '@(x)l2dist(x,[0.3, 0.3, 0.3])';
		return
	case {'covfun'}
		val = 'exp_cov';
	case {'sigma'}
		val = 1;
	otherwise
		error('MATLAB:default_opts_cem:nonValidParam',...
		      [varargin{1} 'is not a valid parameter.'])
end


