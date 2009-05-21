<!--- Create Mock Box --->
<cfset mockBox = createObject("component","coldbox.system.testing.MockBox").init()>
<!--- Create a mock based on Test CFC --->
<cfset Test = mockBox.createMock("coldbox.testing.cases.testing.Test")>

<cfoutput>
<!--- MOCKING REAL METHODS --->
<h1>Mocking Methods</h1>
Normal Test.getData() = #test.getData()#<br />
NOT MOCKED: Method called #test.$count("getData")# times<br />
<cfset test.mockMethod("getData",1000)>
Mock Method called #test.mockMethodCallCount("getData")# times<br />
Mocked Test.getData() = #test.getData()#<br />
Mocked Test.getData() = #test.getData()#<br />
Mock Method called #test.mockMethodCallCount("getData")# times

<!--- Mock Real Methods with Concatenation --->
<cfset test.$("getData").mockResults(1000)>
Mock Method called #test.mockMethodCallCount("getData")# times<br />
Mocked Test.getData() = #test.getData()#<br />
Mocked Test.getData() = #test.getData()#<br />
Mock Method called #test.mockMethodCallCount("getData")# times

<hr />
<!--- MOCKING VIRUTAL METHODS --->
<h1>Mocking Virtual Methods</h1>
We will add a virtual method called <strong>virtualReturn</strong>
<cfset test.mockMethod("virtualReturn").mockResults('Virtual Called Baby!!')>
Virtual Method called #test.mockMethodCallCount("virtualReturn")# times<br />
Virtual Test.virtualReturn() = #test.virtualReturn()#<br />
Virtual Method called #test.mockMethodCallCount("virtualReturn")# times

<hr />
<!--- MOCKING PROPERTIES --->
<h1>Mocking Properties</h1>
Original Reload property value: #test.getReload()#<br />
<cfset test.$property(propertyName="reload",mock=true,scope="variables")>
Mocked Reload Property value:  #test.getReload()#<br />

<hr />
<!--- MOCKING PRIVATE METHODS --->
<h1>Mocking Private Methods</h1>
Normal Test.getFullName() = #test.getFullName()#<br />
<cfset test.mockMethod("getName","My Mock Name")>
Mocked Test.getFullName() = #test.getFullName()#<br />

<hr />
<!--- STATE MACHINE MOCKING RESULTS --->
<h1>Mocking State Machine of Results</h1>
<p>Three results will be mocked, and they will be called 11 times. The results should recycle every 3 calls</p>
<cfset test.mockMethod("getSetting").mockResults("S1","S2","S3")>

<cfloop from="1" to="11" index="callCounter">
	Call ###callCounter# -> #test.getSetting('XX')# <br />
</cfloop>

<hr/>
<!--- STUB OBJECTS OR PLACEHOLDERS OF FUNCTIONALITY --->
<h1>Mocking Stubs</h1>
<p>Create a stub object and add behavior:</p>
<cfset stub = mockBox.createStub()>
<cfset stub.mockMethod("getName","Luis Majano")>
<p>Stub Fake Get Name: #stub.getName()#</p>

<!--- PREPARE A MOCK FOR SPYING --->
<cfset Test = createObject("component","coldbox.testing.cases.testing.Test")>
<cfset mockBox.prepareMock(test)>
<h1>Mocking Spy Methods</h1>
UnMocked Spy -> Test.getData() = #test.getData()#<br />
UnMocked Spy Call -> Test.spyTest() = #test.spyTest()# <br />
<cfset test.$("getData").$results(1000)>
Mocked Spy Test.getData() = #test.getData()#<br />
Mocked Spy Call -> Test.spyTest() = #test.spyTest()# <br />

<hr />
<!--- MOCKING WITH ARGUMENTS --->
<cfset Test = mockBox.createMock("coldbox.testing.cases.testing.Test")>
<h1>Mocking With Specific ARguments</h1>
<p>
	Unmocked <strong>getSetting() method</strong>:<br />
	AppMapping = #test.getSetting("AppMapping")#<br />
	DebugMode = #test.getSetting("DebugMode")#<br />
</p>
<cfset test.$('getSetting').$args("AppMapping").$results("mockbox.testing")>
<cfset test.$('getSetting').$args("DebugMode").$results("true")>
<p>
	Mocking the <strong>getSetting() method</strong>:<br />
	AppMapping = #test.getSetting("AppMapping")# = mockbox.testing<br />
	DebugMode = #test.getSetting("DebugMode")# = true<br />
	Call Counts = #test.$count('getSetting')#
</p>


<!--- MOCKING A COLLABORATOR --->
<cfset Test = createObject("component","coldbox.testing.cases.testing.Test")>
<cfset mockCollaborator = MockBox.createMock(className="coldbox.testing.cases.testing.Collaborator")>
<cfset mockCollaborator.$("getDataFromDB").$results(queryNew(""))>
<cfset Test.setCollaborator(mockCollaborator)>
<cfdump var="#test.displayData()#">

<!--- PREPARE TEST FOR MOCCKING --->
<cfset Test.setCollaborator(structnew())>
<cfset mockBox.prepareMock(Test)>
<cfset Test.$property(propertyName="collaborator",mock=mockCollaborator)>
<cfdump var="#test.displayData()#">

</cfoutput>
