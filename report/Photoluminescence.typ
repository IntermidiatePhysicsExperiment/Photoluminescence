#import "template.typ": *
#import "@preview/tablex:0.0.8": *
#let th=[#math.theta]
#let ll=[#sym.angle.l]
#let rr=[#sym.angle.r]
#let eps=[#math.epsilon]
#let times="×"
#show: project.with(
  title: "Single Photon Interference",
  authors: (
    (name: "Seunghyun Moon", email: "shmoon232@snu.ac.kr", affiliation: "Department of Physics and Astronomy, Seoul National University,\nSeoul, 08826 South Korea"),
  ),
  abstract: "이 보고서에서는 Photoluminescence(PL) 현상을 액체 시료인 Rhodamine 590과 고체 시료인 루비에 대해서 관측한다. Rhodamine590에 대해서는 상온, 상압에서 실험을 진행했으며, 루비에 대해서는 낮은 압력에서 온도를 바꾸어 가며 실험을 진행하였다. Rhodamine590의 잘 알려진 두 개의 Peak가 올바르게 나타났으며, 루비의 두 개의 Peak 또한 잘 알려진 바와 유사하게 나타났다. Rhodamine590에 대해서는 Double Gaussian Fit을 진행하여 겹쳐진 두 피크를 분석하였고, 실험에서의 Hyperparameter가 어떻게 변화하여야 Noise의 영향이 작아지는지를 확인하였다. 루비에 대해서는 Double Lorentzian Fit을 진행하였고, Peak의 다양한 물리량이 온도에 따라 어떻게 변화하는지를 분석하였다. 다만, 온도에 다른 루비의 의존성이 잘 알려진 바와 다르게 나타났는데, 이는 본 실험에서 사용한 온도 조절 장치의 이상으로 보인다. "+"\n"+text(weight: "bold")[Keywords: ]
  +"Photoluminescence, Rhodamine 590, Ruby",
  date: "June 4, 2024",
)


= Introduction

== Photoluminescence

광발광(Photoluminescence, PL)은 물질이 광자를 흡수한 후 빛이 발생하는 현상으로, 물질 내 원자나 분자에 묶인 전자의 에너지 상태가 광자로 인해 들뜬 상태가 되었다가 다시 돌아가며 빛의 형태로 에너지를 방출하는 과정이다. 이러한 과정은 아래 @AbsorptionEmission 과 같이 나타난다. 이때 물질의 밴드 갭은 물질의 특성으로 인해 결정되며, 이 밴드 갭에 해당하는 빛이 흡수되고 방출되어 발광이 일어난다.

#figure(
  image(
    "images/AbsorptionEmission.png",
    width: 20em,
  ),
  caption: "Absorption and Emission of light by a material"+[@biswas2023population],
) <AbsorptionEmission>

여기서의 밴드 갭은 물질의 전자가 가질 수 있는 에너지 범위의 차이가 되는데, 일반적인 밴드 갭은 HOMO와 LUMO 사이의 에너지 차이로 정의된다. HOMO는 Highest Occupied Molecular Orbital의 약자로, 분자 내 전자가 가질 수 있는 가장 높은 에너지 준위를 나타내며, LUMO는 Lowest Unoccupied Molecular Orbital의 약자로, 분자 내 전자가 가질 수 있는 가장 낮은 에너지 준위를 나타낸다. 이러한 HOMO와 LUMO 사이의 에너지 차이가 밴드 갭이 되며, 이 밴드 갭에 해당하는 빛이 흡수되고 방출되어 발광이 일어난다 @tebyetekerwa2020mechanisms.

#figure(
  image("images/HOMOLUMO.png", width: 20em),
  caption:"Diagram of Molecular energy and HOMO/LUMO"+[@bodaghzadeh2021first]
)

이러한 과정을 더 잘 보여주기 위해 Joblonski Diagram을 사용할 수 있다. Joblonski Diagram은 물질의 전자 상태를 나타내는 에너지 준위를 나타내는 그래프로, 물질의 전자 상태가 광자에 의해 들뜬 상태로 변화하고 다시 원래 상태로 돌아가는 과정을 나타낸다. 아래 @Jablonski 에서 Joblonski Diagram을 확인할 수 있는데, 이 그래프에서는 Photoluminescence 과정인 Flourscence와 Phosphorescence가 나타나 있다.

