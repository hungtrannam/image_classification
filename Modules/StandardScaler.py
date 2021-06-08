from constants import *
from data_import import *
from sklearn.preprocessing import MinMaxScaler, MaxAbsScaler




def MinMaxScaler_(X):
	scaler = MinMaxScaler()
	xmat = scaler.fit_transform(X)
	X = pd.DataFrame(xmat, columns = X.columns)
	print("Hoàn thành việc chuẩn hóa MaxAbs dữ liệu")
	return X


def MaxAbsScaler_(X):
	scaler = MaxAbsScaler()
	xmat = scaler.fit_transform(X)
	X = pd.DataFrame(xmat, columns = X.columns)
	print("Hoàn thành việc chuẩn hóa MaxAbs dữ liệu")
	return X