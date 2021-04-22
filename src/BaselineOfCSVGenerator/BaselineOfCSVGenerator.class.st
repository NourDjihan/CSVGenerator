"
I am the baseline of the CSVGenerator projects.
"
Class {
	#name : #BaselineOfCSVGenerator,
	#superclass : #Object,
	#category : #BaselineOfCSVGenerator
}

{ #category : #baselines }
BaselineOfCSVGenerator >> baseline: spec [
	<baseline>

	spec for: #'common' do: [
		"External dependencies"
		self loadNeoCSV: spec.
		"Packages"
		spec 
			package: #'CSVGenerator-Core';
			package: #'CSVGenerator-Tests' with: [ spec requires: #(''CSV-Core'') ]
				]
]

{ #category : #'as yet unclassified' }
BaselineOfCSVGenerator >> loadNeoCSV: spec [ 
	
	spec baseline: 'NeoCSV' 
			with: [ spec repository: 'github://svenvc/NeoCSV/repository' ].
]
