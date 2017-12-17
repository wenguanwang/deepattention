function [attentionmap1, attentionmap2, attentionmap3, final_attentionmap] = fixationmap_detect(conf, caffe_net, im)

    im = single(im);  
    im_blob = prep_im_for_blob(im, conf.image_means, conf.test_scales, conf.test_max_size);
    % permute data into caffe c++ memory, thus [num, channels, height, width]
    im_blob = im_blob(:, :, [3, 2, 1], :); % from rgb to brg
    im_blob = single(permute(im_blob, [2, 1, 3, 4]));

    net_inputs = {im_blob};

    % Reshape net's input blobs
    caffe_net.reshape_as_input(net_inputs);
    output_blobs = caffe_net.forward(net_inputs);
    
    output_blobs{1} = single(permute(output_blobs{1}, [2, 1, 3]));
    output_blobs{2} = single(permute(output_blobs{2}, [2, 1, 3]));
    output_blobs{3} = single(permute(output_blobs{3}, [2, 1, 3]));
    output_blobs{4} = single(permute(output_blobs{4}, [2, 1, 3]));
    %t= caffe_net.blobs('attentionmap3').get_data();

    attentionmap1 = output_blobs{1};
    attentionmap1 = attentionmap1/max(attentionmap1(:));
    
    attentionmap2 = output_blobs{2};
    attentionmap2 = attentionmap2/max(attentionmap2(:));
    
    attentionmap3 = output_blobs{3};
    attentionmap3 = attentionmap3/max(attentionmap3(:));
    
    final_attentionmap = output_blobs{4};
    final_attentionmap = final_attentionmap/max(final_attentionmap(:));
end



    
