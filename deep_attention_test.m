function deep_attention_test()
close all;
clc;
% clear mex;
clear is_valid_handle; % to clear init_key
run(fullfile(fileparts(mfilename('fullpath')), 'startup'));
opts.vocal = true;

%% -------------------- CONFIG --------------------
opts.dataset{1} = 'pascal';
%opts.dataset{2} = 'DUT';
%opts.dataset{3} = 'MIT300';
%opts.dataset{4} = 'MIT1003';
%opts.dataset{5} = 'Toronto';
opts.caffe_version          = 'caffe_faster_rcnn';
opts.gpu_id                 = auto_select_gpu;
active_caffe_mex(opts.gpu_id, opts.caffe_version);
opts.use_gpu                = true;

attention_model_dir              = fullfile(pwd, 'models'); %% VGG
attention_model                  = load_model(attention_model_dir);

attention_net = caffe.Net(attention_model.attention_net_def, 'test');
attention_net.copy_from(attention_model.attention_net);
%attention_net.params('final_attention_pred',1).get_data()
% if opts.use_gpu
%     attention_model.image_means = gpuArray(attention_model.image_means);
% end

% set gpu/cpu
if opts.use_gpu
    caffe.set_mode_gpu();
else
    caffe.set_mode_cpu();
end

for kk = 1:length(opts.dataset)
    opts.attention_dir = fullfile(pwd, 'datasets', 'result', opts.dataset{kk});
    mkdir_if_missing(opts.attention_dir);
                
    files=dir(['datasets/' opts.dataset{kk} '/*.jpg']);
    files=struct2cell(files)' ;    
    image_names=files(:,1);
       
    for imnum = 1:length(image_names)
        imnum
        image = imread(['datasets/' opts.dataset{kk} '/' image_names{imnum}]);
        [w,h,c] = size(image);
%       if opts.use_gpu
%           im = gpuArray(image);
%       end
        [~, ~, ~, final_attentionmap] = fixationmap_detect(attention_model.conf, attention_net, image);
        final_attentionmap  = imresize(final_attentionmap,[w,h]);
        imwrite(final_attentionmap,[opts.attention_dir '/'  image_names{imnum}(1:end-4) '.jpg']);
    end
end
caffe.reset_all(); 
clear mex;

end

function model = load_model(model_dir)
    ld             = load(fullfile(model_dir, 'model'));
    model = ld.attention_model;
    clear ld;
    %% load attention model
    model.attention_net_def ...
                                = fullfile(model_dir, model.attention_net_def);
    model.attention_net ...
                                = fullfile(model_dir, model.attention_net);                                               
end
