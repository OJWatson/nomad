# Extract model residuals 'nomad_model' class

This function takes a `nomad_model` object and extracts model residuals
from the underlying
[`mobility::mobility()`](https://rdrr.io/pkg/mobility/man/mobility.html).

## Usage

``` r
# S3 method for class 'nomad_model'
residuals(object, type = "deviance", ...)
```

## Arguments

- object:

  a
  [`nomad_model()`](https://ojwatson.github.io/nomad/reference/nomad_model.md)
  object containing the fitted mobility

- type:

  the type of residuals to be returned. Available residual types
  include: `'deviance'` (default), `'pearson'`, and `'raw'`.

- ...:

  further arguments passed to or from other methods

## Value

a matrix containing model residuals

## Details

Residual types are calculated as:

- raw:

  \\y_i - \mu_i\\

- pearson:

  \\(y_i - \mu_i)/\sqrt{\mu_i}\\

- deviance:

  \\sign(y_i - \mu_i) \* \sqrt(2(log(y_i/\mu_i) - (y_i - \mu_i)))\\

Where, \\y_i\\ is the observed data and \\\mu_i\\ is the value predicted
by the model using the mean of parameter posterior distributions

## See also

Other model: [`check()`](https://rdrr.io/pkg/mobility/man/check.html),
[`compare()`](https://rdrr.io/pkg/mobility/man/compare.html),
[`fit_jags()`](https://rdrr.io/pkg/mobility/man/fit_jags.html),
[`fit_prob_travel()`](https://rdrr.io/pkg/mobility/man/fit_prob_travel.html),
[`mobility()`](https://rdrr.io/pkg/mobility/man/mobility.html),
[`predict()`](https://rdrr.io/r/stats/predict.html),
[`summary()`](https://rdrr.io/pkg/mobility/man/summary.html)

## Author

John Giles

## Examples

``` r
# Get nomad_model object
nmd_model <- nomad::model_db$zmb_cdr_2020_mod_dd_exp

# Get model residuals
residuals(nmd_model)
#>                     chadiza        chama      chavuma        chembe
#> chadiza         207.3372154  -13.9240413          NaN           NaN
#> chama           -27.3942847 -317.5588799          NaN           NaN
#> chavuma                 NaN          NaN  195.2872312           NaN
#> chembe                  NaN          NaN          NaN -352.67934170
#> chibombo         10.6206723   13.4617942    1.6228199   18.76852053
#> chiengi                 NaN          NaN          NaN  -11.18787537
#> chikankanta       3.9519440    9.6431827    2.5052110    0.08639486
#> chilanga         14.2512075   21.3690666    4.1762372    6.59170940
#> chililabombwe           NaN    0.8984264          NaN  -29.10312378
#> chilubi                 NaN  -28.7659146          NaN  -37.76182393
#> chingola          3.4398189    0.9258356    3.6843871  -47.17989957
#> chinsali                NaN -121.6617953          NaN    0.59934492
#> chipata        -111.5158686  -12.8444781          NaN           NaN
#> chipili                 NaN   -5.0038831          NaN   -7.91460826
#> chirundu                NaN          NaN          NaN           NaN
#> chisamba                NaN    7.1519599    6.6347091    9.78237100
#> chitambo                NaN  -23.3139349          NaN  -25.76560861
#> choma                   NaN   11.1257566    1.6096421           NaN
#> chongwe          40.6900105   15.6538132    6.4812877    1.36495990
#> gwembe                  NaN          NaN          NaN           NaN
#> ikelenge                NaN          NaN          NaN           NaN
#> isoka                   NaN -118.0529007          NaN           NaN
#> itezhi-tezhi            NaN    2.5129582          NaN    0.76998310
#> kabompo                 NaN          NaN  -23.5936266           NaN
#> kabwe            -0.4734030   17.1917833    4.3893517   12.38671365
#> kafue             7.5652416   15.5141222          NaN    3.75620084
#> kalabo                  NaN          NaN          NaN           NaN
#> kalomo                  NaN    6.0595444          NaN           NaN
#> kalulushi         2.4560065    1.1821750          NaN  -18.11046757
#> kalumbila               NaN          NaN   -7.1164800  -12.17316524
#> kanchibiya              NaN          NaN          NaN           NaN
#> kaoma             3.7107264   10.7002151   -3.0472385           NaN
#> kapiri mposhi    -5.6351629   13.7921725    5.0202471   -1.43802001
#> kaputa                  NaN          NaN    5.9732782   -9.78050109
#> kasama          -10.8809323  -12.1030799          NaN   -3.55475850
#> kasempa                 NaN          NaN    6.1919818  -10.33138849
#> katete          142.1684078   -9.1275038          NaN           NaN
#> kawambwa                NaN  -10.5859941          NaN  -19.66767290
#> kazungula         1.8189416          NaN          NaN           NaN
#> kitwe             0.4807650   -2.4051337    7.7141799  -30.21187396
#> lavushimanda            NaN  -26.0539185          NaN           NaN
#> limulunga               NaN          NaN          NaN           NaN
#> livingstone       4.7125383    8.8241162          NaN           NaN
#> luampa                  NaN          NaN          NaN           NaN
#> luangwa          -9.0290751          NaN          NaN           NaN
#> luano                   NaN          NaN          NaN           NaN
#> luanshya          0.6699064          NaN    4.7093002    3.71828353
#> lufwanyama              NaN          NaN    3.0762793  -21.08307145
#> lukulu                  NaN          NaN  -33.2065331           NaN
#> lundazi         -89.0928161 -126.1961119          NaN           NaN
#> lunga                   NaN          NaN          NaN  -28.59003084
#> lunte district          NaN  149.0327730          NaN  -15.13327315
#> lusaka           41.0446353   56.1589246    8.8794427    7.11906735
#> luwingu                 NaN  -22.1456550          NaN   -3.34574081
#> mafinga                 NaN -172.1294390          NaN           NaN
#> mambwe          -98.4446397  -30.0316676          NaN           NaN
#> mansa                   NaN   -9.8415363          NaN  -58.45642241
#> manyinga                NaN          NaN  -24.3999428   -3.06785948
#> masaiti          -1.8558047   -1.3881460    1.9714893   -9.79947222
#> mazabuka          2.3921123   16.0512869          NaN           NaN
#> mbala                   NaN  -36.2632879          NaN    6.54181934
#> milengi                 NaN   -4.9769604          NaN  -17.40209082
#> mitete                  NaN          NaN  -58.3548699           NaN
#> mkushi                  NaN    1.8379380          NaN  -27.09469524
#> mongu             4.3941211          NaN          NaN           NaN
#> monze             3.1330618          NaN          NaN    1.71600376
#> mpika                   NaN -160.5256563    6.3763974  -18.49477965
#> mpongwe                 NaN    0.0256811          NaN  -18.44015844
#> mporokoso               NaN  245.5982734          NaN    4.89324417
#> mpulungu                NaN  -19.2932765          NaN   -4.84660963
#> mufulira         -0.4217442   -0.4009712    1.4863468   19.45526804
#> mufumbwe                NaN    3.5300031   -0.4703473   -4.89533176
#> mulobezi                NaN          NaN          NaN           NaN
#> mumbwa            1.3465480          NaN          NaN   -7.35855115
#> mungwi                  NaN  -93.6790057          NaN   -2.82249792
#> mwandi                  NaN          NaN          NaN           NaN
#> mwansabombwe            NaN          NaN          NaN  -17.22530040
#> mwense                  NaN          NaN          NaN  -44.26773808
#> mwinilunga        3.0317991          NaN  -37.2670627  -11.65080261
#> nakonde                 NaN -114.8459870          NaN   -1.22871267
#> nalolo                  NaN          NaN          NaN           NaN
#> namwala                 NaN    3.6947727          NaN           NaN
#> nchelenge               NaN   -8.0298203    3.3462052  -23.97201310
#> ndola            -0.2324144   -0.7997209   13.1010980  -45.70660853
#> ngabwe                  NaN          NaN          NaN   -8.47394553
#> nkeyema                 NaN          NaN          NaN           NaN
#> nsama                   NaN   -8.1248335          NaN           NaN
#> nyimba          -13.4274752   -1.2589678          NaN           NaN
#> pemba                   NaN          NaN          NaN           NaN
#> petauke        -161.1924887  -28.3643383          NaN           NaN
#> rufunsa          32.1673251   11.3537431          NaN           NaN
#> samfya                  NaN  -14.9566902          NaN  -63.70950035
#> senanga                 NaN          NaN          NaN           NaN
#> serenje                 NaN   -9.0323622          NaN  -23.23091713
#> sesheke                 NaN          NaN          NaN           NaN
#> shang'ombo              NaN          NaN          NaN           NaN
#> shibuyunji              NaN          NaN          NaN    8.43255330
#> shiwamg'andu            NaN  -88.1621569          NaN   -8.76785817
#> siavonga                NaN          NaN          NaN           NaN
#> sikongo                 NaN          NaN          NaN           NaN
#> sinazongwe              NaN          NaN          NaN           NaN
#> sinda          -108.3890312   -9.6897242          NaN           NaN
#> sioma                   NaN          NaN          NaN           NaN
#> solwezi                 NaN          NaN   32.2995888  -33.05381080
#> vubwi           345.9925494          NaN          NaN           NaN
#> zambezi                 NaN          NaN -103.3471818           NaN
#> zimba                   NaN          NaN          NaN           NaN
#>                    chibombo       chiengi  chikankanta    chilanga
#> chadiza           7.6974686           NaN    1.9081402   8.6313020
#> chama             8.7922352           NaN    6.9259691  14.5613223
#> chavuma          -2.0185207           NaN    0.9678746   0.8067216
#> chembe           12.5502196    -2.4524172   -1.0065589   1.3626672
#> chibombo       -857.7823406     5.7468597  -14.8888701 162.7812851
#> chiengi           3.2494268 -1284.7806069          NaN   0.6442925
#> chikankanta      -1.1244056           NaN -520.4310094  35.2019074
#> chilanga        267.7304149     2.0850616   60.4916410 164.6850409
#> chililabombwe    10.0852025     4.5113278   16.0603940   5.1933470
#> chilubi          -4.0262766           NaN          NaN  -0.3966462
#> chingola          2.8440122    -6.3607169    7.7587062  -5.8747468
#> chinsali         76.5662852   -12.5250023          NaN  32.8185777
#> chipata          19.0424026    10.5455157    1.7404230  22.9799170
#> chipili          30.9732132           NaN    2.4372970  26.8754156
#> chirundu         -9.4193341           NaN  -15.0714809 -15.7617148
#> chisamba        188.2582777     9.6760922  -11.3982246 -33.7242932
#> chitambo         21.8143236    -3.6728035   -0.6007490  -2.2674261
#> choma           -43.6152918           NaN    2.6454074 -44.5025557
#> chongwe         336.7154237    18.3027167  -19.6735033  53.3175543
#> gwembe          -32.9533708           NaN  -31.7364692 -51.9915207
#> ikelenge                NaN           NaN          NaN         NaN
#> isoka            22.9699944           NaN          NaN  10.0503141
#> itezhi-tezhi    -66.6908109           NaN  -25.9283327 -39.2130733
#> kabompo         -10.6991125           NaN   -0.8022843  -2.8785451
#> kabwe           139.1754296     9.5419887   -6.2684328 -50.3543269
#> kafue            56.2012168           NaN  304.3209719 365.2865695
#> kalabo            2.6380826           NaN    1.2334375  31.0905751
#> kalomo          -41.2959944           NaN  -10.0783785 -44.4386027
#> kalulushi         0.3147885     5.0279346   -3.2556174  -7.1008537
#> kalumbila       -16.1238698           NaN   -2.9822954  -9.3445454
#> kanchibiya              NaN           NaN          NaN         NaN
#> kaoma           -11.1737960           NaN    1.1818326  57.8531519
#> kapiri mposhi    86.9413742     9.8234601   -5.9015203 -51.7202772
#> kaputa                  NaN  -191.7356901          NaN   3.1054598
#> kasama          104.0020858   -57.2209040   40.1201254  59.7221446
#> kasempa         -77.3527480           NaN  -12.0666814 -34.1153113
#> katete           12.5110086           NaN   -0.4810820  11.7221551
#> kawambwa         19.6520488  -111.4414941          NaN   7.6813691
#> kazungula       -25.4447698           NaN   -2.2777580 -22.7336959
#> kitwe            70.0829762     9.4282497    9.9647142  -2.5545284
#> lavushimanda     26.5126092           NaN    3.0230717   6.0684975
#> limulunga               NaN           NaN          NaN   1.5986386
#> livingstone       5.8573734           NaN   34.4277926  11.7128758
#> luampa          -24.9388991           NaN          NaN   3.6633171
#> luangwa         -18.9126139           NaN  -21.7077244 -24.7808426
#> luano           -35.0852989           NaN          NaN -32.6934905
#> luanshya         84.1225311     5.6673157    4.6915543   2.8609955
#> lufwanyama      -34.0291268           NaN   -3.0371074 -15.7369920
#> lukulu          -12.0901804           NaN   -2.2453797   5.1366785
#> lundazi          13.3568383           NaN    1.8445389  15.1814422
#> lunga                   NaN           NaN          NaN         NaN
#> lunte district    7.9509730           NaN    8.7348984   4.6513915
#> lusaka          474.4068222    21.7231678 -191.9892138 259.0935021
#> luwingu          35.4116185   -40.0913062    6.6925965  31.5707690
#> mafinga                 NaN           NaN          NaN         NaN
#> mambwe           -5.1411134           NaN   -1.2820051   0.5028839
#> mansa            52.5418350   -27.5896319    0.4085484  27.2631729
#> manyinga        -13.0824531           NaN          NaN  -5.4347406
#> masaiti         116.2914183           NaN    6.9447189   3.5066797
#> mazabuka        -59.0092601     6.4659848  442.8816279 -34.5403588
#> mbala            45.1259251   -54.2781386    4.6763469  17.6809516
#> milengi           0.6748198    -9.6249511          NaN   2.8281058
#> mitete                  NaN           NaN          NaN         NaN
#> mkushi           23.8321211     1.6795023   -6.4933578 -28.0799864
#> mongu            14.2372871           NaN    2.5618391  83.9028385
#> monze           -67.1976010           NaN  134.7739323 -68.9718041
#> mpika           150.9576331           NaN   32.5650661  55.9351658
#> mpongwe         -77.8551844           NaN  -10.9576910 -39.5054710
#> mporokoso        48.5513732   -79.2943290   27.6869638  30.1997080
#> mpulungu         16.0223555   -92.1193025   11.1823551  13.2047651
#> mufulira         32.0884915     3.3206552    5.5059440  39.3549950
#> mufumbwe        -37.1095323           NaN          NaN -21.2631029
#> mulobezi                NaN           NaN          NaN -11.5926343
#> mumbwa         -191.7574197     1.8725232  -43.3825582 -36.8059827
#> mungwi           18.2029959           NaN    1.6684268   2.1259301
#> mwandi          -10.4374745           NaN    1.2269992  -6.3325965
#> mwansabombwe      6.9328480   -69.6078475          NaN         NaN
#> mwense           15.7095013   -48.8588121          NaN   1.8660324
#> mwinilunga      -13.6864669           NaN   -2.3102760  -9.1710480
#> nakonde          29.6781252   -20.3406902    5.4240721  18.2869454
#> nalolo           -4.2028226           NaN          NaN   4.8422349
#> namwala         -82.6817695           NaN  -11.8424740 -74.5868918
#> nchelenge         8.0032872  -163.5881707          NaN   8.4690367
#> ndola           148.4788729    -1.0246217    6.7272130   4.1979784
#> ngabwe         -103.2603059           NaN  -15.2951657 -45.5358859
#> nkeyema         -28.3046738           NaN   -4.9267424  20.4461366
#> nsama             3.8610402  -104.8421904          NaN         NaN
#> nyimba           -5.5486750           NaN   -4.1883447  -4.7147818
#> pemba           -14.1099236           NaN   11.1291586 -13.8821078
#> petauke         -15.1684980           NaN   -9.5308816  -8.0121492
#> rufunsa         -11.1875071           NaN  -18.3839224  -7.4843543
#> samfya           31.8105088   -14.9543437   -2.2038228  13.6905084
#> senanga          -8.7665586           NaN          NaN   5.2099825
#> serenje          55.6390860     0.1767613    4.5482856   2.4702758
#> sesheke          -7.2893303           NaN    1.1855342  -5.4461833
#> shang'ombo              NaN           NaN          NaN         NaN
#> shibuyunji      -84.6815404           NaN  -20.5274170 108.2674514
#> shiwamg'andu     47.1345327           NaN    1.1951096  14.2190289
#> siavonga        -27.1913317           NaN  -47.2978723 -38.2047053
#> sikongo           3.8943159           NaN    8.2440825  13.1375437
#> sinazongwe      -26.3801580           NaN  -29.7467538 -38.8552501
#> sinda             9.2708739           NaN   -5.6110367   8.9810665
#> sioma            -6.1488055           NaN    3.4830251  -0.8388876
#> solwezi         -30.5040234    -5.9848861   -7.1990308 -20.2183803
#> vubwi             1.3616999           NaN          NaN   1.2735403
#> zambezi          -1.5331470           NaN   -0.7535335   1.8973081
#> zimba           -17.8480830           NaN   -2.3779639 -20.7499828
#>                chililabombwe      chilubi     chingola      chinsali
#> chadiza                  NaN          NaN    2.0190236           NaN
#> chama             -2.9932079  -43.0338315   -3.5369942 -176.93095193
#> chavuma                  NaN          NaN   -1.0239776           NaN
#> chembe           -47.0889978  -28.1248347  -61.2993121    3.28914795
#> chibombo           9.6723385   -0.6821092    9.3603090   84.54163869
#> chiengi           -5.0977100          NaN  -14.3387143  -15.77371602
#> chikankanta       17.4636383          NaN   11.5876170           NaN
#> chilanga          12.4906982    3.3320880    6.3820438   39.22691289
#> chililabombwe   -372.2183089   -7.3704793   47.2193435    4.34176465
#> chilubi          -18.2966816  444.9402781  -23.4643700  -13.61714278
#> chingola          11.2375010  -12.5533700 -182.4300880    7.45175180
#> chinsali           1.0781194  -15.5250861    3.8561068 -652.97865143
#> chipata            0.4042830          NaN   -2.6056995  -16.05865829
#> chipili          -14.9491674  -41.3016355  -15.6899373   -0.03027223
#> chirundu          11.2873455          NaN   -0.4110012           NaN
#> chisamba           3.4341865          NaN    9.8263832   45.48855261
#> chitambo         -21.1729606  -46.9733501  -28.2964899    5.68411514
#> choma             14.6661184          NaN   -1.3100394    2.63015640
#> chongwe            6.0856245    1.2706246    9.6619169   13.89875317
#> gwembe            12.3033564          NaN    0.5229857           NaN
#> ikelenge         -10.8330522          NaN  -22.0367836           NaN
#> isoka              4.6593290  -19.7052743    2.6744115  -89.76367189
#> itezhi-tezhi      -3.4254965    2.0925158  -12.0876780    8.03831372
#> kabompo           -3.4019451          NaN    5.6886441           NaN
#> kabwe              6.3510643    5.1768870   13.2924190   86.33515047
#> kafue             15.3682210    8.4466475   19.5997693   50.99273695
#> kalabo             3.4548102          NaN    6.2005261           NaN
#> kalomo            27.8833059          NaN    3.0012613    5.48258919
#> kalulushi        -51.4626243   -8.7698227   72.9527729    5.81868281
#> kalumbila        -37.7998142   -2.1390321  -31.0997067    1.36671503
#> kanchibiya       -16.2320755 -105.3674475          NaN           NaN
#> kaoma             -6.8544399          NaN  -12.3647821           NaN
#> kapiri mposhi      2.6542112   -2.3631028   -9.8262660   86.27819312
#> kaputa            -5.4370158          NaN   -7.6891502           NaN
#> kasama            -9.4631657   36.1346675   -8.1965606 -130.37376390
#> kasempa          -40.2816952          NaN  -53.8756147           NaN
#> katete            -3.2506841          NaN   -1.6639702   -7.56391682
#> kawambwa         -14.8234207  -63.8159427  -17.3523620  -17.16337739
#> kazungula         18.7290486          NaN    1.1801039           NaN
#> kitwe           -110.7686051  -19.9002073   -7.6551882   25.85133764
#> lavushimanda     -11.7043716          NaN  -15.0101010    0.92339821
#> limulunga                NaN          NaN          NaN           NaN
#> livingstone       15.1562934          NaN    9.9761922    7.39689532
#> luampa                   NaN          NaN   -9.6974633           NaN
#> luangwa           -2.0492297          NaN          NaN           NaN
#> luano                    NaN          NaN          NaN           NaN
#> luanshya         -17.9757853   -9.6173750   -9.3747108   14.24144764
#> lufwanyama       -74.4315053   -6.5071031  -37.2795227           NaN
#> lukulu                   NaN          NaN          NaN           NaN
#> lundazi                  NaN          NaN   -4.5720402  -69.44838651
#> lunga            -14.4648257   62.2951021  -21.2032670  -11.94111732
#> lunte district    -7.8330426  -66.6209958  -10.1335527  -41.03241104
#> lusaka            12.7783125    8.9631800    4.2775482  165.91657195
#> luwingu           -9.1326223  179.0683809  -11.5812532   99.59841801
#> mafinga           -0.6648595  -19.2592161          NaN -131.31753490
#> mambwe                   NaN          NaN   -6.6108978           NaN
#> mansa            -87.6136994  -99.2086606 -103.2344247  155.66384762
#> manyinga          -8.0923818          NaN   -5.1999285           NaN
#> masaiti          -11.4628332  -10.4104646  -21.5358067   21.59341756
#> mazabuka           7.8942157    5.6441648   -2.5698493    3.55438810
#> mbala             -0.7274859  -33.3324900    5.3512541  -90.49726575
#> milengi          -44.8111757  -44.3664563  -58.8716492    3.52606311
#> mitete                   NaN          NaN          NaN           NaN
#> mkushi           -38.4170946  -17.9054799  -53.2058270   62.17721292
#> mongu              6.7390923          NaN   -0.8144533           NaN
#> monze              7.5656778          NaN    1.5438776    2.33155515
#> mpika             -3.9508266   38.0092964   -6.4210919   13.94673936
#> mpongwe          -64.1241368          NaN -105.2359943    3.14834561
#> mporokoso         -1.9242774  -26.0620117   -3.0519103  -13.24341538
#> mpulungu          -1.6822737  -46.1953169   -5.2555715  -61.15300673
#> mufulira         -93.0241388  -11.9248234  -78.2086138   16.86534115
#> mufumbwe         -19.8943065          NaN  -16.0377740           NaN
#> mulobezi          -0.4790910          NaN          NaN           NaN
#> mumbwa           -25.2421766   -0.1550780  -46.5689294           NaN
#> mungwi            -3.0190820  -61.2711256   -0.7548085 -115.92542137
#> mwandi             1.0585556          NaN          NaN           NaN
#> mwansabombwe     -18.1470643  -34.7067181  -21.8341887   -8.04969452
#> mwense           -42.4829519  -57.5049067  -48.0770690   -7.85490775
#> mwinilunga       -31.8635406          NaN  -29.6309579           NaN
#> nakonde            4.8781446  -33.9275604    0.7680960 -176.77722042
#> nalolo             5.0408740          NaN   -1.1023933           NaN
#> namwala           -1.2266855          NaN   -7.9583827           NaN
#> nchelenge        -21.3061558  -53.4271412  -25.1114264  -11.93691214
#> ndola            -89.1963645  -23.4564406 -101.1265155   24.63520563
#> ngabwe           -29.0373193          NaN  -50.4974133    1.40625215
#> nkeyema                  NaN          NaN  -13.0555839           NaN
#> nsama             -2.9870385  -25.5078614          NaN  -21.29219325
#> nyimba           -12.5222922          NaN  -14.4579941           NaN
#> pemba              9.7570607          NaN    1.6466447           NaN
#> petauke          -15.6596704          NaN  -20.5529596  -14.49245031
#> rufunsa           -3.0635530          NaN   -3.4020217    2.67045664
#> samfya           -36.6162532   84.8650731  -53.4333448  271.97495617
#> senanga            1.2046552          NaN          NaN           NaN
#> serenje          -19.5808493  -28.4615423  -29.8588097   42.37299628
#> sesheke                  NaN          NaN    6.4212946           NaN
#> shang'ombo               NaN          NaN          NaN           NaN
#> shibuyunji        -5.4727996          NaN   -9.0947587           NaN
#> shiwamg'andu      -3.5504190  -58.4231286   -2.1793952   89.16186131
#> siavonga           2.6720286          NaN   -3.9547201           NaN
#> sikongo            1.4697283          NaN   -0.5189304           NaN
#> sinazongwe        17.8660056    3.9786703    2.3459530    4.47311293
#> sinda             -4.0462810          NaN          NaN   -6.31406607
#> sioma                    NaN          NaN          NaN           NaN
#> solwezi         -121.2120130   -9.1358430 -117.4022962    0.51703336
#> vubwi                    NaN          NaN    2.6339524           NaN
#> zambezi           -1.9480360          NaN    3.2241551           NaN
#> zimba             15.9579699          NaN    0.2802479           NaN
#>                      chipata      chipili     chirundu      chisamba
#> chadiza         -11.47677038          NaN          NaN           NaN
#> chama           -34.18278954  -8.66772730          NaN     3.1740193
#> chavuma                  NaN          NaN          NaN     3.8441858
#> chembe                   NaN  -0.54311970          NaN     4.6015943
#> chibombo         28.10645940  35.84086005  -11.4851485   147.2050351
#> chiengi           9.75241327          NaN          NaN     6.7749100
#> chikankanta       6.23815512   3.31481224   -2.6031120   -12.0563104
#> chilanga         37.51163120  33.15747264   13.8794393   -17.4404249
#> chililabombwe     4.63392589  -6.84742101   11.0785390    -0.2304607
#> chilubi                  NaN -45.21040422          NaN           NaN
#> chingola          1.57341462  -7.29807878   -1.1966180     0.9679356
#> chinsali        -14.90724019  -1.73752312          NaN    38.6858952
#> chipata         -57.95007499          NaN   -1.9236900    -6.5851707
#> chipili                  NaN -43.83416722          NaN    19.4503359
#> chirundu          1.73802939          NaN -421.2837355   -26.4024786
#> chisamba          0.15601891  24.24551297  -20.4643112 -1150.5085693
#> chitambo        -55.96521406  -3.44897107   -5.9389363    -0.7974556
#> choma             5.11222459   1.85913565  -37.6273800   -19.5376060
#> chongwe         171.66032049  18.39550070  -36.9525554    -3.9352419
#> gwembe            1.77531598          NaN  -33.1798052   -20.1540956
#> ikelenge                 NaN          NaN          NaN     3.2881438
#> isoka           -13.73176746  -4.47990407    5.5321755    13.1252963
#> itezhi-tezhi             NaN          NaN          NaN   -18.6901079
#> kabompo                  NaN          NaN          NaN    -2.3803292
#> kabwe            10.81799890  29.89320786  -14.3721218    30.7223657
#> kafue            32.41786135   5.88361668   92.2361277   -17.7519548
#> kalabo            9.19206330          NaN          NaN     1.4898053
#> kalomo            5.18332649          NaN  -28.6784117   -16.3196123
#> kalulushi         4.75591195  -0.06923493   -0.3054697     0.7785242
#> kalumbila                NaN  -2.52341843   -2.0241253    -0.3891063
#> kanchibiya               NaN          NaN          NaN           NaN
#> kaoma                    NaN  14.78527423    2.2229534     0.3782190
#> kapiri mposhi    -2.05224341  24.73317223  -17.3474725   -29.4664793
#> kaputa            8.06538006          NaN          NaN     0.8768437
#> kasama          -22.25419158 -11.29071380          NaN    52.8861691
#> kasempa           1.64793855  -1.49583966   -6.5765333   -19.5729214
#> katete          -53.55750535          NaN   -4.5004028    -8.7708356
#> kawambwa                 NaN  67.01963917    4.8919209     6.1121582
#> kazungula         8.16187711          NaN  -14.4746639    -9.1264092
#> kitwe             5.66329018  15.53742445    2.5541690    28.6515522
#> lavushimanda             NaN  -5.29684061   -1.8255517     8.2394332
#> limulunga                NaN          NaN          NaN           NaN
#> livingstone      20.72595816          NaN  -11.9581520    -3.8358967
#> luampa                   NaN   7.67058219          NaN    -5.5062643
#> luangwa          -4.97451784   2.88626742  -26.6848214   -30.7437482
#> luano                    NaN          NaN          NaN   -41.0182191
#> luanshya          4.37593531  11.77281908    4.3678479    26.7967102
#> lufwanyama               NaN  -4.84341482   -4.7171849    -9.7891746
#> lukulu                   NaN          NaN          NaN           NaN
#> lundazi         -99.78187300          NaN          NaN    -1.7991573
#> lunga                    NaN -21.53060667          NaN           NaN
#> lunte district           NaN -36.59167389          NaN     4.8823818
#> lusaka          210.00521217  86.27098685 -201.8235072  -275.0813904
#> luwingu                  NaN  51.49682208          NaN    18.3555583
#> mafinga         -22.18399296          NaN          NaN     1.9879014
#> mambwe          -17.39615021          NaN          NaN           NaN
#> mansa            -8.81183098  -7.03410514   -1.5296124    24.0717865
#> manyinga         10.16785778   0.09083836          NaN    -2.6111338
#> masaiti          -3.26918676   7.22000484    3.2694611    41.8856694
#> mazabuka         11.24684548          NaN  -41.3308990   -23.9629660
#> mbala            -5.52161037  -6.89731795    4.6302450    13.5239154
#> milengi          -6.07059015 -18.43699972          NaN    -3.3356066
#> mitete                   NaN          NaN          NaN           NaN
#> mkushi          -25.28286554   9.24067438  -20.7585669   -24.4553304
#> mongu             9.40438662  26.91239950   -0.7180865    11.7173720
#> monze            13.34048764          NaN  -46.4085267   -31.1053451
#> mpika           -84.81281612   5.62213216    2.4678577    70.2506667
#> mpongwe          -1.16496479  -4.10527599  -10.9001681   -29.3806768
#> mporokoso                NaN -13.79245472          NaN    28.0270898
#> mpulungu                 NaN -26.01579805    2.1330731     9.4352881
#> mufulira          3.04927164  22.31431850    9.2430179     3.6797853
#> mufumbwe                 NaN          NaN          NaN    -6.0936362
#> mulobezi                 NaN          NaN          NaN           NaN
#> mumbwa            6.39653883   9.12526173  -27.3735493   -47.9886426
#> mungwi          -13.23606225  -5.64985798          NaN     4.2072484
#> mwandi                   NaN          NaN          NaN           NaN
#> mwansabombwe             NaN -66.30183705          NaN     2.4618439
#> mwense           -1.09429655 -75.95655026          NaN     7.6929816
#> mwinilunga        6.06155448          NaN          NaN    -1.3350381
#> nakonde         -13.07207134  -0.57759330   16.6618850    12.8997119
#> nalolo                   NaN          NaN          NaN           NaN
#> namwala                  NaN          NaN          NaN   -27.9324750
#> nchelenge                NaN -89.67202232          NaN     5.5833571
#> ndola             8.20619042   1.95912554    9.5986745    48.3359791
#> ngabwe                   NaN          NaN          NaN   -32.9130696
#> nkeyema                  NaN   6.86445749          NaN    -5.8814992
#> nsama             2.13603105          NaN          NaN     1.2613179
#> nyimba           92.33738383          NaN  -17.9085348   -34.7639979
#> pemba             6.59532365   4.00521384  -20.2977106    -9.6813733
#> petauke        -177.71874181          NaN  -16.3112655   -33.6334932
#> rufunsa         157.55627595          NaN  -31.7643666   -48.8284773
#> samfya          -14.18698221 -20.72123849          NaN     9.7044408
#> senanga                  NaN          NaN          NaN    -2.3974520
#> serenje         -51.63056947   6.26453872   -8.7192670     6.8543116
#> sesheke                  NaN          NaN   -2.2869351           NaN
#> shang'ombo               NaN          NaN          NaN           NaN
#> shibuyunji        2.75407036          NaN  -24.2998464   -34.0784235
#> shiwamg'andu    -23.37107523  -9.23613983          NaN    20.4578939
#> siavonga         -0.06061326          NaN   56.9597024   -28.5621110
#> sikongo                  NaN          NaN          NaN     3.3493511
#> sinazongwe        3.22226135          NaN  -36.4742055   -14.0957958
#> sinda           -78.37488325          NaN   -7.2748206   -12.1503891
#> sioma             3.10347308          NaN          NaN           NaN
#> solwezi           5.10057878  -8.23106761   -4.6511545    -2.2275207
#> vubwi           -77.40654912          NaN    1.6763006           NaN
#> zambezi                  NaN          NaN          NaN     3.3743952
#> zimba                    NaN          NaN  -21.2333046    -6.4831879
#>                   chitambo         choma      chongwe        gwembe
#> chadiza                NaN           NaN  29.81928053           NaN
#> chama           -32.812049    9.67680101   9.20634569           NaN
#> chavuma                NaN   -0.85079607   3.33652625           NaN
#> chembe          -17.691478           NaN  -2.37111983           NaN
#> chibombo         39.400112  -20.35511277 258.44493342  -25.41236471
#> chiengi          -4.864834           NaN  13.86338558           NaN
#> chikankanta       4.634419   46.10885112 -29.73898749   -3.48922745
#> chilanga         12.286338   17.60784796  68.67069322  -14.81554702
#> chililabombwe    -9.094186   17.89306066   0.90568536   13.63285895
#> chilubi         -43.658037           NaN  -2.50829402           NaN
#> chingola        -15.091535    1.28732457  -1.17970881    1.03157855
#> chinsali          6.250402    2.41145499  10.17557648           NaN
#> chipata         -57.590856    3.83841460 131.21902619    0.12983968
#> chipili          -1.129791    1.70021146  14.11197624           NaN
#> chirundu         -2.457809  -21.65690439 -58.22996118  -21.30410092
#> chisamba         16.141026   -4.83111942 -17.47280497  -11.55397740
#> chitambo       -505.403508           NaN -13.20255572           NaN
#> choma                  NaN  682.79000039 -29.37128603  211.33116031
#> chongwe           2.289527    6.70226829 565.92677264  -17.29807854
#> gwembe                 NaN  245.65824898 -41.94384372  719.70500412
#> ikelenge               NaN           NaN   1.36065816           NaN
#> isoka             3.068828    5.50952255  11.44960435           NaN
#> itezhi-tezhi           NaN  -56.41910979 -27.01143911  -31.31881724
#> kabompo                NaN           NaN  -0.04322764           NaN
#> kabwe            35.733060    6.15683476 -41.15042922  -12.37345668
#> kafue             7.733689   83.97743969   0.32054218    6.09403272
#> kalabo                 NaN   -5.88810974   8.56906179           NaN
#> kalomo            2.665990  253.71201128 -27.45493685  -67.03039499
#> kalulushi        -9.473029    0.05424006  -2.06721413   -1.93324346
#> kalumbila              NaN   -6.74679618  -1.01805628   -1.78049447
#> kanchibiya      -75.642246           NaN          NaN           NaN
#> kaoma             8.153982  -21.83355568   9.79646777   -6.62801300
#> kapiri mposhi    26.629797    2.78708927 -64.80839101  -10.04728631
#> kaputa                 NaN           NaN   3.60278422           NaN
#> kasama          -24.742168    5.10742730  41.84687143           NaN
#> kasempa                NaN  -20.39176411 -23.53787303   -9.80788296
#> katete                 NaN    5.27042978  97.09234941   -0.42706185
#> kawambwa         -6.332792    5.38919893   6.10067186           NaN
#> kazungula              NaN -110.92293984 -14.37799891  -32.92335551
#> kitwe           -36.679300   23.50294168  26.32053210   15.32538340
#> lavushimanda   -104.209456    0.11234944  -2.54184407           NaN
#> limulunga              NaN   -7.74999088          NaN           NaN
#> livingstone            NaN  -63.14264714  11.29287837  -24.44168119
#> luampa            3.464362           NaN  -7.94869824           NaN
#> luangwa          -9.641463  -10.36139862 -13.63745214           NaN
#> luano                  NaN   -6.34610670 -46.41869403   -7.75627060
#> luanshya        -14.654424   13.34044735  13.28453433    2.80759876
#> lufwanyama       -8.053904   -1.86630417 -11.27765625           NaN
#> lukulu                 NaN           NaN  -3.63348884   -1.31067800
#> lundazi                NaN    1.98415717  34.20663296           NaN
#> lunga           -23.637843           NaN          NaN           NaN
#> lunte district  -11.169836           NaN          NaN           NaN
#> lusaka           28.934679  -86.11584484 413.67755470 -173.80743443
#> luwingu         -14.514230    5.64849969  15.32050485           NaN
#> mafinga          -9.990008           NaN          NaN           NaN
#> mambwe          -61.278212           NaN   6.39536202    0.28110753
#> mansa            12.559255   10.50082394  21.17333949   -0.81107560
#> manyinga               NaN   -3.04487066  -4.36635901           NaN
#> masaiti         -12.570381    7.38706952   7.88409604   -0.78294192
#> mazabuka          5.697056   50.63440946 -56.70029341   13.78330878
#> mbala             7.171013   10.17850225  20.30555593           NaN
#> milengi         -16.464152   -0.58507446  -1.68742494           NaN
#> mitete                 NaN           NaN          NaN           NaN
#> mkushi          -32.156525   -4.70031328 -56.55760890   -7.60077527
#> mongu            16.183050  -13.81149010  23.88082972   -2.84415495
#> monze            -1.740403   65.84515592 -55.85141268  539.22699403
#> mpika            32.087157    4.52774306  32.16797518    0.68944381
#> mpongwe          -9.910226   -9.80976705 -32.51626714   -5.81125215
#> mporokoso         4.143490           NaN  15.89278713           NaN
#> mpulungu         -3.945364           NaN  13.63878516    5.17369262
#> mufulira        -17.010043    2.34491628  69.55349809   -0.72690830
#> mufumbwe               NaN  -19.79887604 -14.18368278           NaN
#> mulobezi               NaN  -37.33262795  -2.95454464           NaN
#> mumbwa           -1.239937  -99.05275984 -49.43505589  -43.17969695
#> mungwi          -12.978218           NaN   7.37019019           NaN
#> mwandi                 NaN  -33.99710843          NaN   -8.19912047
#> mwansabombwe     -4.656422           NaN   3.67001507           NaN
#> mwense          -10.762970    2.46419497   1.06797303           NaN
#> mwinilunga             NaN   -5.88363231  -2.99056981           NaN
#> nakonde           3.133650    7.13950064  13.99343210           NaN
#> nalolo                 NaN           NaN  -0.31962727           NaN
#> namwala                NaN    0.55271027 -44.30204000  -40.74712899
#> nchelenge        -7.347551    6.85816046  15.26765110           NaN
#> ndola           -33.472605   19.44498228  26.10660093    5.22088432
#> ngabwe                 NaN           NaN -35.35593032           NaN
#> nkeyema           2.791829  -29.25196801  -4.51967131   -8.22417235
#> nsama            -3.172745           NaN          NaN           NaN
#> nyimba                 NaN   -4.22528641 100.12160064           NaN
#> pemba                  NaN  270.07970536 -12.24074500  152.91055920
#> petauke                NaN   -4.84476885  35.93040541   -8.70876110
#> rufunsa         -11.695042   -8.31514263 228.99417741  -14.87130352
#> samfya           55.444789    0.64378848   4.97675335           NaN
#> senanga                NaN  -23.29117717  -1.59963730   -4.90721660
#> serenje         -91.846785    1.76742370 -18.56372290   -3.08881045
#> sesheke                NaN  -21.67077152  -1.01565101   -3.50320407
#> shang'ombo             NaN           NaN          NaN           NaN
#> shibuyunji       -1.199628  -34.15428302 -49.43622548  -25.03187779
#> shiwamg'andu    -15.673572    6.50309623   9.10886561           NaN
#> siavonga         -1.917284  -45.05649451 -56.25218375  -46.36463148
#> sikongo                NaN           NaN   5.16984296    0.04550426
#> sinazongwe             NaN  120.17209254 -29.28916406  -38.08398873
#> sinda                  NaN    2.12923484  64.94976219           NaN
#> sioma                  NaN  -17.92253092   4.96780269   -2.97003522
#> solwezi          -4.086527   -8.93512408  -1.58208942   -4.69377114
#> vubwi                  NaN    1.26946052   7.44107543           NaN
#> zambezi                NaN   -5.33125278   6.62320953           NaN
#> zimba                  NaN  -57.30481031 -15.48202679  -52.84822718
#>                    ikelenge       isoka itezhi-tezhi      kabompo        kabwe
#> chadiza                 NaN         NaN          NaN          NaN   -3.5937427
#> chama                   NaN -154.629808    2.1917870          NaN   10.1110222
#> chavuma                 NaN         NaN          NaN  -45.3636225    1.3373788
#> chembe                  NaN         NaN    1.6700508          NaN    5.1933360
#> chibombo                NaN   25.564033  -34.3313150   -1.8743811  132.9555042
#> chiengi                 NaN         NaN          NaN          NaN    4.9150074
#> chikankanta             NaN         NaN   -8.0895498    1.9122417    3.2036780
#> chilanga                NaN   13.237977    5.7657526    3.7986402   -2.7273760
#> chililabombwe     4.0169531    7.205512    1.5773194    3.4742548    6.1277754
#> chilubi                 NaN  -16.713179    2.1013412          NaN   -1.3264214
#> chingola         -3.8428336    4.898047   -6.6099525   19.1836521    4.7041347
#> chinsali                NaN  -72.322045    7.9838052          NaN   76.2282315
#> chipata                 NaN  -13.285260          NaN          NaN    0.2436568
#> chipili                 NaN   -3.110140          NaN          NaN   24.2250899
#> chirundu                NaN    6.489386          NaN          NaN  -13.7714387
#> chisamba          8.0668897   15.676192   -5.8022282    0.5339651   65.9978189
#> chitambo                NaN    4.205715          NaN          NaN    9.1493337
#> choma                   NaN    5.898601  -25.6180285          NaN   -9.2500869
#> chongwe           5.6291251   14.530702   -4.4865261    5.0209971    1.0534646
#> gwembe                  NaN         NaN  -18.9778485          NaN  -18.2671488
#> ikelenge       -712.5158050         NaN          NaN  -37.0370142   -1.9478086
#> isoka                   NaN -590.634906    8.7990100          NaN   23.5275261
#> itezhi-tezhi            NaN    8.970325  159.6220030          NaN  -27.1170348
#> kabompo                 NaN         NaN          NaN -536.3412204   -1.5279310
#> kabwe             3.9318153   28.227381  -10.8678472    4.6214662  271.6649512
#> kafue                   NaN   17.178229   -1.4821337    2.8526498   20.2395098
#> kalabo           -5.4146082         NaN  -12.3542040          NaN    6.4106954
#> kalomo                  NaN         NaN  214.3500512          NaN  -12.8447503
#> kalulushi        -0.8701994    5.816232   -3.5621386    6.8810606   -1.5315402
#> kalumbila       -35.5005049         NaN          NaN  -27.8376209    0.8320738
#> kanchibiya              NaN         NaN          NaN          NaN   -7.6466232
#> kaoma                   NaN         NaN  -54.8333917  -92.8637653    0.7462471
#> kapiri mposhi     6.0817227   40.056324  -12.1191949    3.3677273  149.1559397
#> kaputa                  NaN  -10.702536          NaN          NaN    2.5384758
#> kasama                  NaN  -73.426843          NaN          NaN   98.7685947
#> kasempa          -9.1401445         NaN  -38.8618386   10.4421664  -40.3130866
#> katete                  NaN   -4.148658          NaN          NaN   -3.4204263
#> kawambwa                NaN  -11.063963          NaN          NaN   13.5850940
#> kazungula               NaN    6.747730  -95.7298006          NaN   -8.6402687
#> kitwe             3.3628290   21.992180   -9.5118069   21.4227316   49.8931743
#> lavushimanda            NaN    1.445066          NaN          NaN   22.0812266
#> limulunga               NaN         NaN          NaN          NaN          NaN
#> livingstone             NaN         NaN  -64.0903761          NaN   11.9509136
#> luampa                  NaN         NaN  -85.0822307          NaN   -8.0279256
#> luangwa                 NaN         NaN          NaN          NaN  -33.5887696
#> luano                   NaN         NaN          NaN          NaN  -53.1937419
#> luanshya          1.1260822   10.011059   -1.4977468    5.0425663   55.8290346
#> lufwanyama        0.8765965         NaN   -7.5325334    5.7096348  -25.4053196
#> lukulu                  NaN         NaN  -24.7887696  -58.8259670   -3.6481342
#> lundazi                 NaN  -60.962143          NaN          NaN   -5.5408287
#> lunga                   NaN         NaN          NaN          NaN   -5.3068559
#> lunte district          NaN  -23.221291          NaN          NaN    7.1083754
#> lusaka           13.2311086   55.662493  -67.7309415    2.4462125 -165.1066315
#> luwingu           2.3087788  -22.028634          NaN          NaN   29.7538742
#> mafinga                 NaN -179.598333          NaN          NaN   12.8714193
#> mambwe                  NaN         NaN          NaN          NaN  -10.2317251
#> mansa                   NaN   -5.146503   -0.9336174    1.4077334   46.1735106
#> manyinga        -44.2909787         NaN          NaN   12.1359110   -0.7590386
#> masaiti           0.3369270   13.279580   -1.5967592    4.4029199   82.4010622
#> mazabuka                NaN    8.121426  -29.5991318   -0.4574555  -11.0881841
#> mbala                   NaN  -66.097411    2.7450651          NaN   49.7735996
#> milengi                 NaN         NaN          NaN    2.7141663   -5.1068946
#> mitete                  NaN         NaN          NaN  -46.7576594          NaN
#> mkushi            1.6874557   34.070791   -6.0302987          NaN   19.8368444
#> mongu                   NaN         NaN  -41.9672661  -51.9177435   25.4344524
#> monze                   NaN    2.811920  -43.9233525   -1.5606482  -21.4004205
#> mpika                   NaN   -4.398192    6.4109246          NaN  150.3950756
#> mpongwe                 NaN    3.229211  -11.4052572          NaN  -50.1449234
#> mporokoso               NaN   -7.627294          NaN          NaN   49.9692509
#> mpulungu                NaN  -42.295292    2.5373279          NaN   19.8920917
#> mufulira                NaN    3.340556    1.4416717    3.2850717    3.5896974
#> mufumbwe        -16.7688911         NaN  -47.8395593  -38.2282638  -13.1870252
#> mulobezi                NaN         NaN  -59.0321965          NaN   -6.7764889
#> mumbwa                  NaN         NaN -129.7779054  -18.8658161  -81.7012971
#> mungwi                  NaN -136.163880          NaN          NaN   20.6986139
#> mwandi                  NaN         NaN          NaN          NaN   -3.8254588
#> mwansabombwe            NaN         NaN          NaN          NaN    7.3417927
#> mwense                  NaN   -5.461456          NaN          NaN   13.5739005
#> mwinilunga     -169.6892464         NaN          NaN  -98.1503697   -1.1090377
#> nakonde                 NaN -152.747756   10.5839648          NaN   32.0206624
#> nalolo                  NaN         NaN  -17.0313898          NaN   -0.7804066
#> namwala                 NaN         NaN  191.9140002          NaN  -38.7690186
#> nchelenge               NaN         NaN    2.1977709          NaN    8.3928673
#> ndola             3.8046458   22.311456   -6.7749334    9.5678814  109.8858315
#> ngabwe                  NaN         NaN          NaN          NaN  -10.2850947
#> nkeyema                 NaN         NaN  -71.0885263  -31.7053262  -10.5132237
#> nsama                   NaN         NaN          NaN          NaN    2.9361482
#> nyimba                  NaN         NaN          NaN          NaN  -41.9275863
#> pemba                   NaN         NaN  -16.6929470          NaN   -3.1233692
#> petauke                 NaN   -7.844380   -1.7325209          NaN  -43.2442547
#> rufunsa                 NaN    1.575938          NaN          NaN  -45.6722325
#> samfya                  NaN   -7.019813    0.9796034          NaN   26.8073878
#> senanga                 NaN         NaN  -41.4245168          NaN   -3.1539779
#> serenje                 NaN   21.193040    0.8550883          NaN   55.3878442
#> sesheke                 NaN         NaN          NaN          NaN   -0.7321363
#> shang'ombo              NaN         NaN          NaN          NaN          NaN
#> shibuyunji              NaN         NaN  -18.6774066          NaN  -45.9054957
#> shiwamg'andu            NaN  -19.963273    7.0908022          NaN   41.3163735
#> siavonga                NaN         NaN  -12.8810855          NaN  -26.2206818
#> sikongo                 NaN         NaN   -9.0019897          NaN    2.4710223
#> sinazongwe              NaN         NaN  -25.8735393          NaN  -10.0036704
#> sinda                   NaN   -3.723283    1.0694529          NaN  -12.7033283
#> sioma                   NaN         NaN          NaN          NaN   -1.5138095
#> solwezi           2.9366475         NaN  -20.5697683   47.9605128   -4.9028523
#> vubwi                   NaN         NaN          NaN          NaN   -2.8194823
#> zambezi         -27.2374196         NaN          NaN -112.2467741    8.3997649
#> zimba                   NaN         NaN  -46.0906371          NaN   -7.5753421
#>                      kafue       kalabo        kalomo    kalulushi
#> chadiza          3.1921705          NaN           NaN    0.3912247
#> chama           10.5052307          NaN    5.35736485   -3.1299441
#> chavuma                NaN          NaN           NaN          NaN
#> chembe           1.0454598          NaN           NaN  -39.2733533
#> chibombo        25.4634253    9.3829339  -15.31718841   -7.1402184
#> chiengi                NaN          NaN           NaN   -3.2459968
#> chikankanta    290.2837219    3.6701607   25.54854156   -2.1548194
#> chilanga       391.9798116   44.7433422    8.01438634   -2.1620007
#> chililabombwe   11.8608032    6.6825411   33.96359915  -70.3187004
#> chilubi          4.8462160          NaN           NaN  -19.4645964
#> chingola        12.5092686   11.2316374    6.94526134    6.1522937
#> chinsali        44.3992728          NaN    5.31220165    2.6514054
#> chipata         19.2488505    9.6367110    4.54834913   -0.8941292
#> chipili          4.1745756          NaN           NaN   -8.9411259
#> chirundu        62.4605125          NaN  -13.99412960   -0.9729080
#> chisamba       -21.8055061    3.8530813   -3.21467601    2.4557335
#> chitambo        -2.8387336          NaN    2.02601280  -25.4666216
#> choma           39.1259833   -1.9499546  320.58475199   -3.5954993
#> chongwe          6.2663163   14.0238951    2.62606794    2.0483320
#> gwembe         -20.9370203          NaN  -44.23734418   -3.3821233
#> ikelenge               NaN   -9.2669703           NaN  -11.7154717
#> isoka           14.3548389          NaN           NaN    3.2642485
#> itezhi-tezhi   -19.5395814   -6.4695341  184.19242693   -9.8467926
#> kabompo         -0.3267367          NaN           NaN   -1.6108888
#> kabwe           -1.7232073   11.5045297    1.88119832   -8.2356843
#> kafue          471.6497214   10.7353787   46.42178574    7.7072173
#> kalabo           6.7250898  582.3801362   -8.70696229    3.8751862
#> kalomo          11.8618153   -3.7919745 1373.50209110   -1.2120781
#> kalulushi        5.1383655    7.7761895    3.37368392 -327.5977980
#> kalumbila       -2.6278612          NaN   -6.64754387  -18.3754240
#> kanchibiya             NaN          NaN           NaN          NaN
#> kaoma           13.7789041  -36.9366755  -30.10366871   -6.7793631
#> kapiri mposhi  -13.7327747    2.4749777    2.73913875  -30.5390722
#> kaputa                 NaN          NaN           NaN   -4.8595056
#> kasama          53.1320260          NaN    5.78788936   -7.1268785
#> kasempa        -15.4299678   -5.8120262  -11.88002468  -45.6944322
#> katete           5.5634376          NaN    2.95284073          NaN
#> kawambwa        10.3159143          NaN    3.14511779  -11.6759377
#> kazungula       10.1705942   -8.6010983  -27.62750093   -3.5590457
#> kitwe           18.6832863   13.7656362   10.08146157  281.5668023
#> lavushimanda     4.8553880          NaN           NaN  -13.2358262
#> limulunga        0.1526145  -79.6234725  -11.78747622          NaN
#> livingstone     63.8496762   -0.4483918 -158.74115697    5.6108865
#> luampa          -3.8260180  -20.6893850  -52.25866060          NaN
#> luangwa        -37.7642929          NaN           NaN          NaN
#> luano          -28.8722505          NaN           NaN          NaN
#> luanshya        13.1745217    1.3815649    9.15457922  -11.6755620
#> lufwanyama      -8.3644921    1.9087505   -3.04417935  182.9176884
#> lukulu          -0.8958575  -77.5355299  -13.91669530          NaN
#> lundazi          4.0507721          NaN    1.49353880          NaN
#> lunga                  NaN          NaN           NaN          NaN
#> lunte district   9.8909603          NaN           NaN          NaN
#> lusaka         247.3653467   76.6676397  -67.86449193  -21.8793936
#> luwingu         11.7617030          NaN           NaN   -3.8783254
#> mafinga                NaN          NaN           NaN          NaN
#> mambwe          -2.1704205    6.6123265           NaN          NaN
#> mansa            8.2813639    3.8345043    0.05704771  -65.7769383
#> manyinga               NaN  -30.1547069           NaN   -2.5328503
#> masaiti         12.6791680    8.3209977    9.44827289  -40.4952780
#> mazabuka       178.4363382   13.8483929   13.43506840   -5.9663530
#> mbala           18.0409970          NaN   12.63588886    5.7613584
#> milengi         -2.7201715          NaN    1.63410631  -46.4139000
#> mitete                 NaN          NaN           NaN          NaN
#> mkushi         -17.6575686          NaN   -0.38066323  -52.3837310
#> mongu           22.4876419  502.7950568  -29.83514493   -3.4827376
#> monze           49.6531641    0.9643614  -51.12673557   -5.0356633
#> mpika           51.1416135    3.2396178    3.29218759   -4.2659457
#> mpongwe        -16.1127917          NaN   -8.03351577  -95.6915012
#> mporokoso       34.1942402    6.5629608           NaN    0.3840137
#> mpulungu        13.7978134          NaN           NaN   -1.0451078
#> mufulira        31.3927621          NaN    3.27209569   27.7888198
#> mufumbwe        -8.8147351          NaN  -23.01158820  -15.8054992
#> mulobezi               NaN  -15.0178155  -56.78207042          NaN
#> mumbwa         -33.0808166    7.9885218  -95.40417551  -37.7224687
#> mungwi           1.8531412          NaN    5.99194718   -1.0859920
#> mwandi           3.4255559  -10.6193208  -62.14075505          NaN
#> mwansabombwe     3.1957039          NaN           NaN  -13.3213241
#> mwense          -0.9931894          NaN           NaN  -29.6915349
#> mwinilunga      -2.3012859  -23.8050295   -6.77769551  -18.4689247
#> nakonde          9.5729913          NaN    5.63006108    1.5336321
#> nalolo           1.1013259  125.9111960           NaN          NaN
#> namwala        -23.1740174          NaN  -34.41875796          NaN
#> nchelenge        1.1748423          NaN           NaN  -18.1429681
#> ndola           21.9896069    6.8165011    8.27964505 -116.3750109
#> ngabwe         -18.9802801          NaN           NaN  -41.4445852
#> nkeyema          1.4275264    3.2823891  -35.70519913          NaN
#> nsama                  NaN          NaN           NaN          NaN
#> nyimba         -11.9620617          NaN   -2.09467426  -15.1737552
#> pemba           26.4334892          NaN  -24.12608847          NaN
#> petauke        -14.5047638   12.3954110   -2.48834038  -20.3861475
#> rufunsa        -35.9854462          NaN   -5.48824210   -7.6530515
#> samfya           0.4498302    5.8365663           NaN  -42.7050002
#> senanga          1.5255163  -50.3231056  -36.52754626          NaN
#> serenje          1.5960046          NaN    8.68877737  -24.2563163
#> sesheke          6.1955793  -21.3535958  -44.47243598    3.4024220
#> shang'ombo       1.1102154  -67.2019296           NaN          NaN
#> shibuyunji     219.8704747   24.9747479  -23.30072083          NaN
#> shiwamg'andu    22.2541913          NaN    6.36893897   -3.4206628
#> siavonga       -13.6216881          NaN  -31.19377220   -2.3668625
#> sikongo         13.8332939   15.0419956           NaN          NaN
#> sinazongwe     -10.7008284          NaN -113.70465279   -0.6978962
#> sinda           -2.6593853          NaN           NaN   -5.2778324
#> sioma                  NaN  -49.4051789  -29.45907512          NaN
#> solwezi         -5.6665450   -3.8187545   -8.89680154  -85.7573898
#> vubwi                  NaN          NaN    2.99091174    1.1143807
#> zambezi          0.6957652 -124.4246822           NaN    1.3732701
#> zimba           12.2086858          NaN   24.67683900          NaN
#>                    kalumbila    kanchibiya        kaoma kapiri mposhi
#> chadiza                  NaN           NaN    4.1995387    -8.1751389
#> chama                    NaN           NaN   10.5730774     6.3208646
#> chavuma         -12.41589574           NaN  -20.0748512     1.5495061
#> chembe           -6.06625104           NaN          NaN    -6.6340247
#> chibombo          7.28383151           NaN   11.9879496   110.3496815
#> chiengi                  NaN           NaN          NaN     5.8517330
#> chikankanta       0.97169287           NaN    9.6126459     6.9915543
#> chilanga          2.66163015           NaN   96.4270876    -0.8784253
#> chililabombwe    -2.93179979    -7.8347010   -0.1561396    10.2243796
#> chilubi          -0.55004774   -90.0144905          NaN    -9.1358388
#> chingola         32.51791265           NaN   -2.3708423    -9.2651004
#> chinsali                 NaN           NaN          NaN    76.7245508
#> chipata                  NaN           NaN          NaN   -11.4378390
#> chipili          -0.06130882           NaN   16.2274491    19.6516414
#> chirundu          0.46661258           NaN    7.2999485   -12.2213082
#> chisamba          9.87571136           NaN    8.8525320    17.2973209
#> chitambo                 NaN   -72.2906300    8.9341784    -3.2844666
#> choma            -2.91272957           NaN  -10.4882110    -4.5730176
#> chongwe          10.06027042           NaN   24.8086015   -16.0492778
#> gwembe            0.74406127           NaN   -2.2895772   -11.5908775
#> ikelenge        -66.09849003           NaN          NaN    -0.6334704
#> isoka                    NaN           NaN          NaN    34.9997250
#> itezhi-tezhi             NaN           NaN  -38.8144999   -22.6463244
#> kabompo         -25.72675325           NaN  -98.9594651    -1.9154464
#> kabwe            21.92977570    -0.5591586   14.3284327   198.4142282
#> kafue             3.11523709           NaN   26.4542637    14.4355189
#> kalabo                   NaN           NaN  -47.2690399     0.1048594
#> kalomo           -3.12431536           NaN  -18.2705769    -6.1446829
#> kalulushi        23.64963912           NaN    2.0925394   -11.8895957
#> kalumbila      -909.92407533           NaN  -31.8925606    -1.2953988
#> kanchibiya               NaN -1385.1127778          NaN   -16.7207002
#> kaoma           -28.20181825           NaN  197.7424611    -0.4847640
#> kapiri mposhi    18.63400199    -9.1410661    9.8201586  -729.3070438
#> kaputa                   NaN           NaN          NaN           NaN
#> kasama                   NaN  -136.4419407   56.8225506    91.7304522
#> kasempa          -8.19943248           NaN   -6.1732690   -38.8789967
#> katete            5.92013549           NaN    3.5757775   -13.5267376
#> kawambwa                 NaN           NaN          NaN    12.1520898
#> kazungula                NaN           NaN  -27.0489073    -4.5928552
#> kitwe            51.47815816   -24.0335342    7.8191750    -3.3269941
#> lavushimanda             NaN   -73.5850021    7.2223064    17.8777178
#> limulunga                NaN           NaN  -80.5427743           NaN
#> livingstone       4.93484116           NaN  -13.4606753     8.8048569
#> luampa                   NaN           NaN  -62.3741287    -7.1876943
#> luangwa                  NaN           NaN    2.7366577   -37.1687077
#> luano                    NaN           NaN          NaN   -21.4994674
#> luanshya         23.67699035           NaN    0.7570426    47.3786743
#> lufwanyama       12.38727906           NaN   -5.1343413   -37.4999036
#> lukulu          -23.74428982           NaN -123.8024393           NaN
#> lundazi           1.70689191           NaN    5.3148920    -6.2473153
#> lunga                    NaN           NaN          NaN           NaN
#> lunte district           NaN           NaN    3.8531702     5.0394436
#> lusaka           20.51377291    -8.6229681  117.2288827  -139.4428233
#> luwingu           5.40617586           NaN   21.4485563    22.7140383
#> mafinga                  NaN           NaN          NaN    -0.1612177
#> mambwe                   NaN           NaN          NaN   -14.7838172
#> mansa           -10.79378244           NaN   18.6872352    24.7846928
#> manyinga        -75.68698039           NaN  -74.2573659    -2.5947316
#> masaiti          20.21586774           NaN    0.1186392    66.6938605
#> mazabuka          1.47270796           NaN    8.5592228    -3.9975197
#> mbala                    NaN   -31.8284332   29.9994662    42.9299186
#> milengi                  NaN           NaN    7.3641410   -16.0053732
#> mitete                   NaN           NaN  -46.2218867           NaN
#> mkushi                   NaN           NaN   11.5663533   -31.0413070
#> mongu           -12.77169754           NaN  -59.3372699    18.6681567
#> monze            -2.50454801           NaN   -3.9844815   -10.0604049
#> mpika                    NaN  -146.8871803   34.7541755   161.1888752
#> mpongwe         -14.31379314           NaN   -6.7687519    25.2863631
#> mporokoso                NaN           NaN  178.9959761    44.6588733
#> mpulungu          1.64193275           NaN   18.0242116    23.2618853
#> mufulira          5.32548859           NaN    6.4121421   -15.8980858
#> mufumbwe        -42.26906948           NaN  -97.3545037   -13.5194728
#> mulobezi                 NaN           NaN  -40.6122987           NaN
#> mumbwa          -24.89364070           NaN   -9.8976639   -70.1576046
#> mungwi                   NaN           NaN   89.7028369    26.6222112
#> mwandi                   NaN           NaN  -19.5905751           NaN
#> mwansabombwe             NaN           NaN          NaN     2.7449629
#> mwense                   NaN           NaN          NaN     6.4366592
#> mwinilunga     -161.16231402           NaN  -57.4315212    -2.0503138
#> nakonde                  NaN   -39.6228577    4.7981655    48.9078485
#> nalolo                   NaN           NaN  -37.4174729     1.0412345
#> namwala          -4.51635163           NaN  -16.2223380   -27.2152371
#> nchelenge                NaN           NaN          NaN     4.4070270
#> ndola            35.43946396           NaN    5.9961683    63.3908435
#> ngabwe                   NaN           NaN          NaN    37.4436133
#> nkeyema         -19.29743602           NaN  111.6446668   -10.2674992
#> nsama                    NaN           NaN          NaN     2.6863674
#> nyimba            0.55538585           NaN          NaN   -61.9131325
#> pemba             1.78785550           NaN   -1.6536440     0.1475265
#> petauke                  NaN           NaN    2.5497970   -62.6742988
#> rufunsa                  NaN           NaN    1.7550040   -54.5974620
#> samfya           -4.09472124   -71.2325218   13.6348645    13.2473320
#> senanga          -6.20057544           NaN  -64.0651044    -3.7350874
#> serenje                  NaN   -42.6203351   13.5003709    37.3447103
#> sesheke          -2.01599006           NaN  -25.5489775    -2.3984252
#> shang'ombo               NaN           NaN  -29.3834497           NaN
#> shibuyunji               NaN           NaN   10.6770748   -34.9149336
#> shiwamg'andu             NaN   -92.5398848          NaN    43.0944693
#> siavonga          0.29841296           NaN    5.0905140   -12.6248378
#> sikongo                  NaN           NaN  -33.3053269     1.7000972
#> sinazongwe               NaN           NaN   -5.2598318    -7.1096970
#> sinda                    NaN           NaN          NaN   -19.4332524
#> sioma                    NaN           NaN  -33.2777562           NaN
#> solwezi         130.63641634           NaN  -17.7683677   -14.7681193
#> vubwi                    NaN           NaN          NaN    -4.1034728
#> zambezi         -16.82862426           NaN  -94.4907838     5.5766790
#> zimba                    NaN           NaN   -8.2037882    -4.7129948
#>                      kaputa        kasama     kasempa       katete    kawambwa
#> chadiza                 NaN   -7.48043274         NaN  143.9517962         NaN
#> chama                   NaN  -46.14449344         NaN  -27.0715058  -15.434859
#> chavuma           5.3074275           NaN  -0.6634622          NaN         NaN
#> chembe           -5.4061065   13.48649503  -5.3840156          NaN   -9.347170
#> chibombo                NaN  122.08312987 -29.5406389   17.8069432   24.502700
#> chiengi        -226.2592935  -63.31803651         NaN          NaN -140.551613
#> chikankanta             NaN   47.51857524  -2.4015768    2.4430847         NaN
#> chilanga          4.6887629   76.34845609  -3.8436698   21.6646631   11.465395
#> chililabombwe    -0.7246278    3.32216341 -11.4702285   -1.4298494   -4.367476
#> chilubi                 NaN   79.88520115         NaN          NaN  -61.485485
#> chingola         -2.9373197    6.29421388  -6.3288616    0.4923678   -6.201691
#> chinsali                NaN -110.96959003         NaN   -9.6025029  -17.312459
#> chipata           8.1050556  -20.96235072   1.8342265 -146.5096173         NaN
#> chipili                 NaN    6.18319648  -0.5665962          NaN   83.633968
#> chirundu                NaN           NaN  -0.2325743   -2.2126225    6.015387
#> chisamba          1.9210291   66.78876140  -1.7137610   -4.3044748    9.394406
#> chitambo                NaN  -19.87382403         NaN          NaN   -7.070356
#> choma                   NaN    5.93343050 -11.7650402    5.6051182    5.867143
#> chongwe           5.3076741   55.68064851  -3.3925242  122.7114277    9.587155
#> gwembe                  NaN           NaN  -4.6512700    0.3562010         NaN
#> ikelenge                NaN           NaN -20.7424836          NaN         NaN
#> isoka           -10.9981420  -71.33723054         NaN   -6.3674079  -12.268300
#> itezhi-tezhi            NaN           NaN -31.5224307          NaN         NaN
#> kabompo                 NaN           NaN   1.1939350          NaN         NaN
#> kabwe             4.5047866  121.59465935  -7.4406789    2.7700929   19.586445
#> kafue                   NaN   65.03518399  -3.7256368   13.3312973   13.366063
#> kalabo                  NaN           NaN  -8.7745867          NaN         NaN
#> kalomo                  NaN    6.30542248  -4.5115329    2.8131773    3.321911
#> kalulushi        -0.9679427    6.39889293  -7.3233618          NaN   -2.202882
#> kalumbila               NaN           NaN -32.6934093    4.6435800         NaN
#> kanchibiya              NaN -130.04539298         NaN          NaN         NaN
#> kaoma                   NaN   55.48290438 -15.6282154    3.0085502         NaN
#> kapiri mposhi           NaN  113.77334390 -11.0523680   -8.4907971   18.442453
#> kaputa         -564.4865796  -43.36438089         NaN    2.0290307 -109.624019
#> kasama          -46.9937481 -347.05837967         NaN  -15.8116597  -90.363380
#> kasempa                 NaN           NaN 392.7518588          NaN         NaN
#> katete            2.7313119  -10.90055959         NaN  593.4857948    2.143370
#> kawambwa       -101.7172696  -77.11428836         NaN    1.2398712  181.878428
#> kazungula               NaN           NaN  -9.1490210    1.1804751         NaN
#> kitwe             0.2700185   46.25675504   0.1004691   -4.4997460   11.076084
#> lavushimanda            NaN  -20.15083472         NaN          NaN         NaN
#> limulunga               NaN           NaN -11.8688419          NaN         NaN
#> livingstone       5.0197012   15.12173326  -5.7161471   10.7338173         NaN
#> luampa                  NaN   18.05003062 -33.0221087          NaN         NaN
#> luangwa                 NaN   -0.02438987         NaN  -12.5527871         NaN
#> luano                   NaN           NaN         NaN          NaN         NaN
#> luanshya                NaN   17.74097165  -0.9963467   -1.7697440    1.736485
#> lufwanyama              NaN   -3.26008152 -21.1115932   -0.2958089   -4.405673
#> lukulu                  NaN           NaN -27.2408223          NaN         NaN
#> lundazi                 NaN  -57.12647918         NaN  -79.1422369         NaN
#> lunga                   NaN  -50.72726597         NaN          NaN         NaN
#> lunte district  -64.8442005  -30.08138913         NaN          NaN  -87.249492
#> lusaka            4.6788950  253.13136272 -38.1895529  115.6767378   50.956445
#> luwingu         -42.3621639 -100.39110228         NaN          NaN  -65.876849
#> mafinga                 NaN  -64.98895945         NaN          NaN         NaN
#> mambwe                  NaN  -22.13204510         NaN  -82.1996550         NaN
#> mansa           -35.0563279  -19.79003515  -8.3955395   -8.5642759  -50.270736
#> manyinga                NaN    1.99929845 -17.8393035          NaN         NaN
#> masaiti           0.7753473   10.34330670  -0.5437371   -1.9561823   -2.168026
#> mazabuka                NaN   68.41035799 -13.4178996    4.6617763         NaN
#> mbala           -68.7224016  -38.13952643         NaN    1.0258934  -42.056794
#> milengi          -6.4073726  -25.02526104         NaN          NaN  -19.890809
#> mitete                  NaN           NaN         NaN          NaN         NaN
#> mkushi           -1.7140077   67.07998630         NaN  -31.3213310    2.569520
#> mongu                   NaN   61.55877698  -8.6919945   10.2390352    4.636175
#> monze                   NaN    8.77625159 -15.8271563    3.4567197    4.531803
#> mpika            -6.9164842   93.27986362   3.0667949  -78.9977725  -18.030329
#> mpongwe                 NaN    0.73251087 -46.0996293          NaN         NaN
#> mporokoso       -81.8595249  250.31161314         NaN          NaN   98.936636
#> mpulungu       -115.3199303  -95.46220388         NaN          NaN  -81.097973
#> mufulira         -0.7469140   43.99623768 -15.7476586   -1.6773336    5.900931
#> mufumbwe                NaN           NaN   9.5068883          NaN         NaN
#> mulobezi                NaN           NaN -11.2762637          NaN         NaN
#> mumbwa                  NaN   23.41464558 -92.3978002    0.4525094    5.836135
#> mungwi          -40.0318192  -68.79207839         NaN          NaN  -41.084852
#> mwandi                  NaN           NaN         NaN          NaN         NaN
#> mwansabombwe    -54.6720438  -39.01302499         NaN          NaN  -81.261937
#> mwense          -44.2139425  -51.77741142         NaN   -2.0770705  -85.321763
#> mwinilunga              NaN    1.77752036 -49.2664721    2.1748308         NaN
#> nakonde         -27.4550712 -116.05287127   1.7631703          NaN  -16.493120
#> nalolo                  NaN           NaN  -4.9903410    3.1170979         NaN
#> namwala                 NaN           NaN -20.7466211          NaN         NaN
#> nchelenge      -173.1304575  -75.13277937         NaN    0.7055301 -191.617954
#> ndola             3.4270378   22.07141453  -6.5007702   -2.6776196    6.564333
#> ngabwe                  NaN   -0.24801687         NaN          NaN         NaN
#> nkeyema                 NaN   16.81842579 -47.2831709    4.4695215         NaN
#> nsama            13.1647641   56.32206660         NaN          NaN  -71.675622
#> nyimba                  NaN   -9.34867513         NaN   24.1454312         NaN
#> pemba                   NaN           NaN  -2.5695843    2.3420528         NaN
#> petauke                 NaN           NaN         NaN -210.7027416   -3.429444
#> rufunsa                 NaN    4.22312352         NaN  108.3392183         NaN
#> samfya                  NaN  -53.31245815  -5.8833045          NaN  -27.064427
#> senanga                 NaN           NaN  -7.3778657    3.9691544    5.264551
#> serenje          -1.8870391   33.85472176  -5.3917198          NaN    1.054462
#> sesheke                 NaN           NaN  -5.3015579    5.2594456         NaN
#> shang'ombo              NaN           NaN         NaN          NaN         NaN
#> shibuyunji              NaN           NaN         NaN          NaN         NaN
#> shiwamg'andu    -12.6713983  -48.53967635         NaN          NaN         NaN
#> siavonga                NaN    7.54779808         NaN          NaN    3.418282
#> sikongo                 NaN    5.00703927         NaN          NaN         NaN
#> sinazongwe              NaN    3.36756110         NaN    1.2817008    2.470451
#> sinda                   NaN  -10.14443838         NaN  123.4293396         NaN
#> sioma                   NaN           NaN  -5.3046508          NaN         NaN
#> solwezi                 NaN   11.94611963   1.7999776    1.8927898   -6.805551
#> vubwi                   NaN           NaN         NaN   79.4219411         NaN
#> zambezi                 NaN    5.32148906   4.6788766    8.0146536         NaN
#> zimba                   NaN    7.54525715  -2.1289980          NaN         NaN
#>                   kazungula        kitwe  lavushimanda    limulunga
#> chadiza           2.1161204   -3.2641185           NaN          NaN
#> chama                   NaN  -11.9576211  -37.06643359          NaN
#> chavuma                 NaN    1.8992634           NaN          NaN
#> chembe                  NaN  -66.7768097           NaN          NaN
#> chibombo         -5.7032506   73.2950479   36.41320167          NaN
#> chiengi                 NaN   -6.7886108           NaN          NaN
#> chikankanta      20.7213060   14.8622654    6.03711047          NaN
#> chilanga          7.9585580   20.5421746   14.75153680    7.1796364
#> chililabombwe    24.4796300  -99.6762112   -5.83380451          NaN
#> chilubi                 NaN  -45.2853241           NaN          NaN
#> chingola          5.1794612  -41.3577858   -8.21889906          NaN
#> chinsali                NaN   16.5944410    1.70773416          NaN
#> chipata           8.2563665   -6.7709972           NaN          NaN
#> chipili                 NaN   -2.9927997   -3.79239226          NaN
#> chirundu         -5.3549853    3.8358544   -0.09935470          NaN
#> chisamba         -0.7746887   46.3567268   17.69142277          NaN
#> chitambo                NaN  -75.2245091 -105.57694772          NaN
#> choma           -53.4634182   16.3740549    0.64049940   -4.7313969
#> chongwe           2.6650224   49.1539233    5.52369796          NaN
#> gwembe          -14.5929457   12.8491488           NaN          NaN
#> ikelenge                NaN  -15.5444265           NaN          NaN
#> isoka             6.7546688   15.0636130    0.12416132          NaN
#> itezhi-tezhi    -82.5272826  -18.8534167           NaN          NaN
#> kabompo                 NaN    6.6346601           NaN          NaN
#> kabwe             2.5608727   58.0627654   37.17923749          NaN
#> kafue            32.5446008   30.3158269   11.03550038    2.1946428
#> kalabo          -12.5226132    7.7947778           NaN -116.2177756
#> kalomo           51.6136943    2.5701525           NaN   -8.7886287
#> kalulushi        -0.6707261  365.3463749   -5.77524419          NaN
#> kalumbila               NaN  -13.3983049           NaN          NaN
#> kanchibiya              NaN  -46.3754898  -77.70867319          NaN
#> kaoma           -32.4334597   -6.6877037    6.71746130  -96.5612424
#> kapiri mposhi     3.3895098  -19.9213598   33.39796212          NaN
#> kaputa                  NaN   -8.2280996           NaN          NaN
#> kasama                  NaN    9.2533713  -25.08144551          NaN
#> kasempa          -9.7666002  -59.6675697           NaN  -12.2603186
#> katete            1.5466403  -10.9382715           NaN          NaN
#> kawambwa                NaN  -11.1206506           NaN          NaN
#> kazungula      -151.6145840    3.7590323           NaN          NaN
#> kitwe            10.9744134  811.3123790  -15.12099019   -0.9096115
#> lavushimanda            NaN  -34.6258897 -951.54140145          NaN
#> limulunga               NaN   -3.2691883           NaN -981.0906160
#> livingstone    -130.6043891   31.6334121           NaN   -9.3825279
#> luampa          -55.4846252   -9.2402670    3.07786576  -53.9021572
#> luangwa                 NaN  -16.5652739           NaN          NaN
#> luano            -0.7694780  -42.3671181           NaN          NaN
#> luanshya          7.7465627  199.8215524   -7.02186605          NaN
#> lufwanyama       -0.1620738  -37.3468610           NaN          NaN
#> lukulu          -15.8620560          NaN           NaN -100.1114976
#> lundazi           2.4291745  -10.9027125  -46.79975141          NaN
#> lunga                   NaN  -44.1494944           NaN          NaN
#> lunte district          NaN  -18.0795024  -10.67035259          NaN
#> lusaka           -4.8531939   91.1196749   42.58151885    0.8146093
#> luwingu                 NaN    1.0228760  -21.26397302          NaN
#> mafinga                 NaN   -2.3300714  -11.68981974          NaN
#> mambwe            5.8137345  -18.5095491           NaN          NaN
#> mansa                   NaN -122.1553034  -25.44443483          NaN
#> manyinga         -4.8022344   -3.9415345           NaN          NaN
#> masaiti           3.4850593  -72.7026997   -4.16014621          NaN
#> mazabuka         19.4763787    6.6934620    8.77217966          NaN
#> mbala             5.1043544   21.7299005    4.63611388          NaN
#> milengi                 NaN -124.4720707  -20.09925720          NaN
#> mitete                  NaN          NaN           NaN          NaN
#> mkushi                  NaN -146.7695179   -4.62693868          NaN
#> mongu           -35.4236009    6.3630571   12.49421551 -138.2652595
#> monze            -7.8157285    6.2766250   -0.03386004          NaN
#> mpika             3.1390697   -4.5251595  -67.69729556          NaN
#> mpongwe          -3.2487947 -162.4206150   -3.69279976          NaN
#> mporokoso               NaN   15.4713479    5.70757822          NaN
#> mpulungu          6.2033527   -1.9191963   -2.63615348          NaN
#> mufulira          1.1865705  -53.5619360   -9.31869879          NaN
#> mufumbwe                NaN  -10.3045746           NaN  -32.8585719
#> mulobezi        -69.4580118          NaN           NaN  -27.8565298
#> mumbwa          -53.0904653  -65.1977366    1.35187157  -13.7769277
#> mungwi                  NaN   -2.5233940  -14.92152323          NaN
#> mwandi          -74.7628745          NaN           NaN  -16.7315038
#> mwansabombwe            NaN  -19.3694060           NaN          NaN
#> mwense                  NaN  -50.0344730           NaN          NaN
#> mwinilunga              NaN  -14.4263955           NaN          NaN
#> nakonde                 NaN   19.8670100   -3.19968593          NaN
#> nalolo          -19.5273204    2.0986644           NaN  -86.9534097
#> namwala         -54.4332804  -17.9208349           NaN          NaN
#> nchelenge               NaN  -24.6992486           NaN          NaN
#> ndola            10.2862193 -215.6996653  -19.50723830          NaN
#> ngabwe                  NaN  -75.7329090           NaN          NaN
#> nkeyema                 NaN  -16.4623070    2.66932873  -29.8555945
#> nsama                   NaN   -7.6700333   -2.73535217          NaN
#> nyimba            1.4360328  -35.6698943           NaN          NaN
#> pemba            -4.1573717    5.9120264           NaN          NaN
#> petauke           1.6345174  -55.4647332  -77.40397927          NaN
#> rufunsa          -1.1941382  -13.7476119   -2.44168315          NaN
#> samfya                  NaN -105.1805710  -40.32093647          NaN
#> senanga         -52.4258004    2.5540702           NaN  -80.7861604
#> serenje           2.2830198  -76.2827175  -48.94441580          NaN
#> sesheke         -65.6346452    6.8010204           NaN  -32.5788796
#> shang'ombo              NaN          NaN           NaN          NaN
#> shibuyunji              NaN  -17.0398437           NaN          NaN
#> shiwamg'andu      5.6624447    1.1905678  -20.21834908          NaN
#> siavonga        -11.5895323    8.6541156    0.19380026          NaN
#> sikongo         -10.9325792    9.6309767           NaN  -76.7076556
#> sinazongwe      -61.2930239    9.4910014    2.30276076   -1.4174134
#> sinda                   NaN  -16.8996190           NaN          NaN
#> sioma           -47.3764927   -0.1028126           NaN  -51.8096615
#> solwezi          -4.7553862  -84.6309344           NaN          NaN
#> vubwi                   NaN   -2.3430867           NaN          NaN
#> zambezi                 NaN   13.2620533           NaN          NaN
#> zimba           -22.7951912    7.5464683           NaN          NaN
#>                 livingstone       luampa     luangwa       luano     luanshya
#> chadiza           5.3781536          NaN  -7.1943613         NaN   -2.6169468
#> chama             8.6377228          NaN         NaN         NaN          NaN
#> chavuma                 NaN          NaN         NaN         NaN    1.4482435
#> chembe                  NaN          NaN         NaN         NaN  -21.9976909
#> chibombo         31.9149296   -6.5856608  -5.1179964  -26.285634   68.3278768
#> chiengi                 NaN          NaN         NaN         NaN   -2.2476333
#> chikankanta      72.2443699          NaN -10.1995350         NaN    5.1153455
#> chilanga         56.9318443   29.9972258   2.2195318  -15.790936   10.2670231
#> chililabombwe    19.9945541          NaN   0.7910582         NaN  -35.5114589
#> chilubi                 NaN          NaN         NaN         NaN  -23.5176426
#> chingola         15.0940070   -4.1624331         NaN         NaN  -54.7129723
#> chinsali          7.6256938          NaN         NaN         NaN    8.3438132
#> chipata          21.4048768          NaN  -7.3200584         NaN   -4.8236419
#> chipili                 NaN    8.3706390   2.9935281         NaN    0.7867967
#> chirundu          1.6898348          NaN -12.6174998         NaN    2.5738240
#> chisamba          6.8566303    0.9941488 -13.1673109  -24.386520   28.3184557
#> chitambo                NaN    3.8623433 -11.0362873         NaN  -42.2605557
#> choma            26.2797367          NaN  -8.2201433   -6.790520    6.6362930
#> chongwe          39.8160710    2.1673774  35.4031773  -22.718695   19.1293370
#> gwembe            5.7180308          NaN         NaN   -6.890317   -0.1516710
#> ikelenge                NaN          NaN         NaN         NaN   -6.9961951
#> isoka                   NaN          NaN         NaN         NaN    5.8052529
#> itezhi-tezhi    -48.2568938  -65.3059513         NaN         NaN   -9.3022429
#> kabompo                 NaN          NaN         NaN         NaN   -1.0302355
#> kabwe            27.8141818    2.3293171 -16.3388258  -36.490015   39.4924607
#> kafue           103.8711000    4.2041946 -12.5288209  -15.811619   16.0083120
#> kalabo           -2.2527169  -28.1324863         NaN         NaN   -0.6250211
#> kalomo          -68.2522367  -35.5988707         NaN         NaN    2.3486915
#> kalulushi        10.4549587          NaN         NaN         NaN  -17.1503199
#> kalumbila         4.0521916          NaN         NaN         NaN   -8.3077880
#> kanchibiya              NaN          NaN         NaN         NaN          NaN
#> kaoma           -14.6579113  -69.9432546   2.0184627         NaN   -6.4177169
#> kapiri mposhi    18.8299428    0.2272647 -23.3394168   -6.024444    5.6080467
#> kaputa            5.1361333          NaN         NaN         NaN          NaN
#> kasama           15.8427076   18.4294395  -0.5681387         NaN   -1.6366031
#> kasempa          -4.8856507  -30.0754298         NaN         NaN  -35.4142644
#> katete           12.0434144          NaN  -9.8939183         NaN   -7.3155841
#> kawambwa                NaN          NaN         NaN         NaN   -8.5082664
#> kazungula       -92.3361963  -48.7329077         NaN   -2.062751    2.2672687
#> kitwe            43.3558746   -0.6471504  -8.3762379  -32.852927   99.5513745
#> lavushimanda            NaN    3.3278643         NaN         NaN  -19.7755502
#> limulunga        -8.2113103  -47.4237761         NaN         NaN          NaN
#> livingstone     482.0518825  -28.6267469  -0.7279109         NaN   13.0134381
#> luampa          -29.0254537 -936.4975170         NaN         NaN          NaN
#> luangwa           0.4287940          NaN   1.3864151         NaN  -12.0319784
#> luano                   NaN          NaN         NaN -407.772203  -29.1853122
#> luanshya         20.5646887          NaN  -4.9380595  -18.015507 -403.6864952
#> lufwanyama        6.0777017          NaN         NaN         NaN  -50.8134323
#> lukulu           -6.6946219  -61.0712536         NaN         NaN   -4.0549674
#> lundazi           6.0067814    5.3959939         NaN         NaN          NaN
#> lunga                   NaN          NaN         NaN         NaN  -21.7806150
#> lunte district          NaN          NaN         NaN         NaN   -7.1474610
#> lusaka          132.8651728   13.8366978 -25.6192822 -115.778552   20.1102444
#> luwingu           5.3859372   10.9165325         NaN         NaN   -2.1747196
#> mafinga                 NaN          NaN         NaN         NaN          NaN
#> mambwe                  NaN          NaN         NaN         NaN          NaN
#> mansa            11.6718459    9.0139176         NaN         NaN  -47.4566267
#> manyinga                NaN          NaN         NaN         NaN   -4.0930493
#> masaiti          13.1031334   -0.5104093  -6.5395472  -26.101509   32.7435387
#> mazabuka        100.8739191   -8.6692661 -11.0684776  -12.451091   -0.2322828
#> mbala             6.7391080          NaN         NaN         NaN    3.6504072
#> milengi                 NaN    1.9566913  -2.4390759         NaN  -56.1386450
#> mitete                  NaN          NaN         NaN         NaN          NaN
#> mkushi            0.8619575    3.8230535         NaN  -74.462614  -99.3304945
#> mongu            18.2075709  -73.7679217         NaN         NaN    1.2348203
#> monze            78.1521557  -14.7316420 -10.5677042   -8.946407    2.9161569
#> mpika             2.0724311   16.7076925         NaN         NaN   -1.1049554
#> mpongwe           0.8657808          NaN  -7.0120723         NaN    1.8803204
#> mporokoso               NaN   11.3036675         NaN         NaN    5.4943757
#> mpulungu          5.1826318          NaN         NaN         NaN    2.7293351
#> mufulira         13.1296010          NaN         NaN         NaN  -60.8961157
#> mufumbwe         -8.4624142  -61.1151846         NaN         NaN  -11.1977667
#> mulobezi         51.6391408  -72.6706467         NaN         NaN   -0.8393229
#> mumbwa          -31.6721593  -46.5888657  -6.6976315  -14.369640  -39.5081059
#> mungwi            7.3653487          NaN         NaN         NaN   -2.5872942
#> mwandi          -54.2880106  -35.6596177         NaN         NaN          NaN
#> mwansabombwe            NaN          NaN         NaN         NaN   -9.4372851
#> mwense            4.6177603          NaN         NaN         NaN  -15.7307243
#> mwinilunga       -0.6123998          NaN         NaN         NaN   -9.8402433
#> nakonde          13.9684205          NaN         NaN         NaN    7.8873577
#> nalolo           -7.7207053  -38.0878096         NaN         NaN          NaN
#> namwala         -33.9547889          NaN  -5.0706249         NaN  -11.9723243
#> nchelenge               NaN          NaN         NaN         NaN   -9.3731271
#> ndola            38.3940236   -2.1912409  -7.4001337  -37.387750   71.4152105
#> ngabwe                  NaN          NaN         NaN         NaN   -4.1204879
#> nkeyema         -17.6610551  -92.5434122         NaN         NaN   -9.3378793
#> nsama                   NaN          NaN         NaN         NaN   -2.1423909
#> nyimba            4.5700965          NaN   5.1011735  -65.491400  -28.2860084
#> pemba            32.7422231          NaN         NaN         NaN    2.3803278
#> petauke           2.9151917          NaN -43.9012914  -63.108393  -37.1367410
#> rufunsa           4.2925680          NaN  37.9503573  -21.000756  -14.7104298
#> samfya            4.5687272    6.0101641         NaN         NaN  -54.2048175
#> senanga         -28.9746464  -84.9190710         NaN         NaN          NaN
#> serenje           6.7947762    5.2959762 -22.3676219  -50.176705  -46.6022513
#> sesheke         -29.0143627  -44.7301848         NaN         NaN    0.4441129
#> shang'ombo              NaN          NaN         NaN         NaN          NaN
#> shibuyunji       -7.6310205   -3.2211387         NaN         NaN  -11.5615935
#> shiwamg'andu      5.9086349          NaN         NaN         NaN   -0.6023908
#> siavonga         -3.9828411          NaN         NaN         NaN    1.8329613
#> sikongo                 NaN  -22.2308318         NaN         NaN    4.3231522
#> sinazongwe      -65.0415783  -10.9583042         NaN         NaN    0.7596944
#> sinda                   NaN          NaN -16.9471481         NaN  -11.9481960
#> sioma           -32.4112494  -42.8175307         NaN         NaN          NaN
#> solwezi           5.9814134  -16.2300210         NaN         NaN  -45.9543052
#> vubwi                   NaN          NaN  -2.9555610         NaN   -2.0465127
#> zambezi                 NaN          NaN         NaN         NaN    3.9303076
#> zimba          -127.3897655          NaN         NaN         NaN    1.0124255
#>                  lufwanyama        lukulu       lundazi        lunga
#> chadiza                 NaN           NaN  -29.90178949          NaN
#> chama                   NaN           NaN  -69.89418509          NaN
#> chavuma          -0.7393808  -55.29525755           NaN          NaN
#> chembe          -26.7134525           NaN           NaN  -23.3527287
#> chibombo        -29.7077003   -4.43586517   21.85658567          NaN
#> chiengi                 NaN           NaN           NaN          NaN
#> chikankanta      -0.7884532    0.37343069    4.79731888          NaN
#> chilanga         -5.9098350   16.55601286   25.46360107          NaN
#> chililabombwe   -64.0679172           NaN           NaN   -6.8150368
#> chilubi         -10.8901334           NaN           NaN   50.6196689
#> chingola        -39.0899570           NaN    0.08654052  -14.3522829
#> chinsali                NaN           NaN  -38.05441155  -14.2949094
#> chipata                 NaN           NaN   24.15159414          NaN
#> chipili          -7.8689749           NaN           NaN  -21.4279839
#> chirundu         -4.0271778           NaN           NaN          NaN
#> chisamba         -2.7802636           NaN    3.04435635          NaN
#> chitambo        -15.0439365           NaN           NaN  -30.8293763
#> choma            -4.1015069           NaN    3.22300793          NaN
#> chongwe          -3.5455602           NaN   52.73328519          NaN
#> gwembe                  NaN    1.00701023           NaN          NaN
#> ikelenge        -12.0869712           NaN           NaN          NaN
#> isoka                   NaN           NaN  -36.49551236          NaN
#> itezhi-tezhi    -13.1666480  -18.44945199           NaN          NaN
#> kabompo          -3.6780019  -73.01796202           NaN          NaN
#> kabwe           -19.4930071    1.37584234    0.02024436   -0.8357320
#> kafue            -4.6953254    2.34424504   10.32209674          NaN
#> kalabo           -0.9103360  -92.89965828           NaN          NaN
#> kalomo           -5.9477841   -8.93491280    2.23669490          NaN
#> kalulushi       230.5346781           NaN           NaN          NaN
#> kalumbila       -30.4908304  -27.75410843    1.92300870          NaN
#> kanchibiya              NaN           NaN           NaN          NaN
#> kaoma           -13.5984933 -132.17204310    5.66126847          NaN
#> kapiri mposhi   -38.3724533           NaN    1.94222979          NaN
#> kaputa                  NaN           NaN           NaN          NaN
#> kasama           -8.4139834           NaN  -35.00291984  -67.7291252
#> kasempa         -63.0578871  -24.64860452           NaN          NaN
#> katete           -1.5370202           NaN   -9.86907256          NaN
#> kawambwa         -8.0163077           NaN           NaN          NaN
#> kazungula        -3.2816145  -13.83523986    2.80272386          NaN
#> kitwe           -21.7638515           NaN    2.00294780  -26.6903329
#> lavushimanda            NaN           NaN  -26.25229423          NaN
#> limulunga               NaN  -88.08292756           NaN          NaN
#> livingstone       2.3206079   -6.54520519    6.48954882          NaN
#> luampa                  NaN  -61.00881896    5.78758605          NaN
#> luangwa                 NaN           NaN           NaN          NaN
#> luano                   NaN           NaN           NaN          NaN
#> luanshya        -25.6053087   -0.50047003           NaN  -11.0980032
#> lufwanyama     -848.3940950           NaN           NaN          NaN
#> lukulu                  NaN -749.61647343           NaN          NaN
#> lundazi                 NaN           NaN  491.31081559          NaN
#> lunga                   NaN           NaN           NaN -115.9667610
#> lunte district          NaN           NaN           NaN          NaN
#> lusaka          -50.3991139   25.71152408   94.05501370   -2.1770014
#> luwingu          -5.6021796           NaN           NaN  -52.9994211
#> mafinga                 NaN           NaN  -60.90996082          NaN
#> mambwe                  NaN           NaN  -11.97769571          NaN
#> mansa           -42.9178208    0.08685863   -6.88023148  -73.0898811
#> manyinga        -11.2936840  -70.03597878           NaN          NaN
#> masaiti         -30.6714665           NaN   -0.02574120   -9.7587102
#> mazabuka         -6.4351245    1.46755088    4.38113378          NaN
#> mbala            -1.0259952           NaN  -10.78820384  -14.6096688
#> milengi         -26.9134224           NaN           NaN  -38.6800051
#> mitete                  NaN  -59.51984122           NaN          NaN
#> mkushi          -37.0686070           NaN           NaN  -19.3303294
#> mongu            -2.5105537 -106.46682663           NaN          NaN
#> monze            -9.7538279   -1.75267207    1.60828156          NaN
#> mpika            -6.8404178           NaN -104.23989212   10.3584431
#> mpongwe         -98.8870569           NaN    3.52564488          NaN
#> mporokoso        -1.5238021           NaN           NaN          NaN
#> mpulungu                NaN           NaN           NaN          NaN
#> mufulira        -65.3080084   -0.66233321    5.18445824          NaN
#> mufumbwe        -26.2247065  -69.33851821           NaN          NaN
#> mulobezi                NaN           NaN           NaN          NaN
#> mumbwa          -47.2764780  -19.63404411    7.62548284          NaN
#> mungwi                  NaN           NaN  -29.59205618          NaN
#> mwandi                  NaN           NaN           NaN          NaN
#> mwansabombwe     -9.0738037           NaN           NaN          NaN
#> mwense          -20.1145164           NaN           NaN          NaN
#> mwinilunga      -24.8408777  -56.59717285           NaN   -0.3262493
#> nakonde          -0.3214010    7.71313760  -34.21690644          NaN
#> nalolo                  NaN  -48.10459024           NaN          NaN
#> namwala         -11.3440079           NaN    2.09283169          NaN
#> nchelenge               NaN           NaN           NaN          NaN
#> ndola           -86.0789448    4.55825474    4.83730265  -20.7629038
#> ngabwe          -48.6652695           NaN           NaN          NaN
#> nkeyema                 NaN  -44.12472863           NaN          NaN
#> nsama                   NaN           NaN   -1.67368290          NaN
#> nyimba                  NaN    3.71851793   23.77542120          NaN
#> pemba             1.4534541           NaN           NaN          NaN
#> petauke         -12.4882504           NaN  -41.06521257          NaN
#> rufunsa          -8.4123713           NaN   47.06026466          NaN
#> samfya          -24.5799146           NaN   -8.16223042  102.8783951
#> senanga                 NaN  -53.70650726           NaN          NaN
#> serenje         -18.6229148           NaN           NaN  -27.4974829
#> sesheke                 NaN  -20.21379108           NaN          NaN
#> shang'ombo              NaN           NaN           NaN          NaN
#> shibuyunji              NaN   -0.94462387           NaN          NaN
#> shiwamg'andu            NaN           NaN  -38.90041157          NaN
#> siavonga                NaN    1.39699170    8.63086701          NaN
#> sikongo           1.2417478           NaN           NaN          NaN
#> sinazongwe       -2.9162958           NaN           NaN          NaN
#> sinda                   NaN           NaN   -4.63982451          NaN
#> sioma                   NaN           NaN           NaN          NaN
#> solwezi        -102.6879404  -18.13276567    7.86997198   -7.2079812
#> vubwi                   NaN           NaN  -39.01464180          NaN
#> zambezi           0.5691791 -138.52322813           NaN          NaN
#> zimba             0.3047402           NaN    4.09462442          NaN
#>                lunte district      lusaka      luwingu       mafinga
#> chadiza                   NaN   35.803575          NaN           NaN
#> chama             118.9164944   42.832025  -37.5907040  -178.4826991
#> chavuma                   NaN    2.523217          NaN           NaN
#> chembe            -11.5478721    5.102861    5.9175664           NaN
#> chibombo           10.2714168  679.398238   42.2507109           NaN
#> chiengi                   NaN   17.212617  -53.2597046           NaN
#> chikankanta        10.2691399  -23.846752    8.5448893           NaN
#> chilanga            6.8476428  993.126649   40.0004306           NaN
#> chililabombwe      -3.7910913   29.359573    0.1249159     1.0333504
#> chilubi           -67.7555629    3.094967  173.1176707   -13.1332951
#> chingola           -6.1985433   18.129947   -2.1542221           NaN
#> chinsali          -43.5632162  154.729546   95.0456724   -92.8116872
#> chipata                   NaN  175.089050          NaN   -17.0192987
#> chipili           -34.1683189   80.261710   56.8065164           NaN
#> chirundu                  NaN -117.947457          NaN           NaN
#> chisamba            7.0303592  -94.636185   24.2430182     3.5217908
#> chitambo          -12.4018695    2.970677  -18.0009278    -6.9038389
#> choma                     NaN -113.565026    6.7171530           NaN
#> chongwe                   NaN 1021.659687   21.3125554           NaN
#> gwembe                    NaN -160.512477          NaN           NaN
#> ikelenge                  NaN    1.964788    0.5827210           NaN
#> isoka             -27.1760882   50.083841  -26.0959657  -130.2938269
#> itezhi-tezhi              NaN -115.013234          NaN           NaN
#> kabompo                   NaN   -8.800007          NaN           NaN
#> kabwe              10.1418137  -25.378543   37.9671897    16.9462041
#> kafue              12.2432565  635.484997   15.4827092           NaN
#> kalabo                    NaN   58.445526          NaN           NaN
#> kalomo                    NaN -112.088153          NaN           NaN
#> kalulushi                 NaN    9.599665    6.7573968           NaN
#> kalumbila                 NaN   -7.323591    3.1913218           NaN
#> kanchibiya                NaN  -14.924676          NaN           NaN
#> kaoma               3.4943741   72.143028   20.0563567           NaN
#> kapiri mposhi       8.0524340  -82.994523   30.4955242     1.7106684
#> kaputa            -73.5394297    3.027711  -48.7479812           NaN
#> kasama            -74.5872290  225.416194 -153.5298584   -51.7759569
#> kasempa                   NaN  -86.789883          NaN           NaN
#> katete                    NaN  103.959416          NaN           NaN
#> kawambwa          -92.0161218   44.161688  -72.3677983           NaN
#> kazungula                 NaN  -48.694029          NaN           NaN
#> kitwe             -10.3919408  141.256003   24.6210210     2.0075886
#> lavushimanda      -11.6969345   28.248965  -23.7960997    -8.2273279
#> limulunga                 NaN   -4.884571          NaN           NaN
#> livingstone               NaN   60.949820    5.0607817           NaN
#> luampa                    NaN  -17.539079   10.2461141           NaN
#> luangwa                   NaN  -71.465930          NaN           NaN
#> luano                     NaN -121.203214          NaN           NaN
#> luanshya           -2.5441769   79.451129   11.4875611           NaN
#> lufwanyama                NaN  -39.695576   -1.9481770           NaN
#> lukulu                    NaN   10.439448          NaN           NaN
#> lundazi                   NaN   65.843805          NaN   -82.1508880
#> lunga                     NaN   -5.624076  -49.9958457           NaN
#> lunte district   -882.8858731   13.929087  -99.8870423           NaN
#> lusaka             16.6018004 2752.231522  104.6662241     8.8805489
#> luwingu           -98.6174258   95.014102  415.1684043           NaN
#> mafinga                   NaN    5.976447          NaN -1230.5091371
#> mambwe                    NaN    1.083294          NaN           NaN
#> mansa             -53.2766881  109.715502  105.2909167           NaN
#> manyinga                  NaN   -5.650823          NaN           NaN
#> masaiti                   NaN  100.588984    2.3527804     0.7804055
#> mazabuka           14.0237520 -169.451366   12.6126668           NaN
#> mbala             -97.2556806  103.687340  -36.4204742   -38.4878709
#> milengi           -14.6371745    7.556701  -25.1477958           NaN
#> mitete                    NaN         NaN          NaN           NaN
#> mkushi              0.2483607  -76.295256    7.0794984     4.5404008
#> mongu                     NaN  134.046316   35.0890013           NaN
#> monze                     NaN -189.832865    7.0426141           NaN
#> mpika             -29.9805978  242.428376  -43.8659293   -50.7071854
#> mpongwe                   NaN -102.132388   -2.9432249     2.6603672
#> mporokoso           9.3298230  104.492899   89.1419859    -3.9906947
#> mpulungu         -130.4996918   50.593138  -71.7777968           NaN
#> mufulira                  NaN  414.831171   35.6964238     2.2144224
#> mufumbwe                  NaN  -42.590092          NaN           NaN
#> mulobezi                  NaN  -26.436132          NaN           NaN
#> mumbwa                    NaN -203.291254   12.3292412           NaN
#> mungwi            -94.3472886   33.801857  -69.1673005   -82.0246642
#> mwandi                    NaN   -7.250861          NaN           NaN
#> mwansabombwe              NaN   13.128279  -43.5137998           NaN
#> mwense                    NaN   27.704481  -60.4473994           NaN
#> mwinilunga                NaN   -1.464929          NaN           NaN
#> nakonde           -56.5678048   69.540383  -36.6139520  -160.0828380
#> nalolo                    NaN   13.309827          NaN           NaN
#> namwala                   NaN -187.798197          NaN           NaN
#> nchelenge         -83.5287652   31.507007  -74.3642332           NaN
#> ndola              -8.0157428  181.122726    4.7265488           NaN
#> ngabwe                    NaN -127.754170    1.8937483           NaN
#> nkeyema                   NaN    4.607958    9.3617353           NaN
#> nsama             -75.5814083   12.900225  -42.3722591           NaN
#> nyimba                    NaN   56.484045          NaN           NaN
#> pemba                     NaN  -44.719739          NaN           NaN
#> petauke                   NaN   -3.618925          NaN           NaN
#> rufunsa                   NaN   27.317768          NaN           NaN
#> samfya            -30.5432586   60.031045  441.0280202           NaN
#> senanga                   NaN    8.810630          NaN           NaN
#> serenje            -3.7138912   17.380679    0.3596882    -1.2907752
#> sesheke                   NaN    3.294464          NaN           NaN
#> shang'ombo                NaN   -6.382466          NaN           NaN
#> shibuyunji                NaN -199.407714          NaN           NaN
#> shiwamg'andu              NaN   76.385561  -54.3478674   -41.8898903
#> siavonga                  NaN -148.680895          NaN           NaN
#> sikongo                   NaN   23.537629          NaN           NaN
#> sinazongwe                NaN -104.809757          NaN           NaN
#> sinda                     NaN   66.065227   -5.9242615           NaN
#> sioma                     NaN    3.474240          NaN           NaN
#> solwezi                   NaN  -10.938543   -1.6042817           NaN
#> vubwi                     NaN   10.397111          NaN           NaN
#> zambezi                   NaN    3.635869          NaN           NaN
#> zimba                     NaN  -50.847790          NaN     3.6322892
#>                       mambwe       mansa     manyinga       masaiti
#> chadiza          -84.3055701         NaN          NaN -4.497192e+00
#> chama            -49.6844692 -15.8848368          NaN -5.989789e+00
#> chavuma                  NaN         NaN  -36.2949184  2.280721e-01
#> chembe                   NaN   9.9015643   -0.5783475 -2.056737e+01
#> chibombo          -1.9743982  75.2829632   -0.8148125  1.117288e+02
#> chiengi                  NaN -38.4894048          NaN           NaN
#> chikankanta        0.8349691   3.6642610          NaN  9.946246e+00
#> chilanga           6.6599889  45.3214550    2.5474520  1.785077e+01
#> chililabombwe            NaN -35.9881164    4.5491539 -1.341632e+01
#> chilubi                  NaN -91.1685773          NaN -1.930630e+01
#> chingola          -3.9125590 -48.4872991   17.1903124 -3.513055e+01
#> chinsali                 NaN 156.9105364          NaN  1.680012e+01
#> chipata          -53.3438018  -9.1793474   10.9693637 -1.068700e+01
#> chipili                  NaN  15.6657064    1.0248426  1.166097e+00
#> chirundu                 NaN   0.5298734          NaN  3.409681e+00
#> chisamba                 NaN  40.7984190    1.8607688  5.298976e+01
#> chitambo         -67.7248329  12.0685591          NaN -3.838521e+01
#> choma                    NaN  12.3105865    2.1244848  2.379262e+00
#> chongwe           16.8605095  37.4265321    0.1456539  2.075260e+01
#> gwembe             1.1334562   0.1893449          NaN -2.584572e+00
#> ikelenge                 NaN         NaN  -65.2062967 -4.299680e+00
#> isoka                    NaN  -6.1190556          NaN  9.417472e+00
#> itezhi-tezhi             NaN  -0.7192693          NaN -7.416043e+00
#> kabompo                  NaN   0.3388787   32.6030519 -1.776030e-02
#> kabwe             -5.0341397  74.2545405    9.5508058  8.056631e+01
#> kafue              2.5154805  16.2356525          NaN  1.915300e+01
#> kalabo             6.1644344   3.2174536  -29.0218014  4.966700e+00
#> kalomo                   NaN   0.5317126          NaN  3.907888e+00
#> kalulushi                NaN -14.6748559   13.3496252 -3.216285e+01
#> kalumbila                NaN -16.3681515  -69.8143311  5.586652e-01
#> kanchibiya               NaN         NaN          NaN           NaN
#> kaoma                    NaN  16.7780751  -62.0551860 -4.915278e+00
#> kapiri mposhi     -9.0676915  52.8000192    6.2069077  4.036117e+01
#> kaputa                   NaN -36.8090593          NaN -1.862610e+00
#> kasama           -26.6171131 -30.4229623    2.5205526 -2.477775e+00
#> kasempa                  NaN  -9.5599087    0.5206844 -2.309139e+01
#> katete           -58.5231367  -6.3789547          NaN -7.133052e+00
#> kawambwa                 NaN -45.5618261          NaN -7.669353e+00
#> kazungula          5.5227661         NaN   -2.1096884 -3.592170e-01
#> kitwe            -10.4723972  -9.6130235   18.9298267 -8.822548e+01
#> lavushimanda             NaN -25.2670743          NaN -1.600684e+01
#> limulunga                NaN         NaN          NaN           NaN
#> livingstone              NaN  11.0496671          NaN  8.077774e+00
#> luampa                   NaN   8.1357377          NaN -4.367272e+00
#> luangwa                  NaN         NaN          NaN -1.423641e+01
#> luano                    NaN         NaN          NaN -3.576729e+01
#> luanshya                 NaN  11.8529044    7.0012576  5.852064e+01
#> lufwanyama               NaN -21.5702024    4.0938685 -3.849643e+01
#> lukulu                   NaN  -0.3351236  -54.2231200           NaN
#> lundazi          -91.4589041 -13.1905022          NaN -7.047945e+00
#> lunga                    NaN -61.6289087          NaN -1.704797e+01
#> lunte district           NaN -48.9500913          NaN           NaN
#> lusaka            10.1314681 138.1089250   11.6942513  5.424963e+01
#> luwingu                  NaN 121.7695882          NaN -5.338744e+00
#> mafinga                  NaN         NaN          NaN -1.197524e+00
#> mambwe         -1049.6092332  -8.9633212          NaN -1.205853e+01
#> mansa            -10.2606819 107.4141747    0.9844293 -3.694408e+01
#> manyinga                 NaN  -1.4332730  425.4284508 -3.721186e+00
#> masaiti           -6.5017366  -4.6703842    2.5742004 -1.204418e+03
#> mazabuka           0.2392450  -1.0889092    0.6728107  6.056769e-01
#> mbala                    NaN  -5.4946708    2.5557810  6.010789e-01
#> milengi                  NaN 180.6838243          NaN -3.955795e+01
#> mitete                   NaN         NaN  -27.2593198           NaN
#> mkushi                   NaN  13.3745526          NaN -6.014081e+01
#> mongu                    NaN  37.0665520  -30.0596787  1.935458e+00
#> monze              5.5373339   0.3665743          NaN  2.872132e+00
#> mpika            -47.6956700  -9.9864143    1.8919913  1.253805e+01
#> mpongwe                  NaN -18.3647041          NaN -2.236189e+01
#> mporokoso                NaN -11.7625916          NaN  2.628577e+00
#> mpulungu                 NaN -26.8117402          NaN -1.717990e+00
#> mufulira          -4.4856720  26.6518646   -0.4988708 -5.317149e+01
#> mufumbwe                 NaN  -4.6687169   94.3576453 -7.783499e-01
#> mulobezi                 NaN         NaN          NaN           NaN
#> mumbwa                   NaN   4.8973554  -18.9524792 -3.035244e+01
#> mungwi                   NaN -10.9785722          NaN -3.809961e+00
#> mwandi                   NaN         NaN          NaN           NaN
#> mwansabombwe             NaN -44.8954871          NaN -7.442835e+00
#> mwense                   NaN -72.4958590   -0.8589722 -9.956710e+00
#> mwinilunga               NaN -16.1082747 -150.6726279 -2.632827e+00
#> nakonde          -11.9108136   0.3488687          NaN  1.079671e+01
#> nalolo                   NaN   4.0159594          NaN           NaN
#> namwala                  NaN  -1.2752659          NaN -9.718300e+00
#> nchelenge                NaN -66.9257308          NaN -1.013712e+01
#> ndola            -11.2204686 -36.7440664   12.0174033  3.421166e+01
#> ngabwe                   NaN  -8.2206054          NaN -2.993822e+01
#> nkeyema            4.0534246   6.3238082          NaN -5.918900e+00
#> nsama                    NaN -24.4296544    3.5499439 -1.821301e+00
#> nyimba           -45.1851364 -11.8723957    3.3156928 -3.446493e+01
#> pemba                    NaN         NaN          NaN  2.925841e+00
#> petauke         -199.9905209         NaN    3.2395496 -4.305109e+01
#> rufunsa            4.5211282         NaN          NaN -1.825458e+01
#> samfya           -17.4301398 185.9715400          NaN -3.892352e+01
#> senanga                  NaN         NaN  -13.7286406           NaN
#> serenje          -57.8039919  31.5348111          NaN -4.170879e+01
#> sesheke                  NaN         NaN          NaN -4.224617e-02
#> shang'ombo               NaN         NaN          NaN           NaN
#> shibuyunji         0.1944938   1.5303230          NaN -1.135755e+01
#> shiwamg'andu             NaN -20.6131898          NaN  4.885032e+00
#> siavonga                 NaN         NaN          NaN -7.600242e+00
#> sikongo                  NaN         NaN          NaN           NaN
#> sinazongwe               NaN   5.9077447          NaN -1.650193e+00
#> sinda           -102.2598590         NaN          NaN -1.265503e+01
#> sioma                    NaN   3.1983623          NaN           NaN
#> solwezi                  NaN -38.7208442   38.4219011 -1.818819e+01
#> vubwi            -53.6921714         NaN          NaN -1.807666e+00
#> zambezi                  NaN         NaN  -78.3753134  7.691831e+00
#> zimba                    NaN         NaN          NaN  2.774047e+00
#>                     mazabuka       mbala     milengi     mitete        mkushi
#> chadiza           0.64829050         NaN         NaN        NaN           NaN
#> chama            12.18307647 -42.1838603 -11.4272393        NaN -5.936282e+00
#> chavuma                  NaN         NaN         NaN  -86.18688           NaN
#> chembe                   NaN  12.5453277 -12.7651996        NaN -2.430932e+01
#> chibombo        -74.28176459  52.2637212   6.4795775        NaN  6.016939e+01
#> chiengi           4.87555165 -53.1812532 -15.9768742        NaN -7.285815e-01
#> chikankanta     461.55685536   5.8337724         NaN        NaN  6.818134e+00
#> chilanga         17.46041057  22.2127044   9.8229604        NaN  9.287044e+00
#> chililabombwe     6.51673856   3.2534496 -28.7864288        NaN -2.302116e+01
#> chilubi           3.34828386 -22.4034004 -56.2168460        NaN -2.209115e+01
#> chingola         -6.21056883  11.0429984 -45.4586169        NaN -3.680420e+01
#> chinsali          2.67577603 -70.1053004   0.1964251        NaN  5.705909e+01
#> chipata           5.60851205  -4.4919852  -9.2472144        NaN -3.367038e+01
#> chipili                  NaN   1.1442839 -22.9108524        NaN  7.944298e+00
#> chirundu        -46.46148355   5.6302089         NaN        NaN -1.323370e+01
#> chisamba        -18.66261883  17.5348218   2.2257377        NaN  1.853733e+01
#> chitambo         -0.74595990  10.0129441 -31.0550250        NaN -5.843458e+01
#> choma           -21.68479635  11.0389576  -0.5634823        NaN -3.649960e+00
#> chongwe         -35.91069378  25.6846248   4.6874469        NaN -1.552869e+01
#> gwembe          -19.57321603         NaN         NaN        NaN -4.897173e+00
#> ikelenge                 NaN         NaN         NaN        NaN -9.311111e-01
#> isoka             6.84398630 -54.9726958         NaN        NaN  3.075243e+01
#> itezhi-tezhi    -69.58821368   2.9298420         NaN        NaN -7.651253e+00
#> kabompo          -5.52512635         NaN   1.3407639  -48.22430           NaN
#> kabwe           -18.83277886  58.1794001   3.1349064        NaN  8.340848e+01
#> kafue           205.12840186  21.8123105   0.2078239        NaN  8.978302e+00
#> kalabo            6.62985355         NaN         NaN        NaN           NaN
#> kalomo          -48.88066944  13.3400069   0.6262210        NaN -9.380359e-01
#> kalulushi        -5.68238133  11.5914055 -27.4418117        NaN -2.560856e+01
#> kalumbila        -7.29628212         NaN         NaN        NaN           NaN
#> kanchibiya               NaN -27.1557534         NaN        NaN           NaN
#> kaoma            -8.36071406  29.8263232   5.3184585  -44.76027  7.899170e+00
#> kapiri mposhi   -18.74225081  51.0817834  -8.3745573        NaN  2.964267e+01
#> kaputa                   NaN -58.1143334 -10.2692382        NaN -2.763658e+00
#> kasama           58.40224375 -14.5068111 -41.1563814        NaN  5.322185e+01
#> kasempa         -33.12707510         NaN         NaN        NaN           NaN
#> katete            1.47131712   3.2938275         NaN        NaN -3.177224e+01
#> kawambwa                 NaN -29.7841194 -27.9507765        NaN  2.844708e-01
#> kazungula       -22.38480438   5.2045625         NaN        NaN           NaN
#> kitwe             1.58757310  35.6499935 -89.3470876        NaN -9.247675e+01
#> lavushimanda      4.93193241   7.5394561 -27.3188251        NaN -1.621677e+01
#> limulunga                NaN         NaN         NaN        NaN           NaN
#> livingstone      38.68756465   6.7502811         NaN        NaN -1.096232e+00
#> luampa          -23.92778114         NaN   0.9914743        NaN  1.479000e+00
#> luangwa         -22.35483626         NaN  -3.2970267        NaN           NaN
#> luano           -18.67542481         NaN         NaN        NaN -6.308134e+01
#> luanshya          1.02865571   9.3990552 -31.9101498        NaN -4.759854e+01
#> lufwanyama       -9.47091255   0.5397027 -21.1479174        NaN -2.658427e+01
#> lukulu           -5.18052440         NaN         NaN  -54.29815           NaN
#> lundazi           1.35035743 -16.7147241         NaN        NaN           NaN
#> lunga                    NaN  -9.9420775 -45.4766467        NaN -2.144494e+01
#> lunte district   12.03751037 -71.5846044 -18.3532028        NaN -1.150363e+00
#> lusaka         -359.35742438 115.0051567  11.7977792        NaN -4.096947e+01
#> luwingu          10.08055547 -15.8554900 -33.3502754        NaN  3.822359e+00
#> mafinga                  NaN -42.6884561         NaN        NaN  1.559819e+00
#> mambwe           -1.91382252         NaN         NaN        NaN           NaN
#> mansa            -4.67505084   0.9895376 109.1567306        NaN -1.205869e+00
#> manyinga         -5.71912565   2.3827904         NaN  -31.57586           NaN
#> masaiti          -1.29250382   3.9156150 -25.9633246        NaN -1.568758e+00
#> mazabuka        798.46271301   9.5376317         NaN        NaN  6.857850e+00
#> mbala             7.81711360 803.4697693  -8.4180005        NaN  4.397827e+01
#> milengi                  NaN  -3.8743914 116.9968176        NaN -2.754058e+01
#> mitete                   NaN         NaN         NaN -717.46957           NaN
#> mkushi           -8.79291628  50.5884134 -29.9864553        NaN -1.139555e+03
#> mongu            -0.92534380         NaN   9.3616432  -60.46286  2.285188e+01
#> monze           155.28418352  19.2062359  -0.2181929        NaN -2.965375e+00
#> mpika            48.66237620  35.9642492 -27.5006788        NaN  9.565042e+01
#> mpongwe         -23.40578287   5.5275554 -19.7184890        NaN -3.776872e+01
#> mporokoso        38.45030074  20.9277859 -11.4082683        NaN  2.985998e+01
#> mpulungu         15.13855868 219.4580657         NaN        NaN  1.307400e+01
#> mufulira          0.17286856  23.4558489 -40.9411474        NaN -4.473841e+01
#> mufumbwe                 NaN         NaN         NaN  -19.60988           NaN
#> mulobezi        -16.42778781         NaN         NaN        NaN           NaN
#> mumbwa         -118.93986259         NaN  -4.0924720        NaN -2.169828e+01
#> mungwi            3.23769517   8.8301877         NaN        NaN  1.374707e+01
#> mwandi           -5.03538911         NaN         NaN        NaN           NaN
#> mwansabombwe      2.44388921 -15.6923533 -22.7224915        NaN -1.512217e-02
#> mwense            0.34735459 -13.4155295 -48.3782710        NaN -3.969947e+00
#> mwinilunga       -8.67452577         NaN         NaN        NaN -4.770594e+00
#> nakonde           7.71365099  33.9771246  -6.6117223        NaN  3.410662e+01
#> nalolo            2.12766103         NaN         NaN        NaN           NaN
#> namwala         -71.91937153   5.6508189         NaN        NaN -8.767340e+00
#> nchelenge                NaN -44.6381079 -30.0098053        NaN -7.415091e-01
#> ndola             0.75780994  47.6651504 -74.7897743        NaN -9.272444e+01
#> ngabwe          -31.94547185         NaN  -8.3243699        NaN -2.674673e+01
#> nkeyema         -18.59077857   5.7632642   0.1117648        NaN -3.149340e-01
#> nsama                    NaN -72.8190681  -7.5370867        NaN  7.668885e-01
#> nyimba           -5.94506140         NaN         NaN        NaN -1.064754e+02
#> pemba            16.47375639   5.2136341   0.9161778        NaN -1.972463e-01
#> petauke         -10.83481237         NaN         NaN        NaN -1.198858e+02
#> rufunsa         -18.37013343   4.0059407         NaN        NaN -4.742214e+01
#> samfya            4.04515263  -8.0748778 231.6965991        NaN -6.119743e+00
#> senanga          -8.98191181         NaN   3.5903722        NaN           NaN
#> serenje           8.10746314  23.8740310 -23.0431934        NaN  7.528509e+01
#> sesheke          -3.23126039   7.4678589         NaN        NaN           NaN
#> shang'ombo               NaN         NaN         NaN        NaN           NaN
#> shibuyunji      -13.66953941         NaN         NaN        NaN -1.249375e+01
#> shiwamg'andu             NaN -35.3174660         NaN        NaN  2.989837e+01
#> siavonga        -67.60598933         NaN         NaN        NaN -1.012888e+01
#> sikongo          11.77512717         NaN         NaN        NaN  1.601798e+00
#> sinazongwe      -39.61593059         NaN         NaN        NaN -4.049351e+00
#> sinda            -3.00097954   0.8981319         NaN        NaN           NaN
#> sioma            -0.04306747         NaN         NaN        NaN           NaN
#> solwezi         -16.53177563   8.5282322 -27.6784641        NaN -2.408894e+01
#> vubwi                    NaN         NaN         NaN        NaN           NaN
#> zambezi          -0.86952077         NaN         NaN -145.16584           NaN
#> zimba           -20.49010232  12.4443732         NaN        NaN -3.597845e+00
#>                       mongu         monze        mpika       mpongwe
#> chadiza           4.7942471  2.189496e+00          NaN           NaN
#> chama                   NaN           NaN -170.9955451    -2.1865110
#> chavuma                 NaN           NaN    5.9882973           NaN
#> chembe                  NaN  9.820044e-01   -9.3134688   -21.8696145
#> chibombo         31.0573165 -5.662099e+01  183.1701661   -64.1852979
#> chiengi                 NaN           NaN          NaN           NaN
#> chikankanta       8.6038602  1.804119e+02   42.7880925    -5.8556228
#> chilanga        118.9210182 -9.609074e-01   79.1641540   -18.2251869
#> chililabombwe    11.8402088  8.869495e+00    7.7036929   -54.3300230
#> chilubi                 NaN           NaN   77.1890537           NaN
#> chingola          4.2762855  1.575097e+00    6.2177642  -101.4389562
#> chinsali                NaN  1.879563e+00   51.8180535     1.7457251
#> chipata           9.7216499  9.733137e+00  -55.3239704    -4.2768399
#> chipili          28.4289006           NaN   14.7235450    -6.2265445
#> chirundu          1.9391717 -3.772032e+01    6.2363013    -8.3486351
#> chisamba         19.4585945 -1.774022e+01   96.3529898   -13.8402456
#> chitambo         16.9197868 -4.429687e+00   72.6840299   -19.1889183
#> choma            -2.9731422  1.743953e+00    6.1333736   -13.0847863
#> chongwe          37.5384380 -2.085255e+01   52.5952825   -15.2444504
#> gwembe            1.0904972  5.183482e+02    2.1113088    -6.2700210
#> ikelenge                NaN           NaN          NaN           NaN
#> isoka                   NaN  2.364058e+00   10.8083174     2.1426683
#> itezhi-tezhi    -31.0097408 -8.474008e+01    7.2564732   -20.5446056
#> kabompo         -56.7980814 -6.291919e+00          NaN           NaN
#> kabwe            37.6383930 -1.359892e+01  192.7874715   -32.0343922
#> kafue            33.2710452  9.128646e+01   70.0794279    -6.3455745
#> kalabo          450.6041381 -3.263442e+00    3.1686733           NaN
#> kalomo          -18.8264948 -1.129732e+02    4.1836188   -12.7190726
#> kalulushi        -0.2832191 -2.295228e+00    9.3755489   -70.7957085
#> kalumbila       -14.6652724 -8.639855e+00          NaN   -38.6841321
#> kanchibiya              NaN           NaN -108.7730874           NaN
#> kaoma           -63.4448403 -1.784507e+01   34.8555156   -16.2175648
#> kapiri mposhi    27.0906173 -1.042785e+01  207.7979646    30.2257097
#> kaputa                  NaN           NaN   -3.9506072           NaN
#> kasama           62.5435056  6.823627e+00  131.8991945    -4.4345048
#> kasempa          -5.6810771 -3.060806e+01    3.6469487   -84.5533769
#> katete           11.0867692  1.591756e+00  -46.4609846           NaN
#> kawambwa          4.9533735  3.616587e+00  -11.4416345           NaN
#> kazungula       -28.8254857 -5.410807e+01    3.3730786    -7.8688402
#> kitwe            14.5171615  8.597471e+00   32.5555781  -141.0369121
#> lavushimanda     12.9939716 -1.300235e+00  -31.5933091    -7.7519145
#> limulunga      -107.6100172           NaN          NaN           NaN
#> livingstone      19.2596728  8.598644e+00    2.1443443    -3.8594943
#> luampa          -71.5258357 -3.095941e+01   16.9135779           NaN
#> luangwa                 NaN -1.708681e+01          NaN   -10.8771347
#> luano                   NaN -1.131586e+01          NaN           NaN
#> luanshya          5.7821628  7.719362e+00   22.6439698    47.8449073
#> lufwanyama        1.4550546 -9.629992e+00   -1.9735440   -94.8201051
#> lukulu         -103.7277769 -7.753563e+00          NaN           NaN
#> lundazi                 NaN  1.677679e-04 -158.6154937    -0.6022773
#> lunga                   NaN           NaN   38.3813309           NaN
#> lunte district          NaN           NaN  -18.2273542           NaN
#> lusaka          172.7345018 -2.448578e+02  294.1637469  -118.1145479
#> luwingu          36.5801879  5.897727e+00  -20.7645878    -5.8360303
#> mafinga                 NaN           NaN  -52.2278789     1.3510227
#> mambwe                  NaN  3.723015e+00    5.1149336           NaN
#> mansa            38.8301458 -2.001009e+00    3.7623608   -34.8556868
#> manyinga        -36.8817926           NaN    1.7384356           NaN
#> masaiti           4.8312344  5.786265e+00   37.0948325    -4.5306988
#> mazabuka         11.3078224  2.247293e+02   62.0534517   -15.9317689
#> mbala                   NaN  1.713431e+01   39.5802985     3.3335078
#> milengi          10.8830641 -1.102002e+00  -11.1779262   -24.4935465
#> mitete          -64.1909362           NaN          NaN           NaN
#> mkushi           26.2615762 -9.117097e+00  133.8991898   -54.1070451
#> mongu           489.3261439 -1.191783e+01   56.3797522           NaN
#> monze            -1.7425273  5.205143e+02   14.0863037   -16.5639005
#> mpika            56.0874569  9.936699e+00  288.3569656     2.1098167
#> mpongwe                 NaN -1.735422e+01   11.6027124 -1091.9679461
#> mporokoso        21.9625685  9.209114e+00   44.5210143    -0.5499445
#> mpulungu          4.9424495  1.327636e+01    3.3904186    -0.7245231
#> mufulira                NaN -1.258310e-01    3.1195336   -64.2425344
#> mufumbwe        -43.7337349           NaN          NaN   -38.1503386
#> mulobezi        -49.9530401           NaN          NaN           NaN
#> mumbwa           28.1525100 -1.271650e+02   21.9691914   -79.4303175
#> mungwi            6.3422766  5.362381e+00  -37.2135177           NaN
#> mwandi          -19.9416281 -1.526115e+01          NaN           NaN
#> mwansabombwe            NaN           NaN   -6.3791583           NaN
#> mwense                  NaN           NaN  -13.1414486   -13.5383151
#> mwinilunga      -27.3018797           NaN    1.2438857   -30.9454958
#> nakonde           3.6982827  7.010696e+00    0.1410075     6.4038413
#> nalolo           30.6107456 -5.388510e+00          NaN           NaN
#> namwala                 NaN  3.991216e+01    3.7096063   -22.5147944
#> nchelenge               NaN           NaN   -8.2404795    -7.1986366
#> ndola            16.3346020  7.204708e+00   38.7902455   -98.3805830
#> ngabwe                  NaN -2.317236e+01          NaN   -72.2250393
#> nkeyema         -11.7479901           NaN   16.6548116   -18.6097779
#> nsama                   NaN           NaN   -0.8111143           NaN
#> nyimba            5.2293631 -8.552713e+00  -24.8835630   -18.3325387
#> pemba            -2.4905241  2.549855e+02    1.8437704    -3.7092346
#> petauke           6.6629175 -9.157248e+00  -90.9753882           NaN
#> rufunsa           3.7105619 -1.736954e+01   13.3773812   -16.6305528
#> samfya           26.1863650  1.628018e+00  -16.0204692   -23.3483252
#> senanga        -112.6659098 -1.491030e+01          NaN           NaN
#> serenje          23.7425537  1.259666e+00   64.3664752   -20.1370711
#> sesheke         -29.2958748 -1.052003e+01    8.9010577           NaN
#> shang'ombo      -60.3735787           NaN          NaN           NaN
#> shibuyunji       18.9631870 -6.053261e+01    5.0414715   -20.7870670
#> shiwamg'andu            NaN           NaN   42.7184729     0.4082795
#> siavonga                NaN -6.771918e+01    7.9946602           NaN
#> sikongo         -57.6173918 -1.174215e+00          NaN           NaN
#> sinazongwe       -4.5172731 -7.971157e+01    1.4934463    -4.3059984
#> sinda                   NaN -3.485214e+00  -40.1240866    -6.4059054
#> sioma           103.4953856 -8.961565e+00          NaN           NaN
#> solwezi          -4.7204541 -1.209120e+01    5.8956948  -113.0951532
#> vubwi                   NaN           NaN          NaN           NaN
#> zambezi         -88.9735344 -4.703373e+00    5.1520245           NaN
#> zimba                   NaN -5.565837e+01          NaN    -1.1367722
#>                   mporokoso      mpulungu     mufulira     mufumbwe    mulobezi
#> chadiza                 NaN           NaN   -2.6936447          NaN         NaN
#> chama           219.5217928  -25.13960027   -6.5464738    3.5229824         NaN
#> chavuma                 NaN           NaN   -0.9903729   -8.8543002         NaN
#> chembe            9.3684740    0.63569759  -20.0262642   -1.4981593         NaN
#> chibombo         53.5929465   20.54650291   24.4436624   -4.1247534         NaN
#> chiengi        -107.2242512  -95.58228922   -7.9260745          NaN         NaN
#> chikankanta      30.6607401   13.22773789    6.2297499          NaN         NaN
#> chilanga         35.5620766   17.04707641   48.4047367   -2.1480787   -1.288516
#> chililabombwe     2.3554132    3.40757463 -109.8895769   -2.8978986    1.563429
#> chilubi         -27.3055794  -37.00371909  -29.9611980          NaN         NaN
#> chingola          1.1783979   -0.63160520 -127.8714100   16.4695008         NaN
#> chinsali        -14.7905221  -51.25738460   10.0873440          NaN         NaN
#> chipata                 NaN           NaN   -4.2061858          NaN         NaN
#> chipili         -10.9389886  -17.97306586    5.3167627          NaN         NaN
#> chirundu                NaN    2.77457382    8.6250254          NaN         NaN
#> chisamba         32.4928386   12.89214061    6.4851194    6.2784725         NaN
#> chitambo          3.0407341   -2.17422188  -40.0546328          NaN         NaN
#> choma                   NaN           NaN   -1.1433285   -9.5303666  -21.493855
#> chongwe          19.3436237   17.64521887   77.0032200   -2.7952413    4.729232
#> gwembe                  NaN    5.82613870   -2.1494681          NaN         NaN
#> ikelenge                NaN           NaN  -11.4376488  -27.7918017         NaN
#> isoka            -9.2490286  -38.65731164    0.3582116          NaN         NaN
#> itezhi-tezhi            NaN    2.69397387   -4.6373387  -32.4969741  -44.889268
#> kabompo                 NaN           NaN   -3.1212136  -37.2453694         NaN
#> kabwe            56.6952376   25.07563362   -2.4977288    8.5591970   -2.188575
#> kafue            38.7331360   16.93346435   34.7598371   -1.1455230         NaN
#> kalabo            6.1133461           NaN          NaN          NaN  -18.687247
#> kalomo                  NaN           NaN   -0.7114984  -13.3027385  -37.657174
#> kalulushi         5.3998090    3.78234004   31.3922113    7.6101222         NaN
#> kalumbila               NaN    1.23056875  -27.1835755  -45.0066818         NaN
#> kanchibiya              NaN           NaN          NaN          NaN         NaN
#> kaoma           173.0305031   17.74396458   -2.1358572  -88.8102709  -42.653481
#> kapiri mposhi    49.8696896   29.13012155  -34.2524180    4.3733584         NaN
#> kaputa          -96.5035516 -103.49338223   -6.9047122          NaN         NaN
#> kasama          217.3116909  -84.45228683   14.8582230          NaN         NaN
#> kasempa                 NaN           NaN  -43.8652756   45.1893798  -10.061305
#> katete                  NaN           NaN   -5.7045217          NaN         NaN
#> kawambwa         87.8023638  -67.49493656  -10.8318481          NaN         NaN
#> kazungula               NaN    6.27322386   -1.7143209          NaN  -58.775966
#> kitwe            26.5704425    8.56721587 -126.1252140   29.2053725         NaN
#> lavushimanda      4.6065329   -0.92647379  -20.6961344          NaN         NaN
#> limulunga               NaN           NaN          NaN  -25.6025237  -24.523481
#> livingstone             NaN    5.14862066    8.2390953   -7.0415470   52.828890
#> luampa           10.7702667           NaN          NaN  -54.3168126  -72.415405
#> luangwa                 NaN           NaN          NaN          NaN         NaN
#> luano                   NaN           NaN          NaN          NaN         NaN
#> luanshya         11.7724495    9.25703240  -51.6885985    8.9750315    2.139081
#> lufwanyama        0.1914656           NaN  -85.0385642   -0.8673600         NaN
#> lukulu                  NaN           NaN   -4.1186403  -61.2252453         NaN
#> lundazi                 NaN           NaN   -3.5471864          NaN         NaN
#> lunga                   NaN           NaN          NaN          NaN         NaN
#> lunte district    8.0865364 -102.07678164          NaN          NaN         NaN
#> lusaka          110.9609097   57.81630734  352.4641554   -3.8853387   -9.298367
#> luwingu          89.1832598  -54.10424692   14.2263675          NaN         NaN
#> mafinga          -7.4480861           NaN   -0.8242138          NaN         NaN
#> mambwe                  NaN           NaN   -9.4545090          NaN         NaN
#> mansa           -17.2242153  -21.39502553  -65.6721372   -2.3101897         NaN
#> manyinga                NaN           NaN  -10.2961490   79.0468238         NaN
#> masaiti           5.9419222    1.49355289  -61.1964484   14.5362348         NaN
#> mazabuka         42.2955956   17.80515464    0.1120926          NaN   -4.488577
#> mbala            -3.4746526  197.17260830   13.7104641          NaN         NaN
#> milengi          -8.6390115           NaN  -72.1663792          NaN         NaN
#> mitete                  NaN           NaN          NaN  -18.8783593         NaN
#> mkushi           31.8019051   16.77635257  -75.6085918          NaN         NaN
#> mongu            21.1113724    4.87906823          NaN  -39.3409717  -51.129388
#> monze            10.0963559   14.97609019   -2.6128833          NaN         NaN
#> mpika            33.3149669   -1.08210471  -15.0764473          NaN         NaN
#> mpongwe           0.7963597    1.00289176  -84.7166834  -16.6831488         NaN
#> mporokoso      1072.2874872  144.38555088   14.5783722          NaN         NaN
#> mpulungu        105.9055630  -42.94060324   -0.5965063    4.1868644         NaN
#> mufulira         24.6159742    7.16703641 -222.3727028   -1.3413054         NaN
#> mufumbwe                NaN    3.93698898  -18.3052581 -383.1266357         NaN
#> mulobezi                NaN           NaN          NaN          NaN -352.780724
#> mumbwa           12.0292852           NaN  -30.6814424  -65.7864743  -29.683515
#> mungwi           94.2020568 -109.71290894   -0.3845045          NaN         NaN
#> mwandi                  NaN           NaN          NaN          NaN  -34.969837
#> mwansabombwe    -48.4128646           NaN  -11.9819673          NaN         NaN
#> mwense          -43.2102877  -27.83741133  -31.4009210          NaN         NaN
#> mwinilunga              NaN    0.01483472  -26.1730982  -82.5617821         NaN
#> nakonde         -10.8260367  -83.70214159    5.4214052          NaN         NaN
#> nalolo                  NaN           NaN          NaN          NaN  -19.422095
#> namwala                 NaN    5.33189408   -4.4438251          NaN         NaN
#> nchelenge      -120.3235239  -79.10373049  -14.6755654          NaN         NaN
#> ndola            15.5538389    3.29665127 -198.7998411   18.1269800         NaN
#> ngabwe                  NaN           NaN  -36.6092212          NaN         NaN
#> nkeyema           8.1138471           NaN          NaN  -71.7504095  -33.462087
#> nsama            -6.2148912 -117.04518843          NaN          NaN         NaN
#> nyimba                  NaN           NaN  -19.3635040          NaN         NaN
#> pemba                   NaN           NaN    0.3273206          NaN   -3.702659
#> petauke                 NaN           NaN  -26.0684866    0.4106067         NaN
#> rufunsa                 NaN           NaN   -5.5107884          NaN         NaN
#> samfya          -13.7260209  -14.84663738  -60.6458099          NaN         NaN
#> senanga                 NaN           NaN          NaN  -23.5097593   68.270534
#> serenje          22.7927586   10.03047452  -43.5368070   -1.0753643         NaN
#> sesheke                 NaN           NaN          NaN   -8.6827535  -49.154978
#> shang'ombo              NaN           NaN          NaN          NaN  -25.818978
#> shibuyunji              NaN           NaN   -5.3654259          NaN         NaN
#> shiwamg'andu    -13.5753814  -32.10532282   -7.3557055          NaN         NaN
#> siavonga                NaN           NaN   12.8492242          NaN         NaN
#> sikongo                 NaN           NaN          NaN          NaN  -15.380544
#> sinazongwe              NaN           NaN   -2.1006662          NaN         NaN
#> sinda                   NaN           NaN   -7.6817397          NaN         NaN
#> sioma                   NaN           NaN    0.3104651          NaN   16.976274
#> solwezi          -0.5221395    1.70047709  -98.0604120   32.8258626   -4.353605
#> vubwi             2.1635245           NaN          NaN          NaN         NaN
#> zambezi           3.7465551           NaN   -2.8663561  -24.2856498         NaN
#> zimba                   NaN           NaN    2.6708832          NaN  -20.713289
#>                       mumbwa        mungwi        mwandi mwansabombwe
#> chadiza         1.743513e+00           NaN           NaN          NaN
#> chama                    NaN  -128.0386707           NaN          NaN
#> chavuma                  NaN           NaN           NaN          NaN
#> chembe         -5.433771e+00     1.6803607           NaN   -8.5284764
#> chibombo       -1.012729e+02    22.1208760   -3.58733485   10.7121467
#> chiengi         1.385289e+00           NaN           NaN  -91.5992198
#> chikankanta    -1.328472e+01     2.4499396    8.75055502          NaN
#> chilanga        7.818752e+01     4.0015594    4.00855508          NaN
#> chililabombwe  -1.172974e+01     0.9051412    2.65745320   -8.6571436
#> chilubi        -1.987953e-01   -54.9365998           NaN  -34.3952836
#> chingola       -2.874660e+01     3.7112177           NaN  -11.6434432
#> chinsali                 NaN  -101.5252927           NaN   -8.3706431
#> chipata         5.832028e+00   -13.2924124           NaN          NaN
#> chipili         9.472571e+00    -0.9966692           NaN  -59.7307361
#> chirundu       -1.141062e+01           NaN           NaN          NaN
#> chisamba       -1.497000e+01     6.0277630           NaN    4.6807341
#> chitambo       -1.917413e+00   -12.5585164           NaN   -5.2918978
#> choma          -7.780362e+01           NaN  -12.70887680          NaN
#> chongwe         5.988098e+00    10.7014475           NaN    6.7921124
#> gwembe         -2.855966e+01           NaN   -1.67631273          NaN
#> ikelenge                 NaN           NaN           NaN          NaN
#> isoka                    NaN  -141.2766262           NaN          NaN
#> itezhi-tezhi   -1.329046e+02           NaN           NaN          NaN
#> kabompo        -2.833156e+01           NaN           NaN          NaN
#> kabwe          -3.397589e+01    26.3562963   -0.01685537   11.0477337
#> kafue           4.965666e+00     3.2052254   11.27901861    4.7954065
#> kalabo         -2.147367e-01           NaN  -11.84668265          NaN
#> kalomo         -8.581219e+01     6.2640604  -36.07833868          NaN
#> kalulushi      -1.798721e+01     3.4620775           NaN   -4.8448501
#> kalumbila      -3.938773e+01           NaN           NaN          NaN
#> kanchibiya               NaN           NaN           NaN          NaN
#> kaoma          -3.635657e+01    87.6739285  -18.67372137          NaN
#> kapiri mposhi  -3.919494e+01    33.2552400           NaN    6.8402544
#> kaputa                   NaN   -40.5072065           NaN  -60.5356439
#> kasama          2.213137e+01   -88.5011815           NaN  -46.2578071
#> kasempa        -1.162096e+02           NaN           NaN          NaN
#> katete          1.048852e+00           NaN           NaN          NaN
#> kawambwa        5.646776e+00   -38.0089841           NaN  -84.8343547
#> kazungula      -6.232940e+01           NaN  -47.63952725          NaN
#> kitwe          -3.403874e+01     7.3834520           NaN   -1.0782544
#> lavushimanda    1.041079e+00   -14.1385002           NaN          NaN
#> limulunga      -1.678138e+01           NaN  -13.43532737          NaN
#> livingstone    -4.258082e+01     7.1901507  -44.53628877          NaN
#> luampa         -6.782130e+01           NaN  -32.57815568          NaN
#> luangwa        -6.290282e+00           NaN           NaN          NaN
#> luano          -1.059755e+01           NaN           NaN          NaN
#> luanshya       -1.625831e+01     2.9297013           NaN   -0.4656106
#> lufwanyama     -2.912303e+01           NaN           NaN   -5.2790589
#> lukulu         -2.878701e+01           NaN           NaN          NaN
#> lundazi         5.775088e+00   -51.1025864           NaN          NaN
#> lunga                    NaN           NaN           NaN          NaN
#> lunte district           NaN   -83.5351814           NaN          NaN
#> lusaka         -9.640848e+01    39.3708396   12.07436025   16.3426676
#> luwingu         1.241396e+01   -57.9219316           NaN  -41.7813496
#> mafinga                  NaN  -107.2460934           NaN          NaN
#> mambwe                   NaN           NaN           NaN          NaN
#> mansa           3.752044e+00    -9.6759315           NaN  -51.8607841
#> manyinga       -3.214997e+01           NaN           NaN          NaN
#> masaiti        -1.226796e+01    -0.4394210           NaN   -3.4868527
#> mazabuka       -5.229435e+01     4.3970680   10.01301297    3.6571881
#> mbala                    NaN   -38.8994317           NaN  -21.2808461
#> milengi        -2.232492e+00           NaN           NaN  -16.6269773
#> mitete                   NaN           NaN           NaN          NaN
#> mkushi         -1.708198e+01    17.5229592           NaN    1.9666090
#> mongu           1.202460e+01     6.1567013  -16.52218647          NaN
#> monze          -7.896382e+01     6.2978354    1.27639941          NaN
#> mpika           1.921711e+01   -58.5499460           NaN  -10.0880613
#> mpongwe        -5.140517e+01           NaN           NaN          NaN
#> mporokoso       1.207489e+01   105.9991656           NaN  -46.5940228
#> mpulungu                 NaN  -126.6454834           NaN          NaN
#> mufulira       -1.380889e+01     7.3166715           NaN    3.1810603
#> mufumbwe       -9.869165e+01           NaN           NaN          NaN
#> mulobezi       -3.977367e+01           NaN  -29.05290208          NaN
#> mumbwa         -1.477523e+03           NaN  -15.63899899          NaN
#> mungwi                   NaN -1137.5599069           NaN  -18.4254917
#> mwandi         -2.351628e+01           NaN -610.16489303          NaN
#> mwansabombwe             NaN   -16.6666142           NaN -995.5471392
#> mwense          3.249620e-01   -18.5690683           NaN  -37.5174038
#> mwinilunga     -3.746349e+01           NaN           NaN   -6.4502856
#> nakonde         1.815893e+00  -255.5697053           NaN   -9.9966285
#> nalolo         -9.921098e+00           NaN  -17.98151531          NaN
#> namwala        -3.438077e+01           NaN  -13.72803579    5.3775793
#> nchelenge                NaN   -37.4471097           NaN -177.5832515
#> ndola          -2.616607e+01     4.6765426           NaN  -10.1294739
#> ngabwe         -2.979499e+01           NaN           NaN          NaN
#> nkeyema        -7.320698e+01           NaN           NaN          NaN
#> nsama                    NaN   -48.5411005           NaN  -34.7059181
#> nyimba         -7.805286e+00    -1.3839339           NaN          NaN
#> pemba          -2.649574e+01           NaN   -0.27301669          NaN
#> petauke        -7.536800e+00           NaN    1.77963995   -3.6425851
#> rufunsa        -3.678560e+00           NaN           NaN          NaN
#> samfya          1.674482e+00   -22.8602283           NaN  -22.3402195
#> senanga        -2.550672e+01           NaN  -43.73923473          NaN
#> serenje         1.446846e-02     5.2251305           NaN    0.5680770
#> sesheke        -2.112757e+01           NaN  -19.99337299          NaN
#> shang'ombo               NaN           NaN           NaN          NaN
#> shibuyunji     -3.530178e+01           NaN           NaN          NaN
#> shiwamg'andu             NaN   -95.0388734           NaN          NaN
#> siavonga       -1.644280e+01           NaN           NaN          NaN
#> sikongo        -6.964014e+00           NaN  -10.05746293          NaN
#> sinazongwe     -3.441567e+01           NaN  -14.69607124          NaN
#> sinda          -4.051665e-01           NaN           NaN          NaN
#> sioma          -1.488146e+01           NaN  -53.69431656          NaN
#> solwezi        -6.775109e+01     0.7693382    2.51604394  -13.3010553
#> vubwi           3.113542e+00           NaN           NaN          NaN
#> zambezi        -2.047816e+01           NaN           NaN          NaN
#> zimba          -3.545995e+01           NaN  -24.50394727          NaN
#>                      mwense   mwinilunga       nakonde       nalolo
#> chadiza                 NaN    4.0848171           NaN          NaN
#> chama                   NaN          NaN  -124.4918825          NaN
#> chavuma                 NaN  -35.2826452           NaN          NaN
#> chembe          -21.6226879   -2.9131734     2.5467675          NaN
#> chibombo         23.7996367   10.6289819    34.5415329   -0.5302600
#> chiengi         -61.4607084          NaN   -18.8862940          NaN
#> chikankanta             NaN    1.9455072     6.8069416          NaN
#> chilanga          6.4329384    1.4516826    22.8336161   11.6403045
#> chililabombwe   -20.5956134    4.8387197     9.2291383    7.3629156
#> chilubi         -53.1754044          NaN   -24.0067514          NaN
#> chingola        -23.5324702   36.0669859     4.3795096    0.4911861
#> chinsali         -7.3978876          NaN  -121.1695967          NaN
#> chipata          -1.2232013    7.4542981   -10.3369784          NaN
#> chipili         -55.9108548          NaN     4.6892184          NaN
#> chirundu                NaN          NaN    19.2720408          NaN
#> chisamba         13.5280089    8.4405277    16.2977191          NaN
#> chitambo        -10.5469797          NaN     7.2836146          NaN
#> choma             3.0674534   -0.2665201     7.8723323          NaN
#> chongwe           5.4459097    6.8655373    18.3706320    2.1984377
#> gwembe                  NaN          NaN           NaN          NaN
#> ikelenge                NaN -189.0291477           NaN          NaN
#> isoka            -5.8364774          NaN   -93.5044684          NaN
#> itezhi-tezhi            NaN          NaN    11.0938718  -12.6272739
#> kabompo                 NaN  -62.1681969           NaN          NaN
#> kabwe            23.6545432   19.7034429    39.0775471    1.4131552
#> kafue             0.8389377    3.3196706    12.2953873    3.4564956
#> kalabo                  NaN  -16.6863188           NaN   94.3817396
#> kalomo                  NaN   -1.1821009     6.0650563          NaN
#> kalulushi        -9.3872862   21.7024116     5.1739818          NaN
#> kalumbila               NaN  -68.8531428           NaN          NaN
#> kanchibiya              NaN          NaN   -32.4750484          NaN
#> kaoma                   NaN  -35.0142440     4.7942905  -39.7981674
#> kapiri mposhi    16.4406797   18.4473364    58.5759851    3.0462405
#> kaputa          -45.7355138          NaN   -22.0319720          NaN
#> kasama          -56.7125682    4.1986101   -92.3634363          NaN
#> kasempa                 NaN   -6.2334079     1.8992879   -4.1360294
#> katete           -1.1299473    3.4432608           NaN    3.3861656
#> kawambwa        -79.5486578          NaN    -8.8614043          NaN
#> kazungula               NaN          NaN           NaN  -16.0859452
#> kitwe            -6.6435918   52.2696100    31.6817827    4.9608580
#> lavushimanda            NaN          NaN     0.9888318          NaN
#> limulunga               NaN          NaN           NaN  -76.0504918
#> livingstone       4.3803221    1.5637014    14.0561359   -7.1015164
#> luampa                  NaN          NaN           NaN  -37.6035223
#> luangwa                 NaN          NaN           NaN          NaN
#> luano                   NaN          NaN           NaN          NaN
#> luanshya          7.2638460   19.5011810    13.7399345          NaN
#> lufwanyama      -10.9075559   18.6536138     1.0367170          NaN
#> lukulu                  NaN  -33.6812431     7.7560218  -47.9755656
#> lundazi                 NaN          NaN   -47.4566013          NaN
#> lunga                   NaN    2.1309454           NaN          NaN
#> lunte district          NaN          NaN   -40.6176632          NaN
#> lusaka           36.9100473   31.8225378    78.6672262   22.5203462
#> luwingu         -53.5667699          NaN   -21.2893148          NaN
#> mafinga                 NaN          NaN  -168.0435513          NaN
#> mambwe                  NaN          NaN    -8.2447622          NaN
#> mansa           -70.4376670   -7.1902415     6.2530881    4.3095402
#> manyinga         -2.1194479  -92.0759981           NaN          NaN
#> masaiti           2.9235054   16.4209807    16.3489252          NaN
#> mazabuka          2.2957157   -0.9832783     9.5253265    7.5838766
#> mbala           -17.6891678          NaN    44.9749816          NaN
#> milengi         -32.7602641          NaN    -2.6013378          NaN
#> mitete                  NaN          NaN           NaN          NaN
#> mkushi            0.8202267    1.7811349    40.2179776          NaN
#> mongu                   NaN  -15.9582293     3.7101196   27.3189523
#> monze                   NaN          NaN     8.2169904   -1.1641496
#> mpika           -17.5825828    2.0693768    -1.6580459          NaN
#> mpongwe          -6.7513752   -6.9766677     8.5256777          NaN
#> mporokoso       -38.5300653          NaN     0.5591711          NaN
#> mpulungu        -32.1957574    0.9702368   -73.0420628          NaN
#> mufulira          3.7769063    4.2943502    11.8597878          NaN
#> mufumbwe                NaN  -47.2698748           NaN          NaN
#> mulobezi                NaN          NaN           NaN  -19.0168559
#> mumbwa            0.8230054  -15.9426326     2.1269037   -5.4211040
#> mungwi          -19.0619180          NaN  -198.8805215          NaN
#> mwandi                  NaN          NaN           NaN  -20.5597751
#> mwansabombwe    -26.5271591   -1.8870222    -6.4296310          NaN
#> mwense         -940.0259228          NaN     0.1429071          NaN
#> mwinilunga              NaN -402.9180281     4.6791446          NaN
#> nakonde          -3.3470886    5.4135500 -1378.2527949          NaN
#> nalolo                  NaN          NaN           NaN -245.2484177
#> namwala                 NaN          NaN           NaN          NaN
#> nchelenge      -118.4647264   -4.1878195   -16.3100768          NaN
#> ndola           -14.5395182   33.3773349    25.0741315    2.6336506
#> ngabwe                  NaN   -5.8165984     1.9473571          NaN
#> nkeyema                 NaN          NaN           NaN  -11.6300247
#> nsama           -29.1847627          NaN   -29.1435496          NaN
#> nyimba           -2.9168887          NaN           NaN    3.8416047
#> pemba                   NaN    2.6666541           NaN          NaN
#> petauke                 NaN    7.2469977           NaN          NaN
#> rufunsa                 NaN    3.5287033     7.2059133          NaN
#> samfya          -40.5671869          NaN    -0.1101434          NaN
#> senanga                 NaN          NaN           NaN   36.8626081
#> serenje          -0.2432436          NaN    24.0793743          NaN
#> sesheke                 NaN   -1.1346606           NaN  -54.6500647
#> shang'ombo              NaN          NaN           NaN -100.3401774
#> shibuyunji              NaN          NaN           NaN    3.5288348
#> shiwamg'andu    -12.7929835          NaN   -34.8230951          NaN
#> siavonga                NaN          NaN           NaN          NaN
#> sikongo                 NaN          NaN           NaN  -77.7818806
#> sinazongwe        1.8552929          NaN     7.4080717          NaN
#> sinda                   NaN          NaN           NaN          NaN
#> sioma                   NaN          NaN           NaN   28.2264016
#> solwezi         -22.9552949  399.7653018     2.8019360   -2.5088522
#> vubwi                   NaN          NaN           NaN          NaN
#> zambezi                 NaN  -60.6362306           NaN          NaN
#> zimba                   NaN          NaN           NaN   -5.3425817
#>                     namwala    nchelenge        ndola       ngabwe
#> chadiza                 NaN          NaN   -4.7238919          NaN
#> chama             2.8719477    -9.529092  -11.6149265          NaN
#> chavuma                 NaN     2.734235    7.4312317          NaN
#> chembe                  NaN    -5.200662  -73.7347127   -9.5743891
#> chibombo        -63.3588999    13.581307  150.2219863  -86.0606272
#> chiengi                 NaN  -161.870105  -11.8022932          NaN
#> chikankanta      12.6848215          NaN   11.6275260  -10.3492544
#> chilanga        -29.8644749    13.551233   26.9654739  -24.5109024
#> chililabombwe     1.1788298    -4.404379  -84.3292877  -23.3166755
#> chilubi                 NaN   -41.398731  -46.7727923          NaN
#> chingola         -5.8786021    -5.100598 -122.9832960  -46.4902714
#> chinsali                NaN    -7.908745   15.0295869    0.8476598
#> chipata                 NaN          NaN   -7.0985818          NaN
#> chipili                 NaN   -60.354229  -11.6102596          NaN
#> chirundu        -21.7502737          NaN   10.6828801          NaN
#> chisamba        -17.1506547     9.771594   67.5887907  -20.4110433
#> chitambo                NaN    -5.170242  -80.5949058          NaN
#> choma           -12.4545614     7.907451   12.3982857          NaN
#> chongwe         -21.0547700    21.826332   49.0766711  -20.3722017
#> gwembe          -35.7854859          NaN    2.9657952          NaN
#> ikelenge                NaN          NaN   -9.2071638          NaN
#> isoka                   NaN          NaN   14.9704638          NaN
#> itezhi-tezhi    121.5548069     2.571053  -15.0495966          NaN
#> kabompo                 NaN          NaN    0.3694022          NaN
#> kabwe           -28.4533456    15.618999  117.0891791    9.5033974
#> kafue            -2.8176282     2.956662   33.7869379  -10.2791853
#> kalabo                  NaN          NaN    3.0681044          NaN
#> kalomo          -70.7715795          NaN    1.2198510          NaN
#> kalulushi               NaN    -4.810316  -80.2631109  -28.6242967
#> kalumbila       -11.0167385          NaN   -8.5787009          NaN
#> kanchibiya              NaN          NaN          NaN          NaN
#> kaoma           -31.6681124          NaN   -4.9614239          NaN
#> kapiri mposhi   -22.3950152    12.113463   41.5155453   46.6954724
#> kaputa                  NaN  -148.037545   -4.1740305          NaN
#> kasama                  NaN   -67.143485   -9.4416240   -2.1956586
#> kasempa         -35.5831476          NaN  -49.3122870          NaN
#> katete                  NaN     2.177711  -10.7778390          NaN
#> kawambwa                NaN  -139.420818  -11.0813692          NaN
#> kazungula       -87.2531460          NaN    3.7122606          NaN
#> kitwe           -13.4945144     6.741346 -223.6842492  -62.9789946
#> lavushimanda            NaN          NaN  -40.8878552          NaN
#> limulunga               NaN          NaN          NaN          NaN
#> livingstone     -67.2405331          NaN   27.7231062          NaN
#> luampa                  NaN          NaN   -8.5450408          NaN
#> luangwa          -7.2119091          NaN  -17.6440092          NaN
#> luano                   NaN          NaN  -49.3343747          NaN
#> luanshya         -7.3380231     5.681722  164.8364438   18.5106996
#> lufwanyama       -9.4251702          NaN  -96.3690428  -44.2647758
#> lukulu                  NaN          NaN   -1.3837142          NaN
#> lundazi           1.0526441          NaN  -10.7358948          NaN
#> lunga                   NaN          NaN  -39.2426550          NaN
#> lunte district          NaN   -63.639528  -15.2084993          NaN
#> lusaka         -180.8299666    41.093188  124.5875321 -134.5501718
#> luwingu                 NaN   -54.607703  -14.6546263    0.4368671
#> mafinga                 NaN          NaN          NaN          NaN
#> mambwe                  NaN          NaN  -21.0615707          NaN
#> mansa            -2.5345502   -43.667585 -123.8438080  -14.4825368
#> manyinga                NaN          NaN   -3.5146766          NaN
#> masaiti          -6.3114598    -3.064922   52.6189186  -20.1658997
#> mazabuka        -27.1166654          NaN    5.4167450  -23.5435105
#> mbala             5.0106167   -45.422844   32.6616919          NaN
#> milengi                 NaN   -16.691351 -108.8631177   -9.8986193
#> mitete                  NaN          NaN          NaN          NaN
#> mkushi          -10.4296781     3.932626 -162.9041012  -33.1413188
#> mongu                   NaN          NaN    9.1126322          NaN
#> monze            74.6500391          NaN    4.4875734  -21.1181936
#> mpika             2.2411047    -9.650343   -3.1761903          NaN
#> mpongwe         -19.8341628    -1.948948 -118.7334234  -67.2939117
#> mporokoso               NaN   -90.016769    6.9812054          NaN
#> mpulungu          4.7215989   -76.102889   -5.2547413          NaN
#> mufulira         -0.8190333    10.127511 -159.5338164  -26.1512185
#> mufumbwe                NaN          NaN   -9.9145661          NaN
#> mulobezi                NaN          NaN          NaN          NaN
#> mumbwa          -86.5684622          NaN  -53.5420556  -63.6570096
#> mungwi                  NaN   -31.841382   -4.5970971          NaN
#> mwandi          -27.4468757          NaN          NaN          NaN
#> mwansabombwe      4.7848478  -128.333840  -22.1418489          NaN
#> mwense                  NaN   -90.600969  -46.4018439          NaN
#> mwinilunga              NaN    -8.683325  -10.6725556  -21.5629042
#> nakonde                 NaN   -17.597140   14.1406557    1.1728995
#> nalolo                  NaN          NaN    0.6459284          NaN
#> namwala         109.7034210          NaN  -14.7987805          NaN
#> nchelenge               NaN -1544.655864  -24.9122755          NaN
#> ndola           -10.4040165    -2.443190  694.8949655  -52.9925561
#> ngabwe                  NaN          NaN  -64.6092496   38.1905057
#> nkeyema         -42.0947319          NaN  -12.6435418          NaN
#> nsama                   NaN   -79.065451   -5.8808257          NaN
#> nyimba                  NaN          NaN  -53.7942432          NaN
#> pemba           -34.0046550          NaN    1.9001963   -6.5210990
#> petauke                 NaN          NaN  -69.5503378          NaN
#> rufunsa                 NaN          NaN  -21.7547025  -12.0584835
#> samfya           -1.4905140   -20.223112 -102.5487287   -8.6307598
#> senanga                 NaN          NaN    0.1650442          NaN
#> serenje          -2.0201532     2.691782  -83.6178768  -11.5991943
#> sesheke                 NaN          NaN    8.9572899          NaN
#> shang'ombo              NaN          NaN          NaN          NaN
#> shibuyunji      -39.1663859          NaN  -14.5089350          NaN
#> shiwamg'andu            NaN          NaN   -3.5887189          NaN
#> siavonga        -29.8378511          NaN   -3.6958785          NaN
#> sikongo                 NaN          NaN    1.5450041          NaN
#> sinazongwe      -54.8816753          NaN    4.9480381          NaN
#> sinda                   NaN          NaN  -21.1560729          NaN
#> sioma                   NaN          NaN   -0.8059065          NaN
#> solwezi         -19.8961167   -14.815287  -69.2516646  -68.2791773
#> vubwi                   NaN          NaN   -2.8404330          NaN
#> zambezi                 NaN          NaN   11.5520200          NaN
#> zimba           -61.8653119          NaN    1.7101282          NaN
#>                      nkeyema         nsama       nyimba       pemba
#> chadiza                  NaN           NaN   -2.7237726         NaN
#> chama                    NaN  -11.72501018   -6.2832654         NaN
#> chavuma                  NaN           NaN          NaN         NaN
#> chembe                   NaN           NaN          NaN         NaN
#> chibombo         -5.99381235    5.22584647   14.6555026 -10.6308949
#> chiengi                  NaN -122.55322466          NaN         NaN
#> chikankanta       3.31549531           NaN    8.6181213  25.9142836
#> chilanga         53.46445292           NaN   26.4927994   9.5128549
#> chililabombwe            NaN    0.26941439   -6.5593182  10.6135368
#> chilubi                  NaN  -22.70160508          NaN         NaN
#> chingola         -5.10910178           NaN   -6.6455666   1.6512476
#> chinsali                 NaN  -19.95507052          NaN         NaN
#> chipata                  NaN    2.14724180   83.4496983   4.9694814
#> chipili           7.51805151           NaN          NaN   3.6186621
#> chirundu                 NaN           NaN   -8.1117292 -16.8885238
#> chisamba          1.68307497    2.17942631  -13.4882782  -5.4889204
#> chitambo          3.12076125   -2.99056229          NaN         NaN
#> choma           -17.76801896           NaN   -1.6926524 213.0909516
#> chongwe           8.67560712           NaN  172.6076733   0.6716237
#> gwembe           -3.03461259           NaN          NaN 143.0836795
#> ikelenge                 NaN           NaN          NaN         NaN
#> isoka                    NaN           NaN          NaN         NaN
#> itezhi-tezhi    -56.94879435           NaN          NaN -33.7419618
#> kabompo         -37.48499929           NaN          NaN         NaN
#> kabwe             1.84119758    4.56138141  -15.0133760  -0.5737979
#> kafue            11.90420584           NaN   14.1085349  43.5551262
#> kalabo           -4.12522290           NaN          NaN         NaN
#> kalomo          -24.68267076           NaN   -1.2573796 -62.1488457
#> kalulushi                NaN           NaN   -5.0537841         NaN
#> kalumbila       -23.88698455           NaN   -0.5617592  -0.9707131
#> kanchibiya               NaN           NaN          NaN         NaN
#> kaoma            89.51029667           NaN          NaN  -7.1797275
#> kapiri mposhi    -1.47295361    4.47550608  -35.1109941  -0.4585375
#> kaputa                   NaN   11.62073150          NaN         NaN
#> kasama           17.03183723   50.85987854  -10.8677380         NaN
#> kasempa         -45.45625367           NaN          NaN  -8.1434694
#> katete            5.08520009           NaN   46.1626216   1.6728836
#> kawambwa                 NaN  -66.47547833          NaN         NaN
#> kazungula                NaN           NaN    1.0697983 -32.1613577
#> kitwe            -6.11494633   -2.31213431  -10.7803345   6.6911460
#> lavushimanda      2.87489284   -2.51423399          NaN         NaN
#> limulunga       -27.68501459           NaN          NaN         NaN
#> livingstone     -18.47437339           NaN    3.6637766 -10.4638436
#> luampa          -98.68796034           NaN          NaN         NaN
#> luangwa                  NaN           NaN    9.1662012         NaN
#> luano                    NaN           NaN  -47.1697869         NaN
#> luanshya         -2.96166363    0.99455420   -8.8322348   4.1282978
#> lufwanyama               NaN           NaN          NaN   1.5035983
#> lukulu          -47.16145664           NaN    3.3213284         NaN
#> lundazi                  NaN   -4.34817316    3.7685958         NaN
#> lunga                    NaN           NaN          NaN         NaN
#> lunte district           NaN  -66.91680110          NaN         NaN
#> lusaka           41.63538320   15.13840282  116.3565175 -64.5268379
#> luwingu           9.95719406  -36.38033651          NaN         NaN
#> mafinga                  NaN           NaN          NaN         NaN
#> mambwe            4.38987313           NaN  -42.1167145         NaN
#> mansa             7.07399458  -23.48547354  -12.5173923         NaN
#> manyinga                 NaN    3.10052407    2.4565057         NaN
#> masaiti          -0.83811701   -0.01462424  -15.0520826   3.8645582
#> mazabuka         -0.82517915           NaN    7.1297487  35.6895492
#> mbala             5.70554691  -87.39332945          NaN   4.6241926
#> milengi           1.17808825   -4.63530185          NaN   0.5670513
#> mitete                   NaN           NaN          NaN         NaN
#> mkushi            2.14495505    1.89925158  -86.9240675  -2.4698596
#> mongu           -17.72330984           NaN    4.7143052  -6.6162861
#> monze                    NaN           NaN   -2.3385454 253.6797574
#> mpika            16.24140676   -4.28750634  -35.5811116   0.8895286
#> mpongwe          -9.49045873           NaN  -10.1269945  -3.9824961
#> mporokoso         8.51600444    9.19664233          NaN         NaN
#> mpulungu                 NaN -134.25475367          NaN         NaN
#> mufulira                 NaN           NaN   -6.2403799   1.1838294
#> mufumbwe        -85.65114006           NaN          NaN         NaN
#> mulobezi        -35.62770201           NaN          NaN -10.9618291
#> mumbwa          -51.03093358           NaN   -7.4039927 -42.8958828
#> mungwi                   NaN  -48.19662548   -1.8408334         NaN
#> mwandi                   NaN           NaN          NaN  -9.3878228
#> mwansabombwe             NaN  -31.26227182          NaN         NaN
#> mwense                   NaN  -28.19508841   -3.2059340         NaN
#> mwinilunga               NaN           NaN          NaN  -0.7855444
#> nakonde                  NaN  -36.24301619          NaN         NaN
#> nalolo          -13.21354055           NaN    3.5747956         NaN
#> namwala         -24.64107518           NaN          NaN -43.8974801
#> nchelenge                NaN  -93.10809254          NaN         NaN
#> ndola            -4.42524228   -1.17009549  -25.8369661   2.4815707
#> ngabwe                   NaN           NaN          NaN  -7.1730022
#> nkeyema        -282.03541414           NaN          NaN -10.1845364
#> nsama                    NaN -489.28152901          NaN         NaN
#> nyimba                   NaN           NaN  -72.7279226  -2.3630773
#> pemba            -4.14714128           NaN    0.1446407 404.5085203
#> petauke                  NaN           NaN   31.9357840  -2.8925302
#> rufunsa           0.09163498           NaN  157.8075465  -5.6102843
#> samfya            4.88573545           NaN          NaN   1.3272948
#> senanga         -35.95149797           NaN          NaN         NaN
#> serenje           4.29039313   -2.01761707 -104.3889703  -1.6392405
#> sesheke         -20.45843218           NaN          NaN  -5.3339347
#> shang'ombo               NaN           NaN          NaN         NaN
#> shibuyunji        2.53429694           NaN          NaN -18.2102561
#> shiwamg'andu             NaN  -13.44031920          NaN         NaN
#> siavonga                 NaN           NaN   -7.5699309 -31.6641346
#> sikongo          -9.66781204           NaN          NaN         NaN
#> sinazongwe               NaN           NaN   -1.7944330 -62.9145862
#> sinda             2.76392735           NaN  -11.9694979         NaN
#> sioma           -17.67631860           NaN          NaN         NaN
#> solwezi         -25.52685234   -1.16103960   -6.6987967  -1.1551515
#> vubwi                    NaN           NaN  -14.7900384         NaN
#> zambezi         -30.94835857           NaN          NaN         NaN
#> zimba                    NaN           NaN   -0.8619061 -45.0106557
#>                     petauke      rufunsa      samfya      senanga       serenje
#> chadiza        -119.3866325   29.2935629         NaN          NaN           NaN
#> chama           -40.3365075    7.4334221 -23.6921404          NaN  -17.67957866
#> chavuma                 NaN          NaN         NaN          NaN           NaN
#> chembe                  NaN          NaN -45.4722704          NaN  -17.35247033
#> chibombo          3.2269791    0.9845903  45.5694939   -0.3374025   84.04293065
#> chiengi                 NaN          NaN -20.7925445          NaN   -1.19817416
#> chikankanta       1.1856259   -6.4401792  -0.2186460          NaN   13.82777384
#> chilanga         20.9440466   29.7024750  25.8902169   18.2624258   27.26464296
#> chililabombwe    -7.5747171   -0.9031757 -12.9585182    3.7610508   -6.05770587
#> chilubi                 NaN          NaN  77.6777071          NaN  -28.30311286
#> chingola        -10.9251061   -1.5318459 -31.4423698          NaN  -15.88348306
#> chinsali        -13.8672976    1.8820260 264.7893672          NaN   41.55705869
#> chipata        -182.9788953  135.4849888 -16.5078688          NaN  -56.93541574
#> chipili                 NaN          NaN -18.8398306          NaN    7.35174071
#> chirundu         -5.7470563  -23.3066283         NaN          NaN   -2.70160795
#> chisamba        -13.4173647  -28.9365967  21.1768906    0.3872133   35.71005829
#> chitambo                NaN  -18.5185676  42.8105298          NaN -104.52898532
#> choma            -2.4267063   -9.9775831   1.2003798  -12.6353674    3.83320672
#> chongwe          93.1320234  317.6806350  16.0066024    3.9776577    8.22120434
#> gwembe           -5.0742237  -13.8037842         NaN   -1.0892628   -0.66385761
#> ikelenge                NaN          NaN         NaN          NaN           NaN
#> isoka            -8.3668147    1.0041208  -8.2991177          NaN   19.44546226
#> itezhi-tezhi     -1.4260861          NaN   0.8349628  -30.6192113    0.85406060
#> kabompo                 NaN          NaN         NaN          NaN           NaN
#> kabwe           -16.4520052  -30.0941077  46.0142148    1.2241516  101.16000055
#> kafue            10.1266919   -8.3225955   5.7647794    6.8245824   20.38375754
#> kalabo           11.6011716          NaN   5.1210450  -60.7516826           NaN
#> kalomo           -1.4387228   -7.9983178         NaN  -23.5615357    9.54314314
#> kalulushi        -8.5459959   -3.4847920 -17.9581172          NaN   -4.78811765
#> kalumbila               NaN          NaN         NaN   -7.1516473           NaN
#> kanchibiya              NaN          NaN -83.7883243          NaN  -47.70938150
#> kaoma             2.0500627   -0.7308771  11.9271795  -65.6873445   12.02614101
#> kapiri mposhi   -34.2510386  -46.6184296  32.4568282   -0.9641338   84.89453314
#> kaputa                  NaN          NaN         NaN          NaN   -2.34111719
#> kasama                  NaN    1.7893235 -70.3618659          NaN   26.49638082
#> kasempa                 NaN          NaN  -7.5961752   -5.4835321   -6.60416594
#> katete         -126.2932670  101.0087195         NaN    4.4064535           NaN
#> kawambwa         -3.0337169          NaN -30.9521605    5.5554155    0.81456483
#> kazungula         1.4598246   -3.6072329         NaN  -44.3230909    1.91322744
#> kitwe           -25.5239617   -7.0337563 -48.4953057    7.7172949  -32.07599590
#> lavushimanda    -75.8849718   -5.8008774 -45.2893716          NaN  -53.53446340
#> limulunga               NaN          NaN         NaN  -68.6469142           NaN
#> livingstone       2.3361497    0.3693352   4.0292099  -27.2729560    5.91495400
#> luampa                  NaN          NaN   5.1611958  -82.3886436    4.51209522
#> luangwa         -38.2688867   11.7006420         NaN          NaN  -21.65379108
#> luano           -43.2894949  -23.1902700         NaN          NaN  -36.16037852
#> luanshya        -14.9774033   -6.8738231 -21.5314051          NaN  -11.65904829
#> lufwanyama       -6.6146503   -7.2026337 -15.2872158          NaN  -10.90955103
#> lukulu                  NaN          NaN         NaN  -52.2575752           NaN
#> lundazi         -89.4188905   33.6996218 -18.7860800          NaN           NaN
#> lunga                   NaN          NaN 108.8677504          NaN  -25.13035273
#> lunte district          NaN          NaN -31.4345563          NaN   -3.48414743
#> lusaka           53.0284211   28.7545105  76.0768045   26.7923938   56.13809286
#> luwingu                 NaN          NaN 436.6797271          NaN    1.15792541
#> mafinga                 NaN          NaN         NaN          NaN   -4.07150913
#> mambwe         -178.1345674    0.1154785 -17.7528881          NaN  -55.93932614
#> mansa                   NaN          NaN 155.0171216          NaN   28.01656352
#> manyinga          2.4813470          NaN         NaN  -16.8053499           NaN
#> masaiti         -21.1088585  -11.7887552 -16.6465657          NaN   -6.82702084
#> mazabuka          0.7314708   -6.8684228   8.4302927    0.1707075   20.19985375
#> mbala                   NaN    3.0421771 -13.7985875          NaN   20.77130541
#> milengi                 NaN          NaN 276.4940789    4.3638611  -13.11535506
#> mitete                  NaN          NaN         NaN          NaN           NaN
#> mkushi          -92.5364618  -55.5470485   2.6938362          NaN  116.19827085
#> mongu             6.2196324    1.6464447  24.5235187 -110.6831716   22.35988119
#> monze            -2.8315633  -14.0208522   3.6732909   -5.1866366    6.33516060
#> mpika          -117.5656166    5.1181727 -39.6235954          NaN   30.57104144
#> mpongwe                 NaN  -14.7860204 -14.3362415          NaN   -7.56948518
#> mporokoso               NaN          NaN -14.1902137          NaN   23.40625482
#> mpulungu                NaN          NaN -20.1343550          NaN    8.34859413
#> mufulira         -8.8898358   -0.9307053 -18.2840884          NaN  -19.44701526
#> mufumbwe         -0.4494514          NaN         NaN  -25.7774940   -2.30730491
#> mulobezi                NaN          NaN         NaN   71.6459914           NaN
#> mumbwa           -6.6239748  -10.3236895   1.3688165  -15.7021178    0.25111064
#> mungwi                  NaN          NaN -26.7536699          NaN    2.98204693
#> mwandi            1.4788069          NaN         NaN  -47.3585634           NaN
#> mwansabombwe     -3.2914680          NaN -24.1687218          NaN    0.31704052
#> mwense                  NaN          NaN -48.9157592          NaN   -0.92696691
#> mwinilunga        4.6958541    0.4841102         NaN          NaN           NaN
#> nakonde                 NaN    5.6633263  -6.4331688          NaN   19.83876384
#> nalolo                  NaN          NaN         NaN   40.2586119           NaN
#> namwala                 NaN          NaN  -0.7699114          NaN   -0.07171268
#> nchelenge               NaN          NaN -32.3564456          NaN   -0.17989854
#> ndola           -34.0592768  -14.1991609 -47.8654279    3.8076451  -27.78852416
#> ngabwe                  NaN  -11.3562835  -5.1118371          NaN   -6.45870205
#> nkeyema                 NaN   -1.7271738   4.0709855  -32.2328567    3.58145736
#> nsama                   NaN          NaN         NaN          NaN   -2.37979188
#> nyimba           53.9836679  119.5836592         NaN          NaN -106.63722546
#> pemba            -1.0076016   -4.3167781   2.0773695          NaN   -0.07062899
#> petauke        -655.6117566   36.7568610 -36.5546860          NaN -177.13601799
#> rufunsa          69.5693716 -526.4239442  -5.3980368          NaN  -21.64481638
#> samfya          -32.1029517   -7.4841441 487.1153442          NaN   14.54208370
#> senanga                 NaN          NaN         NaN -379.3548148           NaN
#> serenje        -163.9035947  -31.7969728  11.0452349          NaN  402.59450119
#> sesheke                 NaN          NaN         NaN  -97.1707489    1.77425434
#> shang'ombo              NaN          NaN         NaN  -82.2616873           NaN
#> shibuyunji       -4.2094487  -12.8291509         NaN    0.5192374           NaN
#> shiwamg'andu    -23.5871650    6.6013016 -28.2323941          NaN   12.89079399
#> siavonga         -4.1659532  -21.8820852   0.5875006          NaN   -4.68122558
#> sikongo                 NaN          NaN         NaN  -54.7278649    3.97716685
#> sinazongwe       -2.2070736   -9.1405108   0.6802865   -7.5559496    1.81360309
#> sinda            53.6634292   65.5270782 -12.3480080          NaN           NaN
#> sioma                   NaN          NaN         NaN   81.8319816           NaN
#> solwezi          -5.4805160   -7.6086123 -18.9731279   -5.7479456   -9.46398166
#> vubwi           -65.6339955    4.4405983         NaN          NaN           NaN
#> zambezi                 NaN          NaN         NaN          NaN           NaN
#> zimba                   NaN   -5.5901548         NaN  -13.2963911    6.50770514
#>                     sesheke  shang'ombo   shibuyunji shiwamg'andu     siavonga
#> chadiza                 NaN         NaN          NaN          NaN          NaN
#> chama                   NaN         NaN          NaN -130.2011609          NaN
#> chavuma                 NaN         NaN          NaN          NaN          NaN
#> chembe                  NaN         NaN    5.1793848   -5.6646859          NaN
#> chibombo          0.1044736         NaN -113.1292513   54.0728506  -23.4440113
#> chiengi                 NaN         NaN          NaN          NaN          NaN
#> chikankanta       7.7577110         NaN  -23.7565821    2.0762731  -24.0849096
#> chilanga          2.6201347         NaN  130.9384747   18.8628660   -1.7472311
#> chililabombwe           NaN         NaN   -7.4656426   -0.4744057    3.1725733
#> chilubi                 NaN         NaN          NaN  -54.8269301          NaN
#> chingola         10.4378350         NaN  -14.1075564    1.9810455   -4.0396787
#> chinsali                NaN         NaN          NaN   93.6640148          NaN
#> chipata                 NaN         NaN   -0.6513852  -24.3592573   -2.5367253
#> chipili                 NaN         NaN          NaN   -7.2583838          NaN
#> chirundu          0.5445434         NaN  -30.8166994          NaN   72.8178551
#> chisamba                NaN         NaN  -35.6299253   26.1625704  -21.0704507
#> chitambo                NaN         NaN   -5.9294977  -15.9623161   -4.2889823
#> choma            -1.3074474         NaN  -62.1573591    7.0320675  -59.8134624
#> chongwe           5.0202314         NaN  -45.3125299   13.5488498  -30.2850615
#> gwembe            3.1439350         NaN  -39.6011008          NaN  -54.1051961
#> ikelenge                NaN         NaN          NaN          NaN          NaN
#> isoka                   NaN         NaN          NaN  -25.3098929          NaN
#> itezhi-tezhi            NaN         NaN  -46.2179945    7.1864523  -21.8338642
#> kabompo                 NaN         NaN          NaN          NaN          NaN
#> kabwe             3.9376868         NaN  -59.7691374   49.8147383  -22.7488683
#> kafue            13.6474434    3.253076  222.9566937   27.6663384   17.7807597
#> kalabo          -18.6841501  -62.558679   16.7336107          NaN          NaN
#> kalomo          -19.1782800         NaN  -50.2915219    6.6358019  -45.9716523
#> kalulushi         6.5963371         NaN  -10.4092666    0.1156854   -1.1285150
#> kalumbila        -1.6175415         NaN          NaN          NaN   -1.9449095
#> kanchibiya              NaN         NaN          NaN  -97.7440527          NaN
#> kaoma           -18.4013842  -23.717108   -4.5915076          NaN    0.3792812
#> kapiri mposhi     0.2542667         NaN  -51.8845849   52.0806636  -13.3669364
#> kaputa                  NaN         NaN          NaN  -13.3039437          NaN
#> kasama                  NaN         NaN          NaN  -67.1742750    5.9308894
#> kasempa          -2.7617940         NaN          NaN          NaN          NaN
#> katete            6.0068722         NaN          NaN          NaN          NaN
#> kawambwa                NaN         NaN          NaN          NaN    2.7882936
#> kazungula       -33.6224110         NaN          NaN    5.5798680  -21.8902560
#> kitwe            12.0571325         NaN  -24.3550856   12.9107387    9.6634876
#> lavushimanda            NaN         NaN          NaN  -20.1019132   -1.0145662
#> limulunga       -21.3537853         NaN          NaN          NaN          NaN
#> livingstone      -8.0251018         NaN  -23.5687200    5.7083625  -20.3406092
#> luampa          -33.7145226         NaN  -15.3057519          NaN          NaN
#> luangwa                 NaN         NaN          NaN          NaN          NaN
#> luano                   NaN         NaN          NaN          NaN          NaN
#> luanshya          2.7743511         NaN  -12.8139058    6.1355491    4.7203321
#> lufwanyama              NaN         NaN          NaN          NaN          NaN
#> lukulu          -15.0873888         NaN   -5.6058288          NaN   -0.4530385
#> lundazi                 NaN         NaN          NaN  -70.8910537    5.2985888
#> lunga                   NaN         NaN          NaN          NaN          NaN
#> lunte district          NaN         NaN          NaN          NaN          NaN
#> lusaka           23.8246632   -1.984010 -369.5423437   85.6450522 -189.7900750
#> luwingu                 NaN         NaN          NaN  -49.2779304          NaN
#> mafinga                 NaN         NaN          NaN  -58.4629804          NaN
#> mambwe                  NaN         NaN   -1.7622785          NaN          NaN
#> mansa                   NaN         NaN   -3.1525924  -20.8838460          NaN
#> manyinga                NaN         NaN          NaN          NaN          NaN
#> masaiti           1.6296405         NaN  -15.1773060   11.5104955   -6.1942139
#> mazabuka          9.6668930         NaN  -31.1308916          NaN  -52.7510878
#> mbala             7.6832405         NaN          NaN  -44.7034792          NaN
#> milengi                 NaN         NaN          NaN          NaN          NaN
#> mitete                  NaN         NaN          NaN          NaN          NaN
#> mkushi                  NaN         NaN  -25.3912105   35.4606904  -14.7641186
#> mongu            -6.2590090  -35.906285    7.7695095          NaN          NaN
#> monze             4.7910934         NaN  -87.9689964          NaN  -69.0559527
#> mpika             9.1736941         NaN    1.1271719   -9.7134588    4.8071701
#> mpongwe                 NaN         NaN  -30.7832815    2.5257515          NaN
#> mporokoso               NaN         NaN          NaN  -11.8668144          NaN
#> mpulungu                NaN         NaN          NaN  -37.6092275          NaN
#> mufulira                NaN         NaN   -6.9273157   -1.4840628   14.8493375
#> mufumbwe         -6.8728196         NaN          NaN          NaN          NaN
#> mulobezi        -30.9021160  -20.035633          NaN          NaN          NaN
#> mumbwa          -11.0817042         NaN  -97.9056338          NaN  -30.7252255
#> mungwi                  NaN         NaN          NaN  -99.4073615          NaN
#> mwandi            2.7411314         NaN          NaN          NaN          NaN
#> mwansabombwe            NaN         NaN          NaN          NaN          NaN
#> mwense                  NaN         NaN          NaN  -12.9930364          NaN
#> mwinilunga       -2.2645944         NaN          NaN          NaN          NaN
#> nakonde                 NaN         NaN          NaN  -54.6013920          NaN
#> nalolo          -39.2130658  -69.400410   -0.1088938          NaN          NaN
#> namwala                 NaN         NaN  -66.4765230          NaN  -35.3962170
#> nchelenge               NaN         NaN          NaN          NaN          NaN
#> ndola            14.1434151         NaN  -21.5001058    7.6549788   -2.5606129
#> ngabwe                  NaN         NaN          NaN          NaN          NaN
#> nkeyema         -14.0868721         NaN  -12.7076315          NaN          NaN
#> nsama                   NaN         NaN          NaN  -14.0894752          NaN
#> nyimba                  NaN         NaN          NaN          NaN  -13.8825619
#> pemba             3.4240577         NaN  -26.8052080          NaN  -32.2191682
#> petauke                 NaN         NaN  -12.5860681  -24.0891810  -11.4770121
#> rufunsa                 NaN         NaN  -22.3060907    8.3911473  -25.5186206
#> samfya                  NaN         NaN          NaN  -24.8834034   -1.3450219
#> senanga         -71.1545144  -64.200138   -5.6966979          NaN          NaN
#> serenje           2.2766903         NaN          NaN   14.6049295   -8.1653997
#> sesheke        -513.8865397  -58.417840          NaN          NaN          NaN
#> shang'ombo      -57.2094074 -845.801766          NaN          NaN          NaN
#> shibuyunji              NaN         NaN -848.1865314          NaN  -24.3621777
#> shiwamg'andu            NaN         NaN          NaN -294.6318374          NaN
#> siavonga                NaN         NaN  -35.2368748          NaN -545.6099032
#> sikongo         -23.4470976  -68.002177    8.7356998          NaN          NaN
#> sinazongwe       -6.1795042         NaN  -34.2909869          NaN  -55.7300651
#> sinda                   NaN         NaN          NaN          NaN   -4.8665873
#> sioma          -131.9800968 -141.786161          NaN          NaN          NaN
#> solwezi           1.6575167         NaN          NaN   -1.4054605          NaN
#> vubwi                   NaN         NaN          NaN          NaN          NaN
#> zambezi                 NaN         NaN          NaN          NaN          NaN
#> zimba           -12.8943703         NaN  -22.9110402    2.8690657  -32.1475928
#>                    sikongo    sinazongwe        sinda        sioma
#> chadiza                NaN           NaN -107.1179603          NaN
#> chama                  NaN           NaN  -22.7976329          NaN
#> chavuma                NaN           NaN          NaN          NaN
#> chembe                 NaN           NaN          NaN          NaN
#> chibombo          8.760242   -8.71158342   15.7724365   -1.0462116
#> chiengi                NaN           NaN          NaN          NaN
#> chikankanta      11.418507    3.33022709   -2.5587204    9.0434684
#> chilanga         20.871907    1.93512324   21.8539971    6.7231572
#> chililabombwe     3.108498   21.69725420   -1.7899406          NaN
#> chilubi                NaN    3.89533129          NaN          NaN
#> chingola          1.160514    4.85410395          NaN          NaN
#> chinsali               NaN    4.38472553   -7.9411167          NaN
#> chipata                NaN    2.79291610 -139.2088547    3.3940094
#> chipili                NaN           NaN          NaN          NaN
#> chirundu               NaN  -19.24880209          NaN          NaN
#> chisamba          5.548873   -3.42668135   -5.6977896          NaN
#> chitambo               NaN           NaN          NaN          NaN
#> choma                  NaN  178.25055386    2.5105387   -7.3429428
#> chongwe           8.639925   -2.58981696   91.9067067   11.4380712
#> gwembe            1.400439   -0.09597450          NaN    0.9219707
#> ikelenge               NaN           NaN          NaN          NaN
#> isoka                  NaN           NaN   -5.3849574          NaN
#> itezhi-tezhi     -4.856051  -28.96310182    0.6933487          NaN
#> kabompo                NaN           NaN          NaN          NaN
#> kabwe             5.030646    1.69716411   -5.1321479    1.5970525
#> kafue            18.732384   20.13100564    6.1367527          NaN
#> kalabo           26.531078           NaN          NaN  -42.7788631
#> kalomo                 NaN -103.12510239          NaN  -14.3749732
#> kalulushi              NaN    2.08842170   -1.6160706          NaN
#> kalumbila              NaN           NaN          NaN          NaN
#> kanchibiya             NaN           NaN          NaN          NaN
#> kaoma           -26.030575   -8.61036708          NaN  -23.6630208
#> kapiri mposhi     3.568692   -0.14896255  -12.6035968          NaN
#> kaputa                 NaN           NaN          NaN          NaN
#> kasama            5.275935    3.11559765  -14.4987314          NaN
#> kasempa                NaN           NaN          NaN   -2.7403183
#> katete                 NaN    1.55514191  125.9097280          NaN
#> kawambwa               NaN    2.39678582          NaN          NaN
#> kazungula        -7.374618  -78.03037981          NaN  -28.3324820
#> kitwe            14.149919   15.60390607   -9.4908525    2.7484125
#> lavushimanda           NaN    2.11332297          NaN          NaN
#> limulunga       -53.322252   -2.26480592          NaN  -32.2180648
#> livingstone            NaN -103.91335098          NaN  -21.2200813
#> luampa          -16.603639  -15.44130086          NaN  -30.8184801
#> luangwa                NaN           NaN  -20.5851705          NaN
#> luano                  NaN           NaN          NaN          NaN
#> luanshya          6.869846    5.17201126   -5.5542628          NaN
#> lufwanyama        3.293802   -1.16010254          NaN          NaN
#> lukulu                 NaN           NaN          NaN          NaN
#> lundazi                NaN           NaN  -55.0054417          NaN
#> lunga                  NaN           NaN          NaN          NaN
#> lunte district         NaN           NaN          NaN          NaN
#> lusaka           33.454926  -60.54103087   80.0209140   18.2747198
#> luwingu                NaN           NaN   -6.9067765          NaN
#> mafinga                NaN           NaN          NaN          NaN
#> mambwe                 NaN           NaN -117.7042281          NaN
#> mansa                  NaN    5.54067668          NaN    3.7679253
#> manyinga               NaN           NaN          NaN          NaN
#> masaiti                NaN    1.68826216   -6.5457032          NaN
#> mazabuka         18.484629   11.20043826    0.7275035    9.6692149
#> mbala                  NaN           NaN   -0.7963965          NaN
#> milengi                NaN           NaN          NaN          NaN
#> mitete                 NaN           NaN          NaN          NaN
#> mkushi            2.257786   -3.10519426          NaN          NaN
#> mongu           -32.834931   -7.68834515          NaN  155.5101920
#> monze             2.240415  -27.84383475   -1.8851591   -0.1016440
#> mpika                  NaN    0.99589414  -67.1263043          NaN
#> mpongwe                NaN   -0.80554975   -4.3748459          NaN
#> mporokoso              NaN           NaN          NaN          NaN
#> mpulungu               NaN           NaN          NaN          NaN
#> mufulira               NaN    0.05301932   -3.1459609    1.9377590
#> mufumbwe               NaN           NaN          NaN          NaN
#> mulobezi        -11.862062           NaN          NaN   39.4174553
#> mumbwa           -2.323197  -36.21968280   -1.1445664   -6.2646721
#> mungwi                 NaN           NaN          NaN          NaN
#> mwandi           -8.324716  -22.74375056          NaN  -41.1999612
#> mwansabombwe           NaN           NaN          NaN          NaN
#> mwense                 NaN    1.71881886          NaN          NaN
#> mwinilunga             NaN           NaN          NaN          NaN
#> nakonde                NaN    6.99861239          NaN          NaN
#> nalolo          -51.976478           NaN          NaN   78.4876325
#> namwala                NaN  -37.25335739          NaN          NaN
#> nchelenge              NaN           NaN          NaN          NaN
#> ndola             3.602765   10.48469787  -12.1344968    1.2090797
#> ngabwe                 NaN           NaN          NaN          NaN
#> nkeyema          -5.415034           NaN    2.2143216  -10.4266682
#> nsama                  NaN           NaN          NaN          NaN
#> nyimba                 NaN   -2.28200921  -37.0321726          NaN
#> pemba                  NaN  -23.69348227          NaN          NaN
#> petauke                NaN   -2.95119656  -76.9998181          NaN
#> rufunsa                NaN   -6.11668523   73.4862502          NaN
#> samfya                 NaN    0.66198007  -14.0539291          NaN
#> senanga         -43.689860  -11.12892478          NaN  139.7452557
#> serenje           4.444588    1.53080207          NaN          NaN
#> sesheke         -24.552810  -14.71310361          NaN -127.4877375
#> shang'ombo      -69.869157           NaN          NaN -134.3675322
#> shibuyunji       13.915021  -15.31536495          NaN          NaN
#> shiwamg'andu           NaN           NaN          NaN          NaN
#> siavonga               NaN  -35.76316336   -2.8813314          NaN
#> sikongo        -218.615241           NaN          NaN  -52.1067705
#> sinazongwe             NaN  294.19421354          NaN          NaN
#> sinda                  NaN           NaN  116.8319303          NaN
#> sioma           -56.286031           NaN          NaN -411.4845147
#> solwezi                NaN           NaN   -0.9418026   -0.2138583
#> vubwi                  NaN           NaN  -57.6748316          NaN
#> zambezi                NaN           NaN          NaN          NaN
#> zimba                  NaN    4.65362690          NaN   -8.6869232
#>                      solwezi         vubwi      zambezi        zimba
#> chadiza                  NaN  361.91030785          NaN          NaN
#> chama                    NaN           NaN          NaN          NaN
#> chavuma          21.96586915           NaN -133.3048335          NaN
#> chembe          -16.96801003           NaN          NaN          NaN
#> chibombo         18.90444300    2.83426650    8.2871935   -2.5690006
#> chiengi          -6.26643664           NaN          NaN          NaN
#> chikankanta      -0.01946928           NaN    1.4941229   23.5341875
#> chilanga          5.65534542    4.41585905    9.6219641    9.9852430
#> chililabombwe   -33.35406783           NaN    3.6882485   19.5540703
#> chilubi          -6.99601789           NaN          NaN          NaN
#> chingola         35.25479912    3.75755477   13.9411418    1.8960851
#> chinsali          0.03901307           NaN          NaN          NaN
#> chipata           5.62537326 -123.84445457          NaN          NaN
#> chipili          -4.66931448           NaN          NaN          NaN
#> chirundu          0.38165486    2.98983233          NaN  -10.6037572
#> chisamba         21.34363846           NaN    7.7511944    1.9028360
#> chitambo         -2.35881506           NaN          NaN          NaN
#> choma            -3.55462730    1.45294354   -1.1570191   -2.4664663
#> chongwe          23.81651701   12.31746397   13.2303436    3.1576989
#> gwembe           -0.85839306           NaN          NaN  -32.0778698
#> ikelenge        -29.61714667           NaN  -36.4789733          NaN
#> isoka                    NaN           NaN          NaN          NaN
#> itezhi-tezhi    -16.27768043           NaN          NaN  -45.8437551
#> kabompo          38.22402910           NaN  -82.5822544          NaN
#> kabwe            41.46050693   -1.13748818   16.6192753    1.1253091
#> kafue             7.17014237           NaN    3.7097404   37.3350336
#> kalabo           -5.82793168           NaN -109.7182078          NaN
#> kalomo           -4.96636204    3.02251640          NaN   61.1022884
#> kalulushi        17.51798214    2.53354619    9.2516593          NaN
#> kalumbila        72.58086070           NaN  -10.8058590          NaN
#> kanchibiya               NaN           NaN          NaN          NaN
#> kaoma           -21.61127098           NaN  -72.6134969  -11.8121998
#> kapiri mposhi    28.56730995   -2.44135756   11.9282302    0.9216752
#> kaputa                   NaN           NaN          NaN          NaN
#> kasama           12.78447136           NaN    5.9170984    7.3144264
#> kasempa           8.70845894           NaN   16.8956425   -3.7761364
#> katete            3.40784034   91.17162600    9.0501821          NaN
#> kawambwa         -4.48341778           NaN          NaN          NaN
#> kazungula        -4.15273265           NaN          NaN  -47.5218903
#> kitwe            72.17538503   -0.03145250   27.7938225   12.7467009
#> lavushimanda             NaN           NaN          NaN          NaN
#> limulunga                NaN           NaN          NaN          NaN
#> livingstone       5.63524583           NaN          NaN -191.8294963
#> luampa          -17.24190615           NaN          NaN          NaN
#> luangwa                  NaN   -3.31008693          NaN          NaN
#> luano                    NaN           NaN          NaN          NaN
#> luanshya         32.80311350   -0.26341266   10.8959214    4.5995093
#> lufwanyama        2.25645091           NaN    8.2248503    2.4025960
#> lukulu          -19.34445456           NaN -101.0512751          NaN
#> lundazi           6.31591265  -81.79309009          NaN    3.4386601
#> lunga            -4.80910350           NaN          NaN          NaN
#> lunte district           NaN           NaN          NaN          NaN
#> lusaka           42.17430954   14.11479098   17.0031100  -13.7785640
#> luwingu           0.98998604           NaN          NaN          NaN
#> mafinga                  NaN           NaN          NaN    3.4352598
#> mambwe                   NaN  -57.13060101          NaN          NaN
#> mansa           -31.60499471           NaN          NaN          NaN
#> manyinga         15.85126516           NaN  -69.3355054          NaN
#> masaiti          28.26268942   -0.07216093   13.4936938    6.1096714
#> mazabuka         -1.07437071           NaN    5.1578711   19.2918524
#> mbala             8.25878596           NaN          NaN   12.0638320
#> milengi         -17.02446014           NaN          NaN          NaN
#> mitete                   NaN           NaN -115.1777916          NaN
#> mkushi          -12.77473477           NaN          NaN   -2.7622110
#> mongu            -5.78266517           NaN  -66.8140661  -14.4095393
#> monze            -0.52147528           NaN   -0.1466531  -13.3988773
#> mpika             4.93389914           NaN    5.4225848          NaN
#> mpongwe         -56.86218507           NaN          NaN    2.3644384
#> mporokoso         0.88037126    2.06291109    4.3370302          NaN
#> mpulungu          1.70327404           NaN          NaN          NaN
#> mufulira        -16.51371708           NaN    1.7258373    5.3691232
#> mufumbwe         12.27993446           NaN  -13.1535368          NaN
#> mulobezi         -4.76735167           NaN          NaN  -27.2038922
#> mumbwa          -53.50274038    2.97854593  -10.5370385  -34.6254027
#> mungwi            1.21475132           NaN          NaN          NaN
#> mwandi            1.79777678           NaN          NaN  -38.1881673
#> mwansabombwe    -10.70428045           NaN          NaN          NaN
#> mwense          -19.25086531           NaN          NaN          NaN
#> mwinilunga      248.32089394           NaN  -76.2345142          NaN
#> nakonde           2.55896176           NaN          NaN          NaN
#> nalolo           -2.85155522           NaN          NaN   -7.2821175
#> namwala         -11.44400846           NaN          NaN  -42.8794046
#> nchelenge       -15.44405576           NaN          NaN          NaN
#> ndola            31.44268095   -0.03223888   22.0797484    5.8718271
#> ngabwe          -37.52278004           NaN          NaN          NaN
#> nkeyema         -25.54390756           NaN  -21.3247019          NaN
#> nsama            -0.77719899           NaN          NaN          NaN
#> nyimba           -5.37791366  -17.24285263          NaN   -0.9165878
#> pemba             3.18555668           NaN          NaN  -15.2542268
#> petauke          -4.35693015  -79.28074778          NaN          NaN
#> rufunsa          -3.69412400    6.20489627          NaN   -3.4532368
#> samfya          -13.57871896           NaN          NaN          NaN
#> senanga          -6.40457732           NaN          NaN  -18.4586734
#> serenje          -6.68988508           NaN          NaN    6.5285912
#> sesheke          -0.27579346           NaN          NaN  -27.5146689
#> shang'ombo               NaN           NaN          NaN          NaN
#> shibuyunji               NaN           NaN          NaN   -7.5097548
#> shiwamg'andu     -0.97446853           NaN          NaN    2.8325473
#> siavonga                 NaN           NaN          NaN  -19.1127800
#> sikongo                  NaN           NaN          NaN          NaN
#> sinazongwe               NaN           NaN          NaN   19.6570762
#> sinda             0.59013976  -52.70474877          NaN          NaN
#> sioma            -2.22067169           NaN          NaN  -17.3101568
#> solwezi        -457.92352886           NaN   47.4672303   -2.5218371
#> vubwi                    NaN  379.30968925          NaN          NaN
#> zambezi          34.04654054           NaN -707.4016684          NaN
#> zimba            -1.52283622           NaN          NaN  -11.3175151
#> attr(,"model")
#> [1] "departure-diffusion"
#> attr(,"type")
#> [1] "exp"
#> attr(,"hierarchical")
#> [1] FALSE
#> attr(,"residuals")
#> [1] "deviance"

# Get nomad_model object without underlying data
nmd_model <- nomad::model_db$zmb_fb_2020_mod_grav_exp

# Model residuals not available
residuals(nmd_model)
#> ℹ Residuals are not available because the underlying model data are not
#>   bundled.
```
