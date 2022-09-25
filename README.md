#RF_TemporalPattern
Timeseries clustering for rainfall distribution patterns

Rainfall timeseries data often shows a consistent distribution pattern or more commonly known as temporal patterns in hydrology.
Rainfall temporal pattern (RTP) is considered to be one of the most critical variables in design flood estimation.
Conventional methods usually assumes the peak rainfall occurs in the halfway point of the time considered.
While conservative, the traditional methods do not take into consideration of multiple storm peaks which may result in over- or underestimating rainfall volumes.
Unrealistic storm timings give rise to inaccurate water level estimations in hydraulic models, leading to unrealistic design specifications for flood mitigation or construction purposes.

![Monte Carlo hydrological simulation process](https://user-images.githubusercontent.com/93307196/192140258-7aa2d67d-71dd-4d70-9417-ca3f00928356.png)

Timeseries clustering proves to be a feasible method in determining these storm patterns.
The workflow consists of the following steps:
1. Extracting independent rainfall events using the IETD package in R. Independent rainfall events are defined as events with a minimum of 6 hours in between.
2. Categorizing the storms events by the timeseries length into 30 minutes, 1 hour, 3 hour, 6 hour, 12 hour, 24 hour and 48 hour bins.
3. The timeseries are the preprocessed into unit hydrograph (scaled between zero to one).
4. DTW timeseries clustering is then performed to acheive the most probable temporal patterns for each storm duration (timeseries length bins in item 2).
5. A frequency analysis of the storm durations is then performed to obtain the most probable storm duration.
6. With the temporal pattern and the frequency analysis, we can obtain a unit hyetograph of the most frequent storm duration.
7. If an EVA Analysis is performed on the raw rainfall data (preprocessed to obtain catchment mean), the unit hyetographs can then be scaled up based on the return period of the storms.
8. This data can then be input as a boundary forcing data in hydraulic models or machine learning models like LSTM to predict river discharge.
