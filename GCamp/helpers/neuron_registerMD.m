function [ neuron_map ] = neuron_registerMD( MDbase, MDreg, varargin )
% neuron_map = neuron_registerMD( MDbase, MDreg, ... )
%   registers MDreg to MD base using neuron_register function

neuron_map = neuron_register(MDbase.Animal, MDbase.Date, MDbase.Session,...
    MDreg.Date, MDreg.Session, varargin{:});

end

