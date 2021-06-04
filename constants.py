''' Các hàm được định nghĩa trong gói chương trình
1) Một số chương trình lệnh dùng chung cho các modules
2) Link tải dữ liệu vào Python
3) Kích thước font chữ và hệ màu
4) Tạo folder lưu trữ hình ảnh trực quan (Graph) và kết quả (Output)
'''

#1
import os															# (pip install os-sys)

import itertools	


import pandas as pd										# Công cụ quản lý dữ liệu	# (pip install pandas)
import numpy as np										# Công cụ đại số tuyến tính	# (pip install numpy)
np.random.seed(3401)										# Tái lập kết quả


import arviz as az										# Đồ họa có posterior		# (pip install arviz)
import matplotlib.pyplot as plt													# (pip install matplotlib)
import seaborn as sns														# (pip install seaborn)


import statsmodels.api as sm													# (pip install statsmodels)
#import tensorflow as tf													# (pip install tensorflow)
import probflow as pf														# (pip install probflow)
#import tensorflow as tf													# (pip install tensorflow)

import scipy.stats as ss													# (pip install scipy)


import cv2											# Trích suất, xử lý ảnh		# (pip install cv2)


warning_status = "ignore"
import warnings
warnings.filterwarnings(warning_status)
with warnings.catch_warnings():
    warnings.filterwarnings(warning_status, category = DeprecationWarning)

#2
df_link = 'D:\\A_NCKH_hung\\NCKH_Statistics\\Data\\Data_Finance.csv'
train = 'D:\\A_NCKH_hung\\NCKH_Statistics\\Data\\train\\*.jpg'
test = 'D:\\A_NCKH_hung\\NCKH_Statistics\\Data\\test\\*.jpg'
path = 'D:\\A_NCKH_hung\\NCKH_Statistics\\Modules\\Matlab\\Ex3_voihongngua\\*.jpg'

#3
plt.rcParams.update({'font.size': 15})	
bicolor = ['#e6154c', '#0e89ed']		
fill = ['Greens','YlOrRd','Reds']		
edge = ['#73cc06', '#fcba03', '#fc035a']

#4
cur_path = os.getcwd()
viz_folder = os.path.join(cur_path, 'Graph')		
output_folder = os.path.join(cur_path, 'Output')	

if os.path.isdir(viz_folder):
	pass
else: 
	os.mkdir(viz_folder)

if os.path.isdir(output_folder):
	pass
else: 
	os.mkdir(output_folder)




