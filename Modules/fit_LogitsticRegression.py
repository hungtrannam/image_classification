import statsmodels.api as sm
import numpy as np
import pandas as pd
from sklearn.linear_model import LogisticRegression

def fit_Logit_model(X, y):
    '''
    Hàm khớp mô hình hồi quy logistics với dữ liệu
    Input:
    Output:
    '''
    log_model = sm.Logit(y, sm.add_constant(X))
    result = log_model.fit()
    rep = result.summary2()
    rep.tables.append(rep.tables[1].iloc[:, [0, 4, 5]].apply(np.exp))
    rep.tables[2].rename(columns={"Coef.": "Odds-ratio"}, inplace = True)
    print('Khớp xong mô hình logistic với dữ liệu')
    return rep, result
#2
def Logitreport(rep):
    print('='*80)
    print('TÓM TẮT MÔ HÌNH HỒI QUY LOGISTICS')
    print(rep.tables[0].to_string(index = False, header = False))
    print('-'*80)
    print(rep.tables[1].to_string())
    print('-'*80)
    print(rep.tables[2].to_string())
    print('pvalues:\n{}'.format(result.pvalues))
    print('='*80)
   
def class_Logit_report(X, y):
  from sklearn.metrics import classification_report, confusion_matrix, accuracy_score
  Logit_model = LogisticRegression(solver='liblinear', random_state=0).fit(X, y)
  
  cnf_matrix = confusion_matrix(y, Logit_model.predict(X))
  accuracy = accuracy_score(y, Logit_model.predict(X))
  report = classification_report(y, Logit_model.predict(X), digits = 4)
  return cnf_matrix, accuracy, report