#figure(
  image(
    "images/Jablonski diagram.png",
    width: 20em,
  ),
  caption: "Joblonski diagram for photoluminescence"+[@iyer2019study],
)<Jablonski>  

위 @Jablonski 에서도 알 수 있듯이 PL은 Fluorescence와 Phosphorescence로 나뉜다. Fluorescence는 물질이 광자를 흡수한 후 바로 빛을 방출하는 현상이며, Phosphorescence는 물질이 광자를 흡수한 후 일정 시간이 지난 후 빛을 방출하는 현상이다. 이러한 PL은 물질의 특성을 연구하는 데 중요한 도구로 사용되며, 이러한 PL을 통해 물질의 밴드 갭, 결정 구조, 결정 상태 등을 연구할 수 있다.



== Rhodamine

Rhodamine은 아래 @RhodamineStructure 과 같은 구조를 가진 물질로, 형광 물질의 일종이다. 이 물질은 아래 @RhodamineOrbital 과 같은 에너지 레벨을 가지고 있으며, 빛을 흡수하고 방출하는 Photoluminescence 과정을 수행할 수 있다. 

#figure(
  image("images/Rhodamine Structure.png", width: 20em),
  caption: "Structure of Rhodamine"+[@mallah2013study]
) <RhodamineStructure>

#figure(
  image("images/Rhodamine Orbital.png"),
  caption: "Energy Levels of Rhodamine"+[@watanabe2005dft]
) <RhodamineOrbital>

== Ruby

Ruby는 아래 @RubyStructure 과 같은 구조를 가진 물질로, Al_2O_3:Cr^3+로 알려져 있다. 이는 Cr^3+ 이온이 Al_2O_3 결정 구조 내에 삽입된 형태로 구성되어 있음을 의미한다. Ruby는 Rhodamine과 같이 빛을 흡수하고 방출하는 과정을 수행할 수 있으며, 이러한 Photoluminescence를 통해 Ruby의 밴드 갭, 결정 구조, 결정 상태 등을 연구할 수 있다. 특히 저온인 4.2K에서 Ruby의 Photoluminescence를 연구한 결과로 아래 @Ruby4.2K 의 그래프를 얻을 수 있다.

#figure(
  image("images/Ruby Structure.png", width: 20em),
  caption: "Structure of Ruby"+[@novita2019comparative]
) <RubyStructure>

#figure(
  image("images/Ruby PL 4.2K.png"),
  caption: "Energy Levels of Ruby"+[@bhardwaj2003photoluminescence]
) <Ruby4.2K>

= Experimental Methods

