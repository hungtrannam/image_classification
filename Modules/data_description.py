from constants import *
from data_import import *
from scipy import stats
from statsmodels.stats.descriptivestats import describe


def describe_(df):
  summary = describe(df)
  return summary


sum1 = df.quantile(q = [0, 0.25, 0.5, 0.75, 1])
print(sum1)

def groupby_(val: str):
  summary = df.groupby(val).describe().T
  return summary

#sns.pairplot(df, hue="Y")
#fig_name = os.path.join(viz_folder, f"descr_glcm_data.pdf")
#plt.savefig(fname = fig_name, format= "pdf")

#print(df.to_latex(index=False, caption = ('hello', 'heloo')))
