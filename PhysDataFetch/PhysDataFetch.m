(* Mathematica Package *)

(* Created by the Wolfram Workbench Nov 13, 2015 *)

BeginPackage["PhysDataFetch`"]
(* Exported symbols added here with SymbolName::usage *) 
ESTARData::usage="ESTARData[el] returns the data of the selected element fetched from ESTAR database.";
PSTARData::usage="PSTARData[el] returns the data of the selected element fetched from PSTAR database.";
ASTARData::usage="ASTARData[el] returns the data of the selected element fetched from ASTAR database.";
TableFormed::usage="TableFormed is an option for PhysDataFetch that specifies whether to give data in TableForm or raw.";

SeparateBorder::usage="SeparateBorder is an option for PhysDataFetch that specifies whether to avoid multivalation of the coefficient in the borders.";
XRayData::usage="XRayData[Z] returns the data of the selected element fetched from the x-ray mass attenuation coefficient database.";
Begin["`Private`"]
(* Implementation of the package *)

FetchESTARData[elId_String] := FetchEstarData[elId]=
 Block[{txt}, 
  txt = URLFetch["http://physics.nist.gov/cgi-bin/Star/e_table-t.pl", 
    "Parameters" -> {"matno" -> elId, "ShowDefault" -> "on"}, 
    "Method" -> 
     "POST"]; (Internal`StringToDouble /@ 
      StringSplit[#, Whitespace] &) /@ 
   Select[Take[
     StringSplit[StringSplit[txt, "<hr>"][[1]], "<br>"][[11 ;; -1]]], 
    Not[StringMatchQ[#, Whitespace]] &]]
    
FetchPSTARData[elId_String] := 
 Block[{txt}, 
  txt = URLFetch["http://physics.nist.gov/cgi-bin/Star/ap_table-t.pl",
     "Parameters" -> {"matno" -> elId, "ShowDefault" -> "on", 
      "prog" -> "PSTAR"}, 
    "Method" -> 
     "POST"]; (Internal`StringToDouble /@ 
      StringSplit[#, Whitespace] &) /@ 
   Select[Take[
     StringSplit[StringSplit[txt, "<hr>"][[1]], "<br>"][[15 ;; -2]]], 
    Not[StringMatchQ[#, Whitespace]] &]]
    
FetchASTARData[elId_String] := 
 Block[{txt}, 
  txt = URLFetch["http://physics.nist.gov/cgi-bin/Star/ap_table-t.pl",
     "Parameters" -> {"matno" -> elId, "ShowDefault" -> "on", 
      "prog" -> "ASTAR"}, 
    "Method" -> 
     "POST"]; (Internal`StringToDouble /@ 
      StringSplit[#, Whitespace] &) /@ 
   Select[Take[
     StringSplit[StringSplit[txt, "<hr>"][[1]], "<br>"][[15 ;; -2]]], 
    Not[StringMatchQ[#, Whitespace]] &]]

Options[ESTARData] = {TableFormed->False};
Options[PSTARData] = {TableFormed->False};
Options[ASTARData] = {TableFormed->False};

ESTARHeader={None, {"Kinetic en.\nMeV", 
   "Coll Stop. P.\n(MeV cm2/g)", "Rad Stop. P.\n(MeV cm2/g)", 
   "Tot Stop. P.\n(MeV cm2/g)", "CSDA r\ng/cm2", "Rad yield", 
   "Den. Eff."}};
PSTARHeader={None, {"Kinetic en.\nMeV", 
   "Electronic Stop. P.\n(MeV cm2/g)", "Nuclear Stop. P.\n(MeV cm2/g)", 
   "Tot Stop. P.\n(MeV cm2/g)", "CSDA r\ng/cm2", "Projected r\ng/cm2", 
   "Detour factor\n(proj./CSDA)"}};
ASTARHeader={None, {"Kinetic en.\nMeV", 
   "Electronic Stop. P.\n(MeV cm2/g)", "Nuclear Stop. P.\n(MeV cm2/g)", 
   "Tot Stop. P.\n(MeV cm2/g)", "CSDA r\ng/cm2", "Projected r\ng/cm2", 
   "Detour factor\n(proj./CSDA)"}};
   
ESTARData[elId_,opts : OptionsPattern[]]:=Block[{data},data=Quiet[FetchESTARData[ToString[elId]],{ImportString::bkslsh}];
	If[OptionValue[TableFormed]===True,TableForm[data,TableHeadings -> ESTARHeader],data]
	]
PSTARData[elId_,opts : OptionsPattern[]]:=Block[{data},data=Quiet[FetchPSTARData[ToString[elId]],{ImportString::bkslsh}];
	If[OptionValue[TableFormed]===True,TableForm[data,TableHeadings -> PSTARHeader],data]
	]
ASTARData[elId_,opts : OptionsPattern[]]:=Block[{data},data=Quiet[FetchASTARData[ToString[elId]],{ImportString::bkslsh}];
	If[OptionValue[TableFormed]===True,TableForm[data,TableHeadings -> ASTARHeader],data]
	]



XRayDataFetch[Z_Integer] := XRayDataFetchEl[If[Z < 10, "0" <> ToString[Z], ToString[Z]]]
XRayDataFetch[s_String] := If[StringMatchQ[s,DigitCharacter..],XRayDataFetchEl[s],XRayDataFetchComp[s]]


(*Fetch elemental media*)
(*DeleteCases is needed due to an exceptional format in Z=4*)
XRayDataFetchEl[Z_String] := 
XRayDataFetchEl[Z]=
 Map[Internal`StringToDouble, 
  StringSplit[#, Whitespace][[-3 ;; -1]] & /@ 
   DeleteCases[
    StringSplit[
     StringSplit[
       StringSplit[
         StringSplit[
           URLFetch[
            "http://physics.nist.gov/PhysRefData/XrayMassCoef/ElemTab/\
z" <> Z <> ".html"], "</DIV>"][[3]], "________" ~~ "_" ..][[3]], 
       "</PRE>"][[1]], "\n"], " "], {2}]

(*Fetch compoiund and mixtures*)
XRayDataFetchComp[medium_String] := 
XRayDataFetchComp[medium]=
 Map[Internal`StringToDouble, 
  StringSplit[#, Whitespace][[-3 ;; -1]] & /@ 
   DeleteCases[
    StringSplit[
     StringSplit[
       StringSplit[
         StringSplit[
           URLFetch[
            "http://physics.nist.gov/PhysRefData/XrayMassCoef/ComTab/\
" <> medium <> ".html"], "</DIV>"][[3]], "________" ~~ "_" ..][[3]], 
       "</PRE>"][[1]], "\n"], " "], {2}]

(*Function to avoid multivalation of the coefficient in the borders*)
ResolveDiscontinuities[table_, eps_: 0.00000001] := 
 Block[{pEps, t2, p}, t2 = table; pEps = Table[0, {Length[table[[1]]]}];
  pEps[[1]] = eps;
  p = Position[Differences[table[[All, 1]]], 0.][[All, 1]];
  t2[[p]] = # - pEps & /@ table[[p]];
  t2[[p + 1]] = # + pEps & /@ table[[p + 1]];
  t2]
  
XRayHeader={None, {"Energy (MeV)", 
  "\[Mu]/\[Rho] (\!\(\*SuperscriptBox[\(cm\), \(2\)]\)/g)", 
  "\!\(\*SubscriptBox[\(\[Mu]\), \(en\)]\)/\[Rho] \
(\!\(\*SuperscriptBox[\(cm\), \(2\)]\)/g)"}};
  
Options[XRayData] = {TableFormed->False,SeparateBorder->False};
XRayData[Z_,opts : OptionsPattern[]]:=Block[{data},data=Quiet[XRayDataFetch[Z],{ImportString::bkslsh}];
If[OptionValue[SeparateBorder]===True,data=ResolveDiscontinuities[data]];
If[OptionValue[TableFormed]===True,TableForm[data,TableHeadings -> XRayHeader],data]
]

  

End[]

EndPackage[]