== Apparatus
본 실험에서 사용한 장비들의 배치 및 정렬 상태를 정리한 결과는 아래 @apparatus 와 같다.
#figure(
  image("images/Apparatus.png"),
  caption: "Apparatus for Photoluminescence Experiment"+[@manual]
) <apparatus>
본 실험에서 PL을 위해서 사용한 레이저는 532nm의 파장을 가지는 SLD-532-070T였다. 이 레이저는 SLD(Super-Luminescent Diode) 레이저로, 스펙트럼의 Linewidth가 넓으며 상대적으로 강한 출력을 가지며, 여러 파장의 빛을 가지고 있어 PL에 적합하다. \
샘플에 SLD레이저를 그대로 사용할 경우 장치가 손상될 우려가 있기 때문에 일부 빛을 차단할 필요가 있다. 이를 위해 Dichroic filter와 notch filter를 이용하여 불필요한 빛을 제거한다. 이때의 제거는 상쇄간섭 현상을 이용한다. \
PL을 명확하게 측정하기 위해서는 저온 환경이 필요한데, 이를 위해서 저온 유지 장치(Cryostat) 및 진공 게이지를 사용하도록 한다. 이때 Cryostat은 샘플을 냉각하는 역할을 하며, 진공 게이지는 챔버 내부에 진공을 잡는 역할을 수행한다. 여기서 진공을 잡는 이유는 극저온에서 물, 질소, 산소 등은 액화되어 응축하거나 흡착하는 현상으로 장비를 손상시킬 수 있기 때문이다. \
본 실험을 위해 극저온을 만들기 위해서는 헬륨 컴프레서를 통해 저온으로 내릴 필요성이 있다. 헬륨 컴프레서는 에어컨과 비슷한 원리로 작동하며 냉매로 헬륨을 사용한다. 본 실험에서 상요한 헬륨 컴프레서는 GRE사의 KDC2000F 였다@GRE2020. \
원하는 온도를 얻기 위해 온도조절 장치를 이용하는데, 본 실험에서는 Lakeshore 사의 331 temperature controller를 사용한다. \
빛의 파장별로 빛의 세기를 측정해야 하는데, 이를 위해서 빛의 파장에 따른 회절각의 차이를 이용한 단색화 장치를 사용하여야 한다. 본 실험에서 사용한 단색화 장치는 DXG사의 DM500i였으며, grating은 1200gr/mm로 설정하였다. \
이렇게 얻은 광학 이미지를 전자 신호로 변환하기 위해 사용한 센서는 CCD로, 본 실험에서는 Andor 사의 DU401A-BVF를 사용하였다. 해당 장비의 스펙은 26µm $times$ 26µm의 픽셀 크기로, 가로 1024, 세로 127의 픽셀들을 가지고 있었고, Dark current는 $-40^o$C에서 0.003 electron/pix/sec 로 주어졌다.\
마지막으로, 진공을 뽑기 위해 사용한 펌프는 로터리 펌프로, 본 실험에서 챔버의 온도가 200K 이하에 도달한 경우에는 펌프 내의 오일이 역류하여 장비를 손상시킬 수 있으므로 챔버의 밸브를 잠궈 주어야 했다. \
모든 PL 실험에서는 측정을 두 번 진행하여 데이터를 얻는다. 우선 Background를 레이저 빔이 없는 상태로 측정한다. 이는 레이저 빔 때문이 아닌 다른 빛에 의한 PL Spectrum을 제거하는 목적을 가진다. 그 뒤, 레이저 빔이 켜진 상태로 측정한다. 두 측정 사이에는 약간의 시간 간격이 필요하다. 이렇게 얻은 두 데이터를 서로 빼 주어 실제 데이터인 reference를 얻도록 한다. 본 실험에서 사용한 모든 데이터는 reference의 값만을 사용하였다. \

== Rhodamine at Room Temperature

로다민 액체 시료는 로다민 590을 에틸렌 글리콜에 녹인 것을 사용하였다. 레이저 빔이 로다민 590 시료를 통해 장치에 들어가도록 배열한 뒤, 프로그램에서 중심파장을 567nm로 설정한 채로 실험을 진행하였다. 기본적인 실험에서는 Exposure time을 0.1초로 설장하고 Accumulation을 1회만 진행하였다. 이후에 오차가 적은 실험을 위해 메뉴얼에서 권장한 최대 정확도인 Exposure time을 0.5초로 설정하고 Accumulation을 20회로 설정하여 실험을 진행하였다. 

== Ruby at Room Temperature

레이저, 렌즈 등이 정렬되어 있기 때문에, 로다민 590을 치우고 중심파장을 690nm로 세팅한 뒤에 측정을 진행한다. 여기서 압력에 따른 변화가 있다고 보기 어렵기 때문에 압력을 조절하지 않고 실험을 진행하였다.

== Ruby at Various Temperatures

우선 진공 펌프를 이용해 진공 상태로 만든다. 이때의 압력은 10mTorr이하가 되도록 한다. 그뒤 헬륨 컴프레셔를 이용해 온도를 천천히 내리며, 대략 10K까지 낮출 수 있도록 한다. 이후, 온도 조절기를 이용하여 온도를 조금씩 올리며, 각 온도에서 안정화 될 수 있게 기다린 뒤 데이터를 얻었다. 이때의 온도는 10K부터 시작하여 270K까지 10K단위로 모두 측정하도록 한다. 여기서 히터의 설정 온도가 200K을 넘을 때는 컴프레서를 끄도록 했다. 

= Results

== Rhodamine at Room Temperature

