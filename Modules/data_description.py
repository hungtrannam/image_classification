from constants import *
from data_import import *
from scipy import stats
from statsmodels.stats.descriptivestats import describe

sum = describe(df)
print(sum)

sum1 = df.quantile(q = [0, 0.25, 0.5, 0.75, 1])
print(sum1)


sum2 = df.groupby('Y').describe().T
print(sum2)

sns.pairplot(df, hue="Y")
fig_name = os.path.join(viz_folder, f"descr_glcm_data.pdf")
plt.savefig(fname = fig_name, format= "pdf")


print(df.to_latex(index=False, caption = ('hello', 'heloo')))