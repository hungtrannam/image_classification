from constants import *     # Tải một số chương trình lệnh dùng chung
from data_import import *   # Tải dữ liệu

from sklearn.svm import SVC

#1
def fit_SVM_model(X, y):
    '''
    Hàm khớp SVM vào dữ liệu
    Input:
    Output:
    '''
    svm_model = SVC(C = 1e8, gamma = 0.0001, kernel = 'rbf', decision_function_shape = 'ovo')
    svm_model = svm_model.fit(X, y)
    print('Khớp xong phân tích phân biệt tuyến tính Fisher với dữ liệu')
    return svm_model

def class_report(X, y):
  from sklearn.metrics import classification_report, confusion_matrix, accuracy_score
  Logit_model = VC(C = 1e8, gamma = 0.0001, kernel = 'rbf', decision_function_shape = 'ovo').fit(X, y)
  cnf_matrix = confusion_matrix(y, Logit_model.predict(X))
  accuracy = accuracy_score(y, Logit_model.predict(X))
  report = classification_report(y, Logit_model.predict(X), digits = 4)
  return cnf_matrix, accuracy, report
 