Rhodamine590을 567nm의 중심파장을 가지는 레이저를 이용하여 조사한 경우에 대한 결과를 아래 @RhodamineRT 와 @RhodamineRTNoise 에서 확인할 수 있다. 아래 그래프들은 서로 다른 환경에서 측정한 결과로, @RhodamineRT 는 노이즈가 적은 환경을 조성하여 측정한 결과이며, @RhodamineRTNoise 는 일반적인 환경에서 측정한 결과이다. 두 환경의 차이는 아래 SectionIV-A에서 다루어진다. 

#figure(
  image("images/Rhodamine.png"),
  caption: "Rhodamine PL at Room Temperature"
) <RhodamineRT>

#figure(
  image("images/Rhodamine_Noise.png"),
  caption: "Rhodamine PL at Room Temperature with Noise"
) <RhodamineRTNoise>

위의 두 그래프들은 모두 Double Gaussian을 통해 회귀한 결과로, 각각의 그래프 모두 두 개의 피크가 합쳐진 결과임을 알 수 있고, 모두 낮은 error를 가지고 있음을 확인할 수 있다. 두 개의 피크는 각각 대략적으로 2.14eV와 2.21eV 정도로 나타났으며, 거의 유사한 높이를 가지고 있음을 확인할 수 있다.

== Ruby at Room Temperature

고체 시료인 루비에 대해서도 상온에서 PL을 조사할 수 있다. 아래 @RubyRT 에서 확인할 수 있는 그래프와 같이 두 개의 피크가 나타나는 것을 확인할 수 있으며, 해당 피크들을 제외한 영역에서는 유의미한 데이터가 나타나지 않음을 알 수 있다. 따라서 더 상세한 묘사를 위해 두 피크가 포함된 작은 영역으로 잘라내었다. 이때의 영역은 파장이 690nm에서 695nm인 영역이었다. 이렇게 잘라낸 그래프는 @RubyRT_cut 과 같이 나타났다. 보다 정확한 분석을 위해 본 그래프가 double lorentzian이라고 추정하여 bimodal fit을 수행하였다. 이 과정에서 PyTorch의 Adam 함수를 사용하였으며@kingma2014adam, @RubyRT_fit 에서 나타난 바와 같이 RMSE(Root Mean Square Error)가 22[a.u.]로 나타나 상당히 정확한 것을 확인할 수 있다.

#figure(
  image("images/RT_raw.png"),
  caption: "Ruby PL at Room Temperature"
) <RubyRT>

#figure(
  image("images/RT_cut.png"),
  caption: "Ruby PL at Room Temperature only between 690nm and 695nm"
) <RubyRT_cut>

#figure(
  image("images/RT_fit.png"),
  caption: "Ruby PL at Room Temperature with Bimodal Fit on double Lorentzian function with RMSE 22[a.u.]"
) <RubyRT_fit>

== Ruby at Various Temperatures

본 실험에서는 루비의 PL을 극저온인 10K에서 시작하여 270K까지 10K단위로 상승시키며 측정하였다. 이때 모든 실험에서 Peak는 위의 @RubyRT 에서와 같이 690nm에서 695nm 사이에서만 유의미한 결과가 나타났으며, 모든 그래프가 Double Lorentzian에 잘 들어맞는 형태를 가지고 있음을 확인할 수 있었다. 따라서 690nm와 695nm 사이의 데이터만 잘라내어 분석을 진행하였으며, 모두 Double Lorentzian을 사용하도록 하였다. 이때의 결과 중 대표적으로 네 개의 그래프를 뽑았으며, 아래 @Ruby10K, @Ruby100K, @Ruby200K, @Ruby270K 에서 확인할 수 있다.

#figure(
  image("images/10K.png"),
  caption: "Ruby PL at 10K"
) <Ruby10K>
#figure(
  image("images/100K.png"),
  caption: "Ruby PL at 100K"
) <Ruby100K>
#figure(
  image("images/200K.png"),
  caption: "Ruby PL at 200K"
) <Ruby200K>
#figure(
  image("images/270K.png"),
  caption: "Ruby PL at 270K"
) <Ruby270K>

= Discussion

== Rhodamine at Room Temperature <RhodamineDiscussion>

