from sklearn.discriminant_analysis import LinearDiscriminantAnalysis    # Xây dựng đường thẳng phân biệt LDA
import pandas as pd
import numpy as np
np.random.seed(3401)

#1
def fit_LDA_model(X, y):
    '''
    Hàm khớp tìm hàm phân biệt LDA
    Input:
    Output:
    '''
    lda_model = LinearDiscriminantAnalysis(store_covariance = True, n_components = 1)
    rep = lda_model.fit(X, y)
    print('Khớp xong phân tích phân biệt tuyến tính Fisher với dữ liệu')
    return rep

#2
def LDAresult(rep):
    print('='*80)
    print('TÓM TẮT PHÂN TÍCH PHÂN BIỆT FISHER')
    print('Hệ số hàm phân biệt tuyến tính: {}\n'.format(rep.coef_[0]))   # Xuất các hệ số
    print('Intercept: {}\n'.format(rep.intercept_[0]))
    print('Means: {}\n'.format(rep.means_[0]))
    print('='*80)

def class_LDA_report(X, y):
  from sklearn.metrics import classification_report, confusion_matrix, accuracy_score
  Logit_model = LinearDiscriminantAnalysis(store_covariance = True, n_components = 1).fit(X, y)
  
  cnf_matrix = confusion_matrix(y, Logit_model.predict(X))
  accuracy = accuracy_score(y, Logit_model.predict(X))
  report = classification_report(y, Logit_model.predict(X), digits = 4)
  return cnf_matrix, accuracy, report
