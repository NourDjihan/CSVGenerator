"
I am a class responsible for extracting data from the getters of objects and exporting the information into a CSV file.
These objects must only be responsible for containing information and not processing them.
"
Class {
	#name : #CSVGenerator,
	#superclass : #Object,
	#instVars : [
		'model'
	],
	#category : #'CSVGenerator-Core'
}

{ #category : #'instance creation' }
CSVGenerator class >> of: analysisDescription [

	^ (self new 
		model: analysisDescription)
]

{ #category : #generating }
CSVGenerator >> generateAll: objectsOfInformation to: aPath [ 

	| data headers |
	model := objectsOfInformation first.
	headers := self getHeaders.
	data := OrderedCollection new.
	data := objectsOfInformation collect: [ :each | self model: each. self getData ].

	aPath 
		asFileReference writeStreamDo: [ :writeStream | 
			(NeoCSVWriter on: writeStream) 
				writeHeader: headers; 
				nextPutAll: data ]
	
]

{ #category : #generating }
CSVGenerator >> generateTo: aPath [

	| data headers |
	data := self getData.
	headers := self getHeaders.
	aPath 
		asFileReference writeStreamDo: [ :writeStream | 
			(NeoCSVWriter on: writeStream) 
				writeHeader: headers; 
				nextPut: data ]
]

{ #category : #accessing }
CSVGenerator >> getData [ 

	^ ((model class allSlots collect: #name) collect: [ :method | model perform: method ]) asArray.
]

{ #category : #accessing }
CSVGenerator >> getHeaders [ 	

	^ (model class allSlots collect: #name) asArray
]

{ #category : #accessing }
CSVGenerator >> model [ 
	^ model
]

{ #category : #accessing }
CSVGenerator >> model: anObjectOfInformation [ 

	model := anObjectOfInformation
]