로다민 시료를 사용하여 광발광 스펙트럼을 @RhodamineRT 와 @RhodamineRTNoise 와 같이 얻었다. 여기서 실험 방법에서 언급한 바와 같이 @RhodamineRTNoise 에서는 일반적인 실험 방법일 Exposure time 0.1초와 Accumulation 1회의 세팅을 이용하였으나, 해당 그래프에서 확인할 수 있듯이 큰 노이즈가 발생하였다. 이에 @RhodamineRT 에서는 Exposure Time을 5배 큰 0.5초로 설정하고 Accumulation을 20회로 설정하여 실험을 진행하였다. 이때의 결과는 노이즈가 적은 결과를 얻을 수 있었으며, 이를 통해 더 정확한 결과를 얻을 수 있었다. 이러한 결과는 실험을 진행할 때 노이즈를 최소화하는 것이 중요함을 보여준다. \
이론 파트에서 알 수 있듯이 로다민 590은 HOMO와 LUMO 사이의 밴드 갭을 가지고 있는데 이때의 Peak는 두 개가 나타나는 것으로 보인다. 이를 토대로 Double Gaussian Fitting을 진행하였다. \
다만, 위 가정을 검증하기 위해 Single Gaussan Fitting과 Double Gaussian Fitting을 둘다 진행하여 비교하였다.
#figure(
  image("images/Rhodamine Single Gaussian.png"),
  caption: "Single Gaussian Fitting of Rhodamine PL at Room Temperature"
) <RhodamineSingleGaussian>

#figure(
  image("images/Rhodamine.png"),
  caption: "Double Gaussian Fitting of Rhodamine PL at Room Temperature"
) <RhodamineDoubleGaussian>

위 @RhodamineSingleGaussian 에서 확인할 수 있듯이 Single Gaussian Fitting을 진행한 결과, RMSE가 123[a.u.]로 나타나 Double Gaussian Fitting에 비해 상당히 높은 값을 가지고 있음을 확인할 수 있다. 또한, 전체적인 그래프의 개형이 Single Gaussian Fitting보다 실험 데이터에 잘 맞는 것을 확인할 수 있다. 따라서 Double Gaussian Fitting이 더 적합한 결과를 제공함을 확인할 수 있다. \
이러한 결과를 토대로 로다민 590의 PL은 HOMO와 LUMO 사이의 밴드 갭을 가지고 있으며, 이를 통해 두 개의 Peak가 나타나는 것으로 보인다. 이때의 Peak는 각각 대략적으로 2.14eV와 2.21eV 정도로 나타났으며, 거의 유사한 높이를 가지고 있음을 확인할 수 있다. 또한, 각 Peak의 FWHM은 각각 0.20eV와 0.13eV로 나타났으며, 이는 두 Peak 사이의 거리가 대략 0.07eV인 것으로 미루어 보았을 때에 두 Peak는 실험 결과에서 확인할 수 있듯이 서로 분해되지 않는다는 것을 확인할 수 있다. \

== Ruby at Room Temperature

상온에서 루비의 PL은 위의 @RubyRT_fit 에서와 같이 나타났다. 여기서의 Fitting은 Double Lorentzian으로 진행되었다. 이때의 결과는 RMSE가 22[a.u.]로 나타나 상당히 정확한 것을 확인할 수 있다. 두 Peak는 각각 1.789eV와 1.792eV에서 발견되었으며, 각각의 FWHM은 0.001eV와 0.0008eV로 확인되었다. 이러한 결과를 토대로 Rhodamine 590과는 다르게 두 개의 Peak가 잘 구분되는 것을 알 수 있다. 다만, 피크가 이보다 더 많다고 한다면 각 피크의 FWHM 내에 함께 섞여 있거나 Peak의 높이가 매우 낮아 드러나지 않은 경우라고 보아야 한다. 그러나 본 그래프에서 Double Lorentzian에 매우매우 적합한 결과를 얻었기 때문에, 이러한 경우는 발생하지 않았다고 볼 수 있다. 또한, Ruby의 Peak 자체가 두 개인 것으로 알려져 있기 때문에 @sans2016arsenolite @aizawa2021communication 실험이 잘 진행된 것을 확인할 수 있다. 마지막으로 두 피크의 세기 비율은 0.58로 나타났는데, 이는 Rhodamine 590의 비율이었던 1.32보다 더 치우친 결과로 볼 수 있다. 

