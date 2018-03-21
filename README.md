This repo contains a CAFFE re-implementation for 

# "Deep Visual Attention Prediction", TIP18

By Wenguan Wang, Jianbing Shen

========================================================================

Our current implementation is based on the caffe version of Holistically-Nested Edge Detection (has been included in this repository, see `external/caffe`). We also use some functions from fasterrcnn's caffe.
But it can be easily implemented in standard caffe library. 

We plan to re-implement it on Keras, but it depends on my schedule.

a. Please first compile the 'Caffe' for matlab.

b. Please download our MODEL and RESUTLS on DUT, MIT300, MIT1003, Pascal, and Toronto datasets from 

google drive: https://drive.google.com/open?id=1cl3k3POMqS5obv0ffz84qOgGfAbEmtB3

or Baidu Wangpan: https://pan.baidu.com/s/1o8kQcAY password: wdwa

and put the model 'attention_final' into 'models' folder.

c. Run 'deep_attention_test' and the results can be found in 'datasets/results/'.

If you find our method useful in your research, please consider citing:

    @article{wang2018deep,
        Author = {Wenguan Wang, Jianbing Shen},
        Title = {Deep Visual Attention Prediction},
        Journal = {IEEE Transactions on Image Processing},
        Year = {2018}
    }

========================================================================

Any comments, please email: wenguanwang.ai@gmail.com
