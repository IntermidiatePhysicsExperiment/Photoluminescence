#import "template.typ": *
#import "@preview/tablex:0.0.8": *
#let th=[#math.theta]
#let ll=[#sym.angle.l]
#let rr=[#sym.angle.r]
#let times="×"
#show: project.with(
  title: "Single Photon Interference",
  authors: (
    (name: "Seunghyun Moon", email: "shmoon232@snu.ac.kr", affiliation: "Department of Physics and Astronomy, Seoul National University,\nSeoul, 08826 South Korea"),
  ),
  abstract: ""+"\n"+text(weight: "bold")[Keywords: ]
  +"",
  date: "June 4, 2024",
)

= Introduction

== Photoluminescence

광발광(Photoluminescence, PL)은 물질이 광자를 흡수한 후 빛이 발생하는 현상으로, 물질 내 원자나 분자에 묶인 전자의 에너지 상태가 광자로 인해 들뜬 상태가 되었다가 다시 돌아가며 빛의 형태로 에너지를 방출하는 과정이다. 


= Experimental Methods

== Apparatus

== Rhodamine at Room Temperature

== Ruby at Room Temperature

== Ruby at Various Temperatures

= Results

== Rhodamine at Room Temperature

== Ruby at Room Temperature

== Ruby at Various Temperatures

= Discussion

== Rhodamine at Room Temperature

== Ruby at Room Temperature

== Ruby at Various Temperatures

= Conclusion

#bibliography("reference.bib", full:true, style: "american-physics-society")