== Ruby at Various Temperatures

본 섹션에서는 루비의 PL 스펙트럼에서 나타나는 두 개의 Peak가 가지는 물리량들을 온도에 따라 하나씩 정리하여 설명하도록 한다. 여기서 정리한 물리량으로는 Peak의 Centre Energy, FWHM, Peak의 높이, Peak의 넓이, Peak의 넓이 비율, 그리고 이를 통해 계산한 온도 등이 있다.

=== Error

#figure(
  image("images/Error.png"),
  caption: "Error of Fitting at Various Temperatures"
) <Error>

위 @Error 의 그래프는 온도에 따른 Fitting에서의 RMSE를 계산하여 그래프로 나타낸 결과이다. 온도가 상승함에 따라서 RMSE를 계산하여 그린 결과이다. 온도가 높아질수록 점점 Double Lorentzian fit이 좋은 결과를 보여줌을 확인할 수 있다. 이는 여러 원인이 있겠지만 낮은 온도에서는 애초에 Peak의 높이가 낮은 동시에 Width가 매우 작아 Noise에 대한 민감도가 높아지는 효과가 있다. 이 때문에 Lorentzian의 굴곡이 사라지는 것이 그래프에서도 나타났으며, Peak 자체는 잘 측정되더라도 Peak를 벗어난 비교적 낮은 데이터에서는 오차가 커지는 현상이 발생할 것을 예측할 수 있다. 이에 측정 오차가 위 오차의 원인일 것으로 예상해 볼 수 있으며, 전체적으로 매우 작은 값을 띈다는 것을 확인할 수 있다.

=== Centre Energy

루비 시료의 PL Peak 위치는 온도에 의존하여 변화하게 된다. 여기서 온도에 따른 에너지 $eps(T)$는 $T_D$가 Debye Temperature일때 다음과 같이 나타내진다 @tsoi2009high. 
$
eps(T) = eps(0) + alpha (T/T_D)^4 
integral _0^(T/T_D) (x^3 e^x)/(e^x-1)^2d x
$
여기서 루비의 Debye Temperature는 760K으로 알려져 있다 @mccumber1963linewidth. 이를 토대로 실험 결과를 분석하는 것이 바람직할 것이나, 아래 실험 결과는 후술할 사유에 의해 위 식으로 Fitting이 불가능한 상황이 되었다. 실제로 fit을 진행할 경우에 개형이 올바르지 않게 나타난다. 이 현상은 이후 Ratio에 대해서 기술하는 단게에서 더 잘 나타나기에 해당 섹션에서 설명하도록 한다.

#figure(
  image("images/Centre.png"),
  caption: "Centre Energy of Peaks at Various Temperatures"
) <Centre>

위 @Centre 와 같이 각 Peak의 위치는 온도가 상승함에 따라 감소하는 경향성을 띄고 있고, 온도에 대해 concave한 것을 확인할 수 있다. 또, 두 Peak의 상대적 위치가 거의 일정하다는 것을 확인할 수 있는데, 이는 위에서 주어진 식에서도 각 peak의 위치에 대한 의존성이 온도에 의존하는 항에 없다는 것으로부터 유추할 수 있으며, 해당 식에 대한 검증이 어느 정도는 이루어진다고 볼 수 있다. 이를 더 명확하게 알아보기 위해 Peak 사이의 거리를 계산하였다. 이는 @Distance 와 같이 매우 일정하게 나타나며, 이로부터 두 Peak 사이 에너지 차이는 항상 0.0038eV 정도로 일정하다는 것을 확인할 수 있다.

#figure(
  image("images/Distance.png"),
  caption: "Distance between Peaks at Various Temperatures"
) <Distance>

=== FWHM

