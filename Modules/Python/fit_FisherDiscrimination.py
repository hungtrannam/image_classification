from constants import *     # Tải một số chương trình lệnh dùng chung
from data_import import *   # Tải dữ liệu

from sklearn.discriminant_analysis import LinearDiscriminantAnalysis    # Xây dựng đường thẳng phân biệt LDA

from sklearn.model_selection import cross_val_score
from sklearn import metrics
from sklearn.metrics import classification_report, confusion_matrix, accuracy_score

#1
def fit_lda_model(X, y):
    from time import time
    start = time()
    lda_model = LinearDiscriminantAnalysis(solver = 'svd', 
                                       store_covariance = True, 
                                       n_components = 1)
    lda_model = lda_model.fit(X, y)
    stop = time()
    print(f"Training time: {stop - start}s")
    return lda_model


#2
def LDAresult(lda_model):
    print('='*80)
    print('TÓM TẮT PHÂN TÍCH PHÂN BIỆT FISHER')
    print('Hệ số hàm phân biệt tuyến tính: {}\n'.format(lda_model.coef_[0]))   # Xuất các hệ số
    print('Intercept: {}\n'.format(lda_model.intercept_[0]))
    print('Means: {}\n'.format(lda_model.means_[0]))
    print('='*80)


