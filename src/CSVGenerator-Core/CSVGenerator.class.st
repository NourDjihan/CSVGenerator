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
CSVGenerator class >> of: anObject [

	^ (self new 
		model: anObject)
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
				nextPutAll: data ].
			
	  UIManager default
            inform: 'Data exported.
				Click to show in folder'
            actionOnClick: [ aPath asFileReference openInOSFileBrowser ]
	
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
				nextPut: data ].
			
		  UIManager default
            inform: 'Data exported.
				Click to show in folder'
            actionOnClick: [ aPath asFileReference openInOSFileBrowser ]
]

{ #category : #accessing }
CSVGenerator >> getData [

	^ (model class selectors collect: [ :selector | 
		   model perform: selector ]) asOrderedCollection 
]

{ #category : #accessing }
CSVGenerator >> getHeaders [

	^ model class selectors asOrderedCollection 
]

{ #category : #accessing }
CSVGenerator >> model [ 
	^ model
]

{ #category : #accessing }
CSVGenerator >> model: anObjectOfInformation [ 

	model := anObjectOfInformation
]