루비의 PL 스펙트럼이 가지는 FWHM은 온도에 대한 의존성을 가진다. 이러한 온도에 대한 의존성은 온도가 상승함에 따라 FWHM이 증가하는 경향성을 띄고 있음을 확인할 수 있다. 이는 온도가 상승함에 따라 Band 주위로 상태가 이동하는 경우가 더 많이 발생하는 것을 나타낸다. 이러한 현상을 이론적으로 설명하여 온도에 따른 FWHM의 변화를 계산하면 Linewidth가 $Delta(T)$일때 $T_D$가 루비의 Debye Temperature인 760K라면 아래와 같이 계산됨이 알려져 있다 @mccumber1963linewidth.
$
Delta(T) = Delta(0) + alpha(T/T_D)^7 integral_0^(T/T_D) (x^6 e^x)/(e^x-1)^2d x
$
이 식을 이용하여 아래 @FWHM 을 피팅해 보기 위한 시도를 진행하였다. 이러한 시도는 @FWHMFIT 에서 나타난다. 그러나 본 Fitting은 본질적인 개형의 오류로 인해서 들어맞지 않는 것으로 나타났다. 이러한 현상이 발생한 이유로는 온도 조절 장치가 온도를 일정하게 유지하지 못하여 각 실험에서 온도가 증가한 비율이 올바르지 않게 나타나는 것으로 추정된다. 이러한 이유로 인해 온도에 따른 FWHM의 변화를 정량적으로 추론하는 데에는 어려움이 있고, 온도가 상승한다는 경향성은 유지되어 있기 때문에 전체적인 경향성과 개형으로는 이론적으로 나타나야 하는 것과 동일하게 나타난 것을 확인할 수 있다.
#figure(
  image("images/FWHM.png"),
  caption: "Full Width at Half Maximum of Peaks at Various Temperatures"
) <FWHM>
#figure(
  image("images/FWHM_Fit.png"),
  caption: "Full Width at Half Maximum of Peaks at Various Temperatures with Fitting"
) <FWHMFIT>


=== Peaks

두 피크의 온도의 변화에 따른 피크 높이를 기술한 그래프는 아래 @Peak 와 같이 나타난다. 이 그래프에서 확인할 수 있듯이, 두 번째 피크는 온도가 상승함에 따라 높이가 줄어들고 첫 번째 피크는 온도가 상승함에 따라 높이가 늘어난다. 또, 두 피크 높이의 합은 점차 줄어드는데, 이 현상은 FWHM이 커지면서 Lorentzian에서는 Peak의 높이와 FWHM의 곱에 비례하게 넓이가 기술되며 두 Peak의 넓이의 합은 에너지기에 대략적으로 일정하게 유지되어야 하므로 점차 감소하고 있음을 알 수 있다. 또한, 온도가 상승함에 따라 두 피크의 높이가 매우 비슷해지는 방향으로 움직이는 것을 확인할 수 있다.

#figure(
  image("images/Peak.png"),
  caption: "Peaks at Various Temperatures"
) <Peak>

=== Areas

여기서는 두 Peak의 그래프가 만드는 넓이의 값을 비교하도록 한다. 이를 그래프로 나타낸 결과는 아래 @Area 와 같이 나타난다. 아래 그래프와 같이 두 번째 피크는 온도가 변함에 따라 면적이 거의 일정하게 유지되지만 두 번째 피크는 점차 증가하다가 일정해 지는 것을 확인할 수 있다. 이는 두 Peak의 넓이 비율이 점차 증가하다가 일정해지는 것을 확인할 수 있다. 이러한 비율에 대한 논의는 아래 Ratio와 관련된 파트에서 더 자세하게 서술하도록 한다.

#figure(
  image("images/Area.png"),
  caption: "Areas at Various Temperatures"
) <Area>

=== Ratio

본 실험에서는 루비가 가지고 있는 두 개의 Peak가 온도가 변화함에 따라 어떻게 변화하는지를 측정해 보았다. 여기서는 두 Peak의 넓이 비를 측정하도록 한다. 여기서 넓이 비는 해당 피크가 가지는 Intensity의 비율을 의미하며, 이는 볼츠만 분포를 따른다. 따라서 이 비율은 $exp(-(Delta E)/(k_B T))$와 비례하게 나타날 것을 알 수 있다.

#figure(
  image("images/Ratio.png"),
  caption: "Ratio of Areas at Various Temperatures"
) <Ratio>

