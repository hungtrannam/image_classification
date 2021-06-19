from sklearn.preprocessing import MinMaxScaler, MaxAbsScaler, StandardScaler

def MinMaxScaler_(X):
	scaler = MinMaxScaler()
	xmat = scaler.fit_transform(X)
	X = pd.DataFrame(xmat, columns = X.columns)
	print("Hoàn thành việc chuẩn hóa MinMax dữ liệu")
	return X


def MaxAbsScaler_(X):
	scaler = MaxAbsScaler()
	xmat = scaler.fit_transform(X)
	X = pd.DataFrame(xmat, columns = X.columns)
	print("Hoàn thành việc chuẩn hóa MaxAbs dữ liệu")
	return X

def StandardScaler_(X):
	scaler = StandardScaler()
	xmat = scaler.fit_transform(X)
	X = pd.DataFrame(xmat, columns = X.columns)
	print("Hoàn thành việc chuẩn hóa StandardScaler dữ liệu")
	return X
