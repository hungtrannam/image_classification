
''' Các hàm được định nghĩa trong gói chương trình
1) Tải dữ liệu từ đường link trong gói constants
2) Tiền xử lý số liệu trong dataframe
3) Chia dữ liệu ban đầu thành hai tập training và testing với tỷ lệ thích hợp
'''


from constants import *	# Tải một số chương trình lệnh dùng chung

from sklearn.model_selection import train_test_split	# Chia ngẫu nhiên dữ liệu
from sklearn.experimental import enable_iterative_imputer	# Xử lý số liệu trống (NaN) bằng phương pháp MICE (Multivariate Imputation by Chained Equations)
from sklearn.impute import IterativeImputer

#1 
def data_load(df_link: str):
	'''
	Hàm tải dữ liệu từ đường link cho trước
	input: df_link: đường dẫn đến file .csv (str)
	output: dataframes (dữ liệu gốc, dữ liệu biến giải thích và	dữ liệu biến phụ thuộc)
	'''
	# Tiến hành tải dữ liệu từ đường link trong gói 'constants'
	df = pd.read_csv(df_link, sep = ',', decimal = '.')

	# Nhân tố hóa biến định tính (category)
	for col_name in df.columns:
		if(df[col_name].dtype == 'object'):
			df[col_name]= df[col_name].astype('category')
			df[col_name] = df[col_name].cat.codes

	# Xử lý các quan sát thiếu
	imputer = IterativeImputer(sample_posterior=True).fit(df).transform(df)
	df = pd.DataFrame(imputer, columns = df.columns)
	
	# Trích xuất dữ liệu thành biến tiên lượng (X) và biến giải thích (y)
	X, y = df[df.columns[:-1]], df[df.columns[-1]]
	print("Hoàn thành việc tải dữ liệu.")
	return df, X, y

#2
def data_train_test(X, y, test_size):
	X_train, Y_train, X_test, Y_test = train_test_split(X, y, test_size = test_size, random_state = 1)
	print("Hoàn thành việc chia dữ liệu với tỷ lệ training {}% - {}%.".format((1-test_size)*100, test_size*100))
	return X_train, Y_train, X_test, Y_test





