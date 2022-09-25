# %%
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from mikeio import Dfs0, Dataset

# %%
#Import data from DFS0
df = Dfs0("C:/Projects/Side Projects/Monte Carlo/Script/Input/Test_Hourly_RF.dfs0").to_dataframe()

# %%
#Convert Pandas dataframe to Padas Series
series=df.squeeze()

# %%
#Create EVA model
from pyextremes import EVA
model=EVA(series)

# %%
#Extract extreme values
model.get_extremes(method="BM", block_size="365.2425D")

fig1 = model.plot_extremes()
plt.savefig(r"C:/Projects/Side Projects/Monte Carlo/Script/Output/Extreme_Values.png")

# %%
#Model fitting
model.fit_model()

#Calculate return values
summary = model.get_summary(
    return_period=[5, 10, 25, 50, 100],
    alpha=0.95,
    n_samples=1000,
)
print(summary)

#export return values as csv
summary.to_csv(r"C:/Projects/Side Projects/Monte Carlo/Script/Output/Return_Period.csv", index = True)


# %%
model.plot_diagnostic(alpha=0.95)

#export plot
plt.savefig(r"C:/Projects/Side Projects/Monte Carlo/Script/Output/Diagnostics.png")


