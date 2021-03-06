(* ::Package:: *)

Get["https://raw.githubusercontent.com/jkuczm/MathematicaBootstrapInstaller/v0.1.1/BootstrapInstaller.m"]


BootstrapInstall[
	"SyntaxAnnotations",
	"https://github.com/dih5/PhysDataFetch/releases/download/v0.1.0/PhysDataFetch.zip",
	"AdditionalFailureMessage" ->
		Sequence[
			"You can ",
			Hyperlink[
				"install the PhysDataFetch package manually",
				"https://github.com/dih5/PhysDataFetch#manual-installation"
			],
			"."
		]
]