본 실험에서 측정한 면적의 비율은 위 @Ratio 와 같이 나타났다. 위 그래프에서는 대략 150K부터는 일정한 넓이 비를 유지하는 것을 확인할 수 있으며, 이는 볼츠만 분포에서의 비례 상수를 보여주는 것으로 생각할 수 있다. 따라서 이를 토대로 온도에 따른 분포를 생각해 볼 수 있을 것이다. 또, 위의 @Distance 에서 두 피크 사이의 에너지 차이가 일정하다는 것을 알 수 있었는데, 이로부터 볼츠만 분포에서의 에너지 비율을 알 수 있다. 이를 토대로 expoential fit을 진행한 결과는 아래 @RatioFit 에서 나타났다.

#figure(
  image("images/Ratio_Fit.png"),
  caption: "Ratio of Areas at Various Temperatures with Fitting"
) <RatioFit>

위 @RatioFit 에서 알 수 있듯이 Ratio의 그래프는 볼츠만 분포를 따르지 않는다. 그러나 볼츠만 분포는 온도의 정의와 밀접하게 연관되어 있는 것이기도 하기에 각 시점에 넓이 비는 해당 시점의 온도를 나타낸다고 생각할 수 있다. 이를 토대로 실제로는 온도 조절 장치가 제대로 온도를 조절하지 못한 것으로 예상해 볼 수 있다. 또, 본 실험에서 측정한 온도는 온도 센서의 온도로 루비 전체의 온도와는 괴리가 있을 수 있다. 여기서의 평형을 위한 안정화를 진행하였지만, 온도 센서로부터는 안정화 여부에 대한 지표를 얻을 수 없을 뿐더러 온도 조절 장치가 작동하는 과정에서 상당히 느린 속도로 온도가 상승한 것을 확인할 수 있었기에 온도 조절 장치나 온도센서가 제대로 작동하지 못했다고 추정할 수 있다. 따라서 각 시점에서의 온도를 Ratio를 통해서 볼츠만 분포를 이용해 계산해 보는 과정을 아래 @Temperature 에서 진행하였다.

#figure(
  image("images/Calculating Temperature.png"),
  caption: "Calculated Temperature of Ruby with Ratio of Areas"
) <Temperature>

위 @Temperature 는 Intensity 비율을 이용하여 온도를 계산해 본 결과로, 온도가 50K까지는 잘 들어맞지만 이후부터 온도가 급격하게 상승하며 온전히 맞지 않아지는 것을 확인할 수 있었다. 각 온도에서 계산한 온도의 개형을 보았을 때 지수함수의 형태를 띄고 있어 expoential fit을 진행해 보았는데 상당히 잘 맞았음을 확인할 수 있었다. 이는 온도 조절 장치가 제대로 작동하지 못했음에 따라 발생한 현상이기 때문에 온전히 올바른 분석을 진행할 수는 없지만, 온도 조절 장치가 "Low"가 아닌 상태로 진행되는 경우에 온도가 올바르게 조절되지 않은 것으로 생각한다. 따라서 이러한 결과는 실험의 한계로 인한 것으로 생각할 수 있다.

= Conclusion

본 실험에서는 액체 시료인 로다민 590과 고체 시료인 루비에 대해 Photoluminescence 실험을 진행했다. 두 실험 모두에서 두 개의 Peak가 나타났으나 로다민 590에서는 두 피크가 모두 넓어 서로 구분 불가능하게 있었고, 루비에 대해서는 두 피크가 명확하게 나타났다. 이후 루비에 대해서는 온도에 따른 실험을 진행했으며, 온도에 변화에 따른 물리량들의 변화의 개형은 잘 알려진 것과 유사하게 나타났으나 실제로 정량적인 계산을 수행한 결과 잘 맞지 않음이 나타났다. 두 Peak의 Intensity 비율을 통하여 온도의 추정을 해 보았을 때에 실험을 진행하는 과정에서 온도 조절 장치가 올바르게 작동하지 못했음으로 추정된다. 따라서 이를 보완한 뒤에 더 상세한 실험을 진행하여야 할 것으로 보인다.

#bibliography("reference.bib", full:true, style: "american-physics-society")