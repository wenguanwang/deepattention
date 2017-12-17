function conf = attention_config(varargin)
    ip = inputParser;
    %% training
    % whether use gpu
    ip.addParamValue('use_gpu',         gpuDeviceCount > 0, ...            
                                                        @islogical);
    % Image scales -- the short edge of input image                                                
    ip.addParamValue('scales',          [224 224],            @ismatrix);
    % Max pixel size of a scaled input image
    ip.addParamValue('max_size',        400,           @isscalar);
    % Images per batch
    ip.addParamValue('ims_per_batch',   1,              @isscalar);
    % Minibatch size
%     ip.addParamValue('batch_size',      128,            @isscalar);
    ip.addParamValue('batch_size',      64,            @isscalar);  
    % mean image, in RGB order
    ip.addParamValue('image_means',     128,            @ismatrix);
    % Use horizontally-flipped images during training?
    ip.addParamValue('use_flipped',     true,           @islogical);
    % random seed
    ip.addParamValue('rng_seed',        6,              @isscalar);
    
    %% testing
    ip.addParamValue('test_scales',     [224 224],             @isscalar);
    ip.addParamValue('test_max_size',   400,           @isscalar);
    ip.addParamValue('test_binary',     false,          @islogical);
    
    ip.parse(varargin{:});
    conf = ip.Results;
    
    %% if image_means is a file, load it
    if ischar(conf.image_means)
        s = load(conf.image_means);
        s_fieldnames = fieldnames(s);
        assert(length(s_fieldnames) == 1);
        conf.image_means = s.(s_fieldnames{1});
    end